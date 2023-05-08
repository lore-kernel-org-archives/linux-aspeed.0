From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 8 May 2023 15:38:00 +0300
Subject: [PATCH v11 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <SEZPR06MB526906C3DAFFE0A8FA924AA7F2709@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230430041712.3247998-1-ryan_chen@aspeedtech.com>
 <20230430041712.3247998-3-ryan_chen@aspeedtech.com>
 <ZFFzRL/+73Ftix4Q@smile.fi.intel.com>
 <SEZPR06MB526906C3DAFFE0A8FA924AA7F2709@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <ZFjtKNtR3zveNIvY@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, May 07, 2023 at 02:21:10AM +0000, Ryan Chen wrote:
> > On Sun, Apr 30, 2023 at 12:17:12PM +0800, Ryan Chen wrote:

...

> > > +#define AST2600_GLOBAL_INIT				\
> > > +			(AST2600_I2CG_CTRL_NEW_REG |	\
> > > +			AST2600_I2CG_CTRL_NEW_CLK_DIV)
> > 
> > Make just a one TAB and put the last two lines on the single one.
> 
> Update by following. 
> 
> #define AST2600_GLOBAL_INIT		\
> 	(AST2600_I2CG_CTRL_NEW_REG |	\
> 	 AST2600_I2CG_CTRL_NEW_CLK_DIV)

As I mentioned the last two can occupy a single line.

...

> > > +	/* send start */
> > > +	dev_dbg(i2c_bus->dev, "[%d] %sing %d byte%s %s 0x%02x\n",
> > > +		i2c_bus->msgs_index, msg->flags & I2C_M_RD ? "read" : "write",
> > 
> > str_read_write() ?
> Sorry do you mean there have a function call str_read_write?
> Can you point me where it is for refer?

string_helpers.h.

> > > +		msg->len, msg->len > 1 ? "s" : "",
> > > +		msg->flags & I2C_M_RD ? "from" : "to", msg->addr);

...

> > > +				if (--i % 4 != 3)
> > > +					writel(*(u32 *)wbuf, i2c_bus->buf_base + i - (i % 4));
> > 
> > The above code is ugly. Can you think about it and write in a better way?
> Sorry, that is because the register only support for 4 byte align write.
> That the reason I need put for byte write to 4 byte align write.

Yes, that's fine. The problem is in _how_ the driver does it. We have a lot of
helpers in the kernel to access unaligned data.

...

> > > +	return ast2600_i2c_master_irq(i2c_bus) ? IRQ_HANDLED : IRQ_NONE;
> > 
> > IRQ_RETVAL() ?
> Sorry, most return is handled or not handled.
> Do you mean replace it just " return IRQ_RETVAL(ret);"

Have you had a chance to look in the implementation of IRQ_RETVAL() ?
I believe if you do, you will find the answer to your question.

...

> > > +	if (i2c_bus->mode == BUFF_MODE) {
> > > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > +		if (res && resource_size(res) >= 2) {
> > > +			i2c_bus->buf_base = devm_ioremap_resource(dev, res);
> > > +
> > > +			if (!IS_ERR_OR_NULL(i2c_bus->buf_base))
> > > +				i2c_bus->buf_size = resource_size(res) / 2;
> > > +		} else {
> > > +			i2c_bus->mode = BYTE_MODE;
> > > +		}
> > > +	}
> > 
> > Can be done without additional checks and with a simple call to
> > devm_platform_ioremap_resource(). No?
> > 
> Sorry, I can't catch your point, can you guide me more about it?

	if (BUFF_MODE) {
		void __iomem buf_base;

		buf_base = devm_platform_ioremap_and_get_resource(pdev, 1, &res);
		if (IS_ERR(buf_base))
			mode = BYTE_MODE;
		else {
			->buf_base = buf_base;
			->buf_size = ...
		}
	}

...

> > > +	ret = of_property_read_u32(dev->of_node, "clock-frequency",
> > &i2c_bus->bus_frequency);
> > > +	if (ret < 0) {
> > > +		dev_warn(dev, "Could not read clock-frequency property\n");
> > > +		i2c_bus->bus_frequency = 100000;
> > > +	}
> > 
> > There are macro for standard speeds. Moreover, there is a function to parse
> > properties, no need to open code.
> > 
> Will update
> ret = of_property_read_u32(dev->of_node, "clock-frequency", &bus_freq);
> if (ret < 0) {
>     dev_warn(dev, "Could not read clock-frequency property\n");
>     i2c_bus->bus_frequency = I2C_SPEED_STANDARD;
> } else {
>     i2c_bus->bus_frequency = bus_freq;
> }

No, just use the I2C core API to fill this property in the specific i2c_timings
structure.

-- 
With Best Regards,
Andy Shevchenko


