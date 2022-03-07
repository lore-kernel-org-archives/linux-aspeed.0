From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 7 Mar 2022 15:30:42 +0700
Subject: [PATCH v6 6/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
In-Reply-To: <YcXLGYWx4gYq/Y+J@sirena.org.uk>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-7-quan@os.amperecomputing.com>
 <YcXLGYWx4gYq/Y+J@sirena.org.uk>
Message-ID: <e6644ea3-71b2-d045-be74-77792baf6dc2@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/12/2021 20:28, Mark Brown wrote:
> On Fri, Dec 24, 2021 at 11:13:49AM +0700, Quan Nguyen wrote:
> 
>> +static int read_i2c_block_data(struct i2c_client *client, u16 address, u16 length, u8 *data)
>> +{
>> +	unsigned char outbuf[MAX_READ_BLOCK_LENGTH];
>> +	unsigned char inbuf[2];
>> +	struct i2c_msg msgs[2];
>> +	ssize_t ret;
>> +
>> +	inbuf[0] = (address & 0xff);
>> +	inbuf[1] = length;
>> +
>> +	msgs[0].addr = client->addr;
>> +	msgs[0].flags = client->flags & I2C_M_TEN;
>> +	msgs[0].len = 2;
>> +	msgs[0].buf = inbuf;
>> +
>> +	msgs[1].addr = client->addr;
>> +	msgs[1].flags = (client->flags  & I2C_M_TEN) | I2C_M_RD;
>> +	msgs[1].len = length;
>> +	msgs[1].buf = outbuf;
>> +
>> +	ret = i2c_transfer(client->adapter, msgs, NUM_I2C_MESSAGES);
>> +	if (ret < 0)
> 
> regmap already supports bulk data access so it's not clear why we
> would open code this.  Given that this is a single I2C transfer
> it's also unclear why we'd need to export the regmap lock - a
> single I2C transfer is atomic at the bus level so the regmap lock
> isn't providing any additional concurrency protection.

Thanks a lot for the review, Mark.
Even though the single i2c transfer is atomic at the bus level, but my 
concerns is that the transfer may be interlaced with some other 
transaction from the regmap which was guarded by regmap's lock. And so 
making these accesses atomic in regmap level should be done as well. 
That is why I need the regmap's lock export for user driver.

But your comment made re-think about the code, and I think we can handle 
multiple types of transfer by using remap_bus->read/write(). The 
read_i2c_block_data() is now replaced by regmap_noinc_read() and hence, 
remove the use of regmap's lock. These changes will be included in my 
next version.

Thanks,
- Quan
