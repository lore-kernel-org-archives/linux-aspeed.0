From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 11 Dec 2023 11:08:52 +0700
Subject: [PATCH v3 1/2] i2c: aspeed: Handle the coalesced stop conditions
 with the start conditions.
In-Reply-To: <79ce9162faeb113ecb13efeb58d95f8a71e1a060.camel@codeconstruct.com.au>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
 <20231208033142.1673232-2-quan@os.amperecomputing.com>
 <79ce9162faeb113ecb13efeb58d95f8a71e1a060.camel@codeconstruct.com.au>
Message-ID: <43c99449-8a4b-4db5-8b1e-bc7ae920db76@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 08/12/2023 10:56, Andrew Jeffery wrote:
> On Fri, 2023-12-08 at 10:31 +0700, Quan Nguyen wrote:
>> Some masters may drive the transfers with low enough latency between
>> the nak/stop phase of the current command and the start/address phase
>> of the following command that the interrupts are coalesced by the
>> time we process them.
>> Handle the stop conditions before processing SLAVE_MATCH to fix the
>> complaints that sometimes occur below.
>>
>> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
>> 0x00000086, but was 0x00000084"
>>
>> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
>> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
>> ---
>> v3:
>>    + Change to handle the coalesced stop condition with the start
>> conditions                                                            [Andrew]
>>    + Revised commit message                                              [Quan]
>>
>> v2:
>>    + Split to separate series                                            [Joel]
>>    + Added the Fixes line                                                [Joel]
>>    + Revised commit message                                              [Quan]
>>
>> v1:
>>    + First introduced in
>> https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/
>> ---
>>   drivers/i2c/busses/i2c-aspeed.c | 47 ++++++++++++++++++++++-----------
>>   1 file changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index 28e2a5fc4528..1c2a4f4c4e1b 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -249,18 +249,45 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>>   	if (!slave)
>>   		return 0;
>>   
>> -	command = readl(bus->base + ASPEED_I2C_CMD_REG);
>> +	/*
>> +	 * Handle stop conditions early, prior to SLAVE_MATCH. Some masters may drive
>> +	 * transfers with low enough latency between the nak/stop phase of the current
>> +	 * command and the start/address phase of the following command that the
>> +	 * interrupts are coalesced by the time we process them.
>> +	 */
>> +	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
>> +		irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
>> +		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
>> +	}
>>   
>> -	/* Slave was requested, restart state machine. */
>> +	if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
>> +	    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
>> +		irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
>> +		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
>> +	}
>> +
>> +	/* Propagate any stop conditions to the slave implementation. */
>> +	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
>> +		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
>> +		bus->slave_state = ASPEED_I2C_SLAVE_INACTIVE;
>> +	}
>> +	/*
> 
> If there's a reason to do a v4 then an extra empty line above the
> comment would be nice. But let's not get hung up on that if everyone
> else is happy.
> 
> Thanks for the fixes!
> 
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> 

Thanks Andrew,

I'll add your Reviewed-by in my v4 with that extra empty lime before the 
comment.

Thanks for the review
- Quan
