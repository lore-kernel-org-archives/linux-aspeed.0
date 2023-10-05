From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 5 Oct 2023 06:21:35 +0000
Subject: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <ZPcXJ4adUNMv4LDr@smile.fi.intel.com>
References: <20230714074522.23827-1-ryan_chen@aspeedtech.com>
 <20230714074522.23827-3-ryan_chen@aspeedtech.com>
 <ZLENe5B3gi/oNTQp@smile.fi.intel.com>
 <SEZPR06MB5269831E049E2267661F181FF2E8A@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <ZPcXJ4adUNMv4LDr@smile.fi.intel.com>
Message-ID: <SEZPR06MB52699EC5463397F4BFF244DBF2CAA@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andy,
	appreciate your review and comments.

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, September 5, 2023 7:55 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: jk at codeconstruct.com.au; Brendan Higgins <brendan.higgins@linux.dev>;
> Benjamin Herrenschmidt <benh@kernel.crashing.org>; Joel Stanley
> <joel@jms.id.au>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Andrew Jeffery <andrew@aj.id.au>;
> Philipp Zabel <p.zabel@pengutronix.de>; Wolfram Sang <wsa@kernel.org>;
> linux-i2c at vger.kernel.org; Florian Fainelli <f.fainelli@gmail.com>; Jean
> Delvare <jdelvare@suse.de>; William Zhang <william.zhang@broadcom.com>;
> Tyrone Ting <kfting@nuvoton.com>; Tharun Kumar P
> <tharunkumar.pasumarthi@microchip.com>; Conor Dooley
> <conor.dooley@microchip.com>; Phil Edworthy <phil.edworthy@renesas.com>;
> openbmc at lists.ozlabs.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> =linux-kernel at vger.kernel.org; Andi Shyti <andi.shyti@kernel.org>
> Subject: Re: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
> mode driver
> 
> On Tue, Sep 05, 2023 at 06:52:37AM +0000, Ryan Chen wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Friday, July 14, 2023 4:55 PM
> > > On Fri, Jul 14, 2023 at 03:45:22PM +0800, Ryan Chen wrote:
> 
> ...
> 
> > > > +#define AST2600_I2CC_GET_RX_BUFF(x)			(((x) >> 8) &
> > > GENMASK(7, 0))
> > >
> > > > +#define AST2600_I2CC_GET_RX_BUF_LEN(x)		(((x) >> 24) &
> > > GENMASK(5, 0))
> > >
> > > > +#define AST2600_I2CC_GET_TX_BUF_LEN(x)		((((x) >> 8) &
> > > GENMASK(4, 0)) + 1)
> > >
> > > With right shifts it's better to have GENMASK to be applied first,
> > > it will show exact MSB of the bitfield.
> > >
> > > (Ditto for other cases similar to these)
> 
> > It will update next version.
> > #define AST2600_I2CC_GET_RX_BUF_LEN(x)      (((x) & GENMASK(29, 24))
> >> 24)
> > #define AST2600_I2CC_GET_TX_BUF_LEN(x)      ((((x) & GENMASK(12, 8))
> >> 8) + 1)
> 
> Note, these were just an example, check _all_ of the similar cases.
> 
> In general any reviewer's comment should be considered for the entire code
> where it makes sense.
> 

Sure, will check entire code.

> ...
> 
> > 			divisor = DIV_ROUND_UP(base_clk[3],
> i2c_bus->timing_info.bus_freq_hz);
> > 			for_each_set_bit(divisor, &divisor, 32) {
> 
> This is wrong.
> 
> > 				if ((divisor + 1) <= 32)
> > 					break;
> 
> > 				divisor >>= 1;
> 
> And this.
> 
> > 				baseclk_idx++;
> 
> > 			}
> 
> for_each_set_bit() should use two different variables.

Will update by following.

for_each_set_bit(bit, &divisor, 32) {
    divisor >>= 1;
    baseclk_idx++;
}

