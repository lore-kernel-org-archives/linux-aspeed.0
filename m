From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 29 Nov 2023 16:03:53 +0700
Subject: [PATCH v2 RESEND 1/2] i2c: aspeed: Fix unhandled Tx done with NAK
In-Reply-To: <4a9fe86f0349106adaa4e0c04c5839bab631f26c.camel@codeconstruct.com.au>
References: <20231128075236.2724038-1-quan@os.amperecomputing.com>
 <20231128075236.2724038-2-quan@os.amperecomputing.com>
 <4a9fe86f0349106adaa4e0c04c5839bab631f26c.camel@codeconstruct.com.au>
Message-ID: <99dff4f2-cfe1-4a3d-a10b-313b9e7a29b3@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 29/11/2023 07:19, Andrew Jeffery wrote:
> On Tue, 2023-11-28 at 14:52 +0700, Quan Nguyen wrote:
>> Under normal conditions, after the last byte is sent by the Slave, the
>> TX_NAK interrupt is raised.  However, it is also observed that
>> sometimes the Master issues the next transaction too quickly while the
>> Slave IRQ handler is not yet invoked and the TX_NAK interrupt for the
>> last byte of the previous READ_PROCESSED state has not been ack?ed.
>> This TX_NAK interrupt is then raised together with SLAVE_MATCH interrupt
>> and RX_DONE interrupt of the next coming transaction from Master. The
>> Slave IRQ handler currently handles the SLAVE_MATCH and RX_DONE, but
>> ignores the TX_NAK, causing complaints such as
>> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
>> 0x00000086, but was 0x00000084"
>>
>> This commit adds code to handle this case by emitting a SLAVE_STOP event
>> for the TX_NAK before processing the RX_DONE for the coming transaction
>> from the Master.
>>
>> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>> v2:
>>    + Split to separate series [Joel]
>>    + Added the Fixes line [Joel]
>>    + Revised commit message [Quan]
>>
>> v1:
>>    + First introduced in
>> https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/
>> ---
>>   drivers/i2c/busses/i2c-aspeed.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index 28e2a5fc4528..79476b46285b 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -253,6 +253,11 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>>   
>>   	/* Slave was requested, restart state machine. */
>>   	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
>> +		if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
>> +		    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
>> +			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
>> +			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
>> +		}
> 
> So we're already (partially) processing this a bit later on line 287:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-aspeed.c?h=v6.7-rc3#n287
> 

Thanks Andrew for the review.

I think it's worth noting that the byte mode is used in this case.

About the code you mentioned, it is for the general process of single 
Slave transmission with NAK which should be interpret as I2C_SLAVE_STOP 
event.

In this case, there is a mix of Slave events:

   + I2C_SLAVE_STOP (due to INTR_TX_NAK, BIT(1) of previous transaction)
   + Followed by I2C_SLAVE_[READ|WRITE]_REQUESTED (due to 
INTR_SLAVE_MATCH and INTR_RX_DONE, BIT(7) and BIT(2), of next transaction)

That is the reason we need to emit the I2C_SLAVE_STOP first for Slave 
backend to process.

>  From the description of the problem in the commit message it sounds
> like the ordering of the interrupt processing is incorrect. 

Yes, this is correct as per my explanation above.

Prior to
> this patch we have the following abstract ordering of interrupt
> processing:
> 
> 1. Process ASPEED_I2CD_INTR_SLAVE_MATCH
> 2. Process ASPEED_I2CD_INTR_TX_NAK when in ASPEED_I2C_SLAVE_READ_PROCESSED
> 

 From my test, the flow is as below:

   1. Process ASPEED_I2CD_INTR_SLAVE_MATCH, slave_state is set to 
ASPEED_I2C_SLAVE_START
   2. As there is INTR_RX_DONE and slave_state is 
ASPEED_I2C_SLAVE_START, depends on the data received, the slave_state 
moves to either ASPEED_I2C_SLAVE_[READ|WRITE]_REQUESTED.
   3. When reach to the if statement to process INTR_TX_NAK, slave_state 
is already moves to either ASPEED_I2C_SLAVE_[READ|WRITE]_REQUESTED, not 
in ASPEED_I2C_SLAVE_READ_PROCESSED anymore. This eventually evaluate as 
false and the if statement is bypass. IOW, this INTR_TX_NAK is not process.

> With this patch we have:
> 
> 1. If ASPEED_I2CD_INTR_SLAVE_MATCH then process ASPEED_I2CD_INTR_TX_NAK when in ASPEED_I2C_SLAVE_READ_PROCESSED
> 2. Process ASPEED_I2CD_INTR_SLAVE_MATCH
> 3. Process ASPEED_I2CD_INTR_TX_NAK when in ASPEED_I2C_SLAVE_READ_PROCESSED
> 

With this patch:

   0. The I2C_SLAVE_STOP is emitted to backend Slave driver first to 
complete the previous transaction. And let the rest process as before 
this patch.

   1. Process ASPEED_I2CD_INTR_SLAVE_MATCH, slave_state is set to 
ASPEED_I2C_SLAVE_START
   2. As there is INTR_RX_DONE and slave_state is 
ASPEED_I2C_SLAVE_START, depends on the data received, the slave_state 
moves to either ASPEED_I2C_SLAVE_[READ|WRITE]_REQUESTED.
   3. When reach to the if statement to process INTR_TX_NAK, slave_state 
is already moves to either ASPEED_I2C_SLAVE_[READ|WRITE]_REQUESTED, not 
in ASPEED_I2C_SLAVE_READ_PROCESSED anymore. This eventually evaluated as 
false and the if statement is bypass. IOW, this INTR_TX_NAK is not process.

> That feels a bit complex and redundant. What I think we can have is:
> 
> 1. Process ASPEED_I2CD_INTR_TX_NAK when in ASPEED_I2C_SLAVE_READ_PROCESSED
> 1. Process ASPEED_I2CD_INTR_SLAVE_MATCH
> 
> Moving back from the abstract to the concrete, implementing what I
> believe we need would look something like this patch:
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 28e2a5fc4528..98dd0f35c9d3 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -251,6 +251,14 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>   
>          command = readl(bus->base + ASPEED_I2C_CMD_REG);
>   
> +       /* Complete any active read */
> +       if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
> +           bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
> +               irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
> +               i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
> +               bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> +       }
> +

It is not confirmed through test yet but I'm afraid the switch case part 
will emit another I2C_SLAVE_STOP event in case there is no mix of 
interrupts.

>          /* Slave was requested, restart state machine. */
>          if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
>                  irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
> @@ -284,11 +292,6 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>                  irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
>                  bus->slave_state = ASPEED_I2C_SLAVE_STOP;
>          }
> -       if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
> -           bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
> -               irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
> -               bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> -       }
>   
>          switch (bus->slave_state) {
>          case ASPEED_I2C_SLAVE_READ_REQUESTED:
> 
> Thoughts? I haven't tested it, it's just something to throw darts at.
> 
> Andrew
> 
