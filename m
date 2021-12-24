From: Mark Brown <broonie@kernel.org>
Date: Fri, 24 Dec 2021 13:28:57 +0000
Subject: [PATCH v6 6/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
In-Reply-To: <20211224041352.29405-7-quan@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-7-quan@os.amperecomputing.com>
Message-ID: <YcXLGYWx4gYq/Y+J@sirena.org.uk>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 24, 2021 at 11:13:49AM +0700, Quan Nguyen wrote:

> +static int read_i2c_block_data(struct i2c_client *client, u16 address, u16 length, u8 *data)
> +{
> +	unsigned char outbuf[MAX_READ_BLOCK_LENGTH];
> +	unsigned char inbuf[2];
> +	struct i2c_msg msgs[2];
> +	ssize_t ret;
> +
> +	inbuf[0] = (address & 0xff);
> +	inbuf[1] = length;
> +
> +	msgs[0].addr = client->addr;
> +	msgs[0].flags = client->flags & I2C_M_TEN;
> +	msgs[0].len = 2;
> +	msgs[0].buf = inbuf;
> +
> +	msgs[1].addr = client->addr;
> +	msgs[1].flags = (client->flags  & I2C_M_TEN) | I2C_M_RD;
> +	msgs[1].len = length;
> +	msgs[1].buf = outbuf;
> +
> +	ret = i2c_transfer(client->adapter, msgs, NUM_I2C_MESSAGES);
> +	if (ret < 0)

regmap already supports bulk data access so it's not clear why we
would open code this.  Given that this is a single I2C transfer
it's also unclear why we'd need to export the regmap lock - a
single I2C transfer is atomic@the bus level so the regmap lock
isn't providing any additional concurrency protection.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211224/86f8c99e/attachment.sig>
