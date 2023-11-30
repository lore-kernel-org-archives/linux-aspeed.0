From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 30 Nov 2023 13:53:22 +0700
Subject: [PATCH v2 RESEND 1/2] i2c: aspeed: Fix unhandled Tx done with NAK
In-Reply-To: <20231129212552.3uy7oqm5fz5h2m6b@zenone.zhora.eu>
References: <20231128075236.2724038-1-quan@os.amperecomputing.com>
 <20231128075236.2724038-2-quan@os.amperecomputing.com>
 <20231129003542.jfhhotebweb3uwyb@zenone.zhora.eu>
 <3f37c359-1c71-421f-b7d9-054696735adc@os.amperecomputing.com>
 <20231129212552.3uy7oqm5fz5h2m6b@zenone.zhora.eu>
Message-ID: <9ec9b363-0e70-496e-9083-6382a579a0bf@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 30/11/2023 04:25, Andi Shyti wrote:
> Hi Quan,
> 
>> On 29/11/2023 07:35, Andi Shyti wrote:
>>> Hi Quan,
>>>
>>> On Tue, Nov 28, 2023 at 02:52:35PM +0700, Quan Nguyen wrote:
>>>> Under normal conditions, after the last byte is sent by the Slave, the
>>>> TX_NAK interrupt is raised.  However, it is also observed that
>>>> sometimes the Master issues the next transaction too quickly while the
>>>> Slave IRQ handler is not yet invoked and the TX_NAK interrupt for the
>>>> last byte of the previous READ_PROCESSED state has not been ack?ed.
>>>> This TX_NAK interrupt is then raised together with SLAVE_MATCH interrupt
>>>> and RX_DONE interrupt of the next coming transaction from Master. The
>>>> Slave IRQ handler currently handles the SLAVE_MATCH and RX_DONE, but
>>>> ignores the TX_NAK, causing complaints such as
>>>> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
>>>> 0x00000086, but was 0x00000084"
>>>>
>>>> This commit adds code to handle this case by emitting a SLAVE_STOP event
>>>> for the TX_NAK before processing the RX_DONE for the coming transaction
>>>> from the Master.
>>>>
>>>> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
>>>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>>>> ---
>>>> v2:
>>>>     + Split to separate series [Joel]
>>>>     + Added the Fixes line [Joel]
>>>>     + Revised commit message [Quan]
>>>>
>>>> v1:
>>>>     + First introduced in
>>>> https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/
>>>> ---
>>>>    drivers/i2c/busses/i2c-aspeed.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>>>> index 28e2a5fc4528..79476b46285b 100644
>>>> --- a/drivers/i2c/busses/i2c-aspeed.c
>>>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>>>> @@ -253,6 +253,11 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>>>>    	/* Slave was requested, restart state machine. */
>>>>    	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
>>>> +		if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
>>>> +		    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
>>>> +			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
>>>> +			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
>>>> +		}
>>>
>>> this is a duplicate of a later "if (...)" satement. What is the
>>> need for having them both?
>>>
>> Thanks Andi for the review.
>>
>> I assumed the if statement you mentioned is here in [1]. If so, then that is
>> not duplicate.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-aspeed.c?h=v6.7-rc3#n287
>>
>>
>> The if statement is to process the case when Slave sending data to Master
>> but being NAK, the I2C_SLAVE_STOP event will emit later in switch-case
>> statement. But it is only for the case INTR_TX_NAK without INTR_SLAVE_MATCH.
>>
>> The new code is for the case of INTR_TX_NAK with INTR_SLAVE_MATCH. What it
>> does is to detect if there is a mix of INTR_TX_NAK of previous i2c
>> transaction and the start of new i2c transaction, indicate by
>> INTR_SLAVE_MATCH which is only raised when Slave found its address matched
>> on the first byte it received. If so, the new code will try to emit the
>> I2C_SLAVE_STOP first to complete the previous transaction and process the
>> rest as a new request.
>>
>> So if this was the case (with INTR_SLAVE_MATCH), the INTR_RX_DONE should
>> always raise with INTR_SLAVE_MATCH because Slave did receive the data which
>> matched with its Slave address. And this will be translated into either
>> I2C_SLAVE_[READ|WRITE]_REQUESTED and that make the if statement you
>> mentioned [1] evaluate to false and skip.
>>
>> So, in short, the new code is trying to handle the case of INTR_TX_NAK with
>> INTR_SLAVE_MATCH first before let the rest process as normal.
> 
> yes, I saw that, but wasn't it easier to do something like this:
> 
> 	if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
> 	    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
> 		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
> 		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> 
> 		if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH)
> 			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
> 
> 	}
> 
> But I see that Andrew has done some similar comment, also for
> patch 2. You can answer both in the same mail, not to duplicate
> the answer :-)
> 
> We can wait for him to reply.
> 

I think Andrew's idea to handle the STOP conditions prior is much 
better. Will test and post the next version ASAP.

Thanks a lot for the review
- Quan