> 
> > 		} else {
> > 			baseclk_idx = i + 1;
> > 			divisor = DIV_ROUND_UP(base_clk[i],
> i2c_bus->timing_info.bus_freq_hz);
> > 		}
> > 	}
> 
> ...
> 
> > 	divisor = min_t(unsigned long, divisor, 32);
> 
> Can't you use min()? min_t is a beast with some subtle corner cases.
> 
Will update to 
divisor = min(divisor, (unsigned long)32);

> ...
> 
> > Sorry I don't catch this split slave out to separate change?
> > Do you mean go for another file name example ast2600_i2c_slave.c ?
> 
> No, I mean
> 
>  patch 1: Introduce the driver with only master support  patch 2: Add slave
> capability (all what is under ifdeffery for I2C_SLAVE)
> 
Got your point, will be separate patch. master -> slave added.
> ...
> 
> > static int ast2600_i2c_do_start(struct ast2600_i2c_bus *i2c_bus) {
> > 	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
> 
> > 	int ret;
> 
> This is not needed, you may return directly.
> 
> > 	/* send start */
> > 	dev_dbg(i2c_bus->dev, "[%d] %sing %d byte%s %s 0x%02x\n",
> > 		i2c_bus->msgs_index, str_read_write(msg->flags & I2C_M_RD),
> > 		msg->len, msg->len > 1 ? "s" : "",
> > 		msg->flags & I2C_M_RD ? "from" : "to", msg->addr);
> >
> > 	i2c_bus->master_xfer_cnt = 0;
> > 	i2c_bus->buf_index = 0;
> 
> > 	if (msg->flags & I2C_M_RD) {
> > 		if (i2c_bus->mode == DMA_MODE)
> > 			ret = ast2600_i2c_setup_dma_rx(i2c_bus);
> 
> 			return ...;
> 		if ...
> 
> 
> > 		else if (i2c_bus->mode == BUFF_MODE)
> > 			ret = ast2600_i2c_setup_buff_rx(i2c_bus);
> > 		else
> > 			ret = ast2600_i2c_setup_byte_rx(i2c_bus);
> 
> > 	} else {
> > 		if (i2c_bus->mode == DMA_MODE)
> > 			ret = ast2600_i2c_setup_dma_tx(AST2600_I2CM_START_CMD,
> i2c_bus);
> > 		else if (i2c_bus->mode == BUFF_MODE)
> > 			ret = ast2600_i2c_setup_buff_tx(AST2600_I2CM_START_CMD,
> i2c_bus);
> > 		else
> > 			ret = ast2600_i2c_setup_byte_tx(AST2600_I2CM_START_CMD,
> i2c_bus);
> 
> Same way.
> 
Yes, will update it.

> > 	}
> >
> > 	return ret;
> > }
> 
> ...
> 
> > > Wrong memory accessors. You should use something from
> > > asm/byteorder.h which includes linux/byteorder/generic.h.
> >
> > Sorry, about these parts. I quit no idea.
> > This is chip register limited, it only support dword write, not support byte
> write.
> > So the only way I have is use get_unaligned_le32 function get the byte buffer
> to align dword write.
> > Or I may need your help point me a good way.
> 
> >  	for (i = 0; i < xfer_len; i++) {
> >  		wbuf[i % 4] = msg->buf[i2c_bus->master_xfer_cnt + i];
> >  		if (i % 4 == 3) {
> >  			wbuf_dword = get_unaligned_le32(wbuf);
> >  			writel(wbuf_dword, i2c_bus->buf_base + i - 3);
> >  		}
> >  	}
> >
> >  	if (--i % 4 != 3) {
> >  		wbuf_dword = get_unaligned_le32(wbuf);
> >  		writel(wbuf_dword, i2c_bus->buf_base + i - (i % 4));
> >  	}
> 
> Something like that. The most problematic part in your original code is
> dereferencing byte memory as 32-bit memory with all possible problems
> behind.
> With this code it's gone. The code itself might be improved even more, you can
> think about it, you still have time (we are now in v6.7 cycle).
> 
Got it, let me find a better way, and also readable. 

> --
> With Best Regards,
> Andy Shevchenko
> 

