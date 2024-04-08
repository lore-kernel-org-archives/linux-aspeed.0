From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon, 8 Apr 2024 10:35:52 +0200
Subject: [PATCH 05/64] i2c: aspeed: reword according to newest
 specification
In-Reply-To: <vb4hempklviz6w4gd3eimprplybm4ckefwz2gyy7cp2uww2anv@b4egbq4u4rrg>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
 <20240322132619.6389-6-wsa+renesas@sang-engineering.com>
 <vb4hempklviz6w4gd3eimprplybm4ckefwz2gyy7cp2uww2anv@b4egbq4u4rrg>
Message-ID: <wcnu6qxxztplzpqtqc4t3bf53v6buto6ch6b5l5xoytrxxdgjz@gwzlifzzfrvx>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> > -static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> > +static int aspeed_i2c_xfer(struct i2c_adapter *adap,
> >  				  struct i2c_msg *msgs, int num)
> 
> here the alignment goes a bi off.

Thanks, I missed this.

> >  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> >  /* precondition: bus.lock has been acquired. */
> > -static void __aspeed_i2c_reg_slave(struct aspeed_i2c_bus *bus, u16 slave_addr)
> > +static void __aspeed_i2c_reg_target(struct aspeed_i2c_bus *bus, u16 slave_addr)
> 
> We  have the word master/slave forgotten here and there, but as
> we are here, /slave_addr/target_addr/

I can do this now. My plan was to convert it when I convert the whole
CONFIG_I2C_SLAVE interface. But "since we are here" can be argued.

> >  static const struct i2c_algorithm aspeed_i2c_algo = {
> > -	.master_xfer	= aspeed_i2c_master_xfer,
> > +	.xfer	= aspeed_i2c_xfer,
> 
> here the alignment goes a bit off.

I also wanted to fix this afterwards together with all the tab-indented
struct declarations in busses/. But maybe I better do the tab-removal
series beforehand? Would you accept such a thing?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240408/973687ee/attachment.sig>
