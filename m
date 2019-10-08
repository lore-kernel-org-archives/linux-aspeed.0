From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 8 Oct 2019 15:45:33 -0700
Subject: [PATCH 3/5] i2c: aspeed: fix master pending state handling
In-Reply-To: <422eea61-7cb9-e471-83fb-3f554ff5e079@fb.com>
References: <20191007231313.4700-1-jae.hyun.yoo@linux.intel.com>
 <20191007231313.4700-4-jae.hyun.yoo@linux.intel.com>
 <422eea61-7cb9-e471-83fb-3f554ff5e079@fb.com>
Message-ID: <6f280195-eef7-1fe7-ac42-ad6879ca9838@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Tao,

On 10/8/2019 3:00 PM, Tao Ren wrote:
> On 10/7/19 4:13 PM, Jae Hyun Yoo wrote:
>> In case of master pending state, it should not trigger the master
>> command because this H/W is sharing the same data buffer for slave
>> and master operations, so this commit fixes the issue with making
>> the master command triggering happen when the state goes to active
>> state.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
>>   drivers/i2c/busses/i2c-aspeed.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
>> index fa66951b05d0..40f6cf98d32e 100644
>> --- a/drivers/i2c/busses/i2c-aspeed.c
>> +++ b/drivers/i2c/busses/i2c-aspeed.c
>> @@ -336,18 +336,19 @@ static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
>>   	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
>>   	u8 slave_addr = i2c_8bit_addr_from_msg(msg);
>>   
>> -	bus->master_state = ASPEED_I2C_MASTER_START;
>> -
>>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
>>   	/*
>>   	 * If it's requested in the middle of a slave session, set the master
>>   	 * state to 'pending' then H/W will continue handling this master
>>   	 * command when the bus comes back to the idle state.
>>   	 */
>> -	if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
>> +	if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE) {
>>   		bus->master_state = ASPEED_I2C_MASTER_PENDING;
>> +		return;
>> +	}
>>   #endif /* CONFIG_I2C_SLAVE */
>>   
>> +	bus->master_state = ASPEED_I2C_MASTER_START;
>>   	bus->buf_index = 0;
>>   
>>   	if (msg->flags & I2C_M_RD) {
>> @@ -432,7 +433,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>>   		if (bus->slave_state != ASPEED_I2C_SLAVE_INACTIVE)
>>   			goto out_no_complete;
>>   
>> -		bus->master_state = ASPEED_I2C_MASTER_START;
>> +		aspeed_i2c_do_start(bus);
>>   	}
> 
> Shall we move the restart-master logic from master_irq to bus_irq? The reason being:
> master transaction cannot be restarted when aspeed-i2c is running in slave state and
> receives STOP interrupt, because aspeed_i2c_master_irq won't be called in this case.

Even in that case, master can be restarted properly because slave_irq
will be called first because master is in MASTER_PENDING state, so the
slave_irq handles the STOP interrupt as well, and then master_irq will
be called with SLAVE_INACTIVE state so the aspeed_i2c_do_start can be
called eventually.

Also, this is right point to call the aspeed_i2c_do_start
because master state will be changed to MASTER_START by the
aspeed_i2c_do_start and we have to do remaining handling for the
MASTER_START in the master_irq by falling through after the call.

Thanks,

Jae
