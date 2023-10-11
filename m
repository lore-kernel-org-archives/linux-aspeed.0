From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 11 Oct 2023 08:17:56 +0000
Subject: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <SEZPR06MB5269464A3982E550D6DB8810F2CCA@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230714074522.23827-1-ryan_chen@aspeedtech.com>
 <20230714074522.23827-3-ryan_chen@aspeedtech.com>
 <ZLENe5B3gi/oNTQp@smile.fi.intel.com>
 <SEZPR06MB5269831E049E2267661F181FF2E8A@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <ZPcXJ4adUNMv4LDr@smile.fi.intel.com>
 <SEZPR06MB52699EC5463397F4BFF244DBF2CAA@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <ZR6kYMOB67+WJonG@smile.fi.intel.com>
 <SEZPR06MB5269464A3982E550D6DB8810F2CCA@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <SEZPR06MB5269B5372D1FBAC2D4119982F2CCA@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> 
> > On Thu, Oct 05, 2023 at 06:21:35AM +0000, Ryan Chen wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Tuesday, September 5, 2023 7:55 PM On Tue, Sep 05, 2023 at
> > > > 06:52:37AM +0000, Ryan Chen wrote:
> > > > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > Sent: Friday, July 14, 2023 4:55 PM On Fri, Jul 14, 2023 at
> > > > > > 03:45:22PM +0800, Ryan Chen wrote:
> >
> > ...
> >
> > > > > 			divisor = DIV_ROUND_UP(base_clk[3],
> > > > i2c_bus->timing_info.bus_freq_hz);
> > > > > 			for_each_set_bit(divisor, &divisor, 32) {
> > > >
> > > > This is wrong.
> > > >
> > > > > 				if ((divisor + 1) <= 32)
> > > > > 					break;
> > > >
> > > > > 				divisor >>= 1;
> > > >
> > > > And this.
> > > >
> > > > > 				baseclk_idx++;
> > > >
> > > > > 			}
> > > >
> > > > for_each_set_bit() should use two different variables.
> > >
> > > Will update by following.
> > >
> > > for_each_set_bit(bit, &divisor, 32) {
> > >     divisor >>= 1;
> > >     baseclk_idx++;
> > > }
> >
> > It's unclear what you are trying to achieve here as the code is not
> > equivalent to the above.
> >
> > > > > 		} else {
> > > > > 			baseclk_idx = i + 1;
> > > > > 			divisor = DIV_ROUND_UP(base_clk[i],
> > > > i2c_bus->timing_info.bus_freq_hz);
> > > > > 		}
> > > > > 	}
> >
> Hello Andy,
> 	I modify it to be simple way by following.
> 	Because baseclk_idx will be set to register [I2CD04[3:0]] that is indicate
> the 0~15 different base clk selection.
> 	So I initial the base_clk[15] array and assign initial clk value, and then find
> which clk idx will be right SCL clk selection.
> 
> 	000: pclk
> 	001: base_clk1
> 	002: base_clk2
> 	003: base_clk3
> 	004: base_clk4
> 	005: base_clk4/2
> 	006: base_clk4/4
> 	006: base_clk4/8
> 	.....
> 

Sorry updated.

> static u32 ast2600_select_i2c_clock(struct ast2600_i2c_bus *i2c_bus) {
> 	unsigned long base_clk[15];
	unsigned long base_clk[16];

> 	int baseclk_idx;
> 	u32 clk_div_reg;
> 	u32 scl_low;
> 	u32 scl_high;
> 	int divisor = 0;
> 	u32 data;
> 	int i;
> 
> 	regmap_read(i2c_bus->global_regs, AST2600_I2CG_CLK_DIV_CTRL,
> &clk_div_reg);
> 	base_clk[0] = i2c_bus->apb_clk;
> 	for (i = 1; i < 5; i++) {
> 		base_clk[i] = (i2c_bus->apb_clk * 2) /
> 			(((clk_div_reg >> (i * 8)) & GENMASK(7, 0)) + 2);
> 	}
> 	for (i = 5; i < 16; i++) {
> 		base_clk[i] = base_clk[4] / (1 << (i - 5));
> 	}
> 
> 	for (i = 0; i < 16; i++) {
> 		if ((base_clk[i] / i2c_bus->timing_info.bus_freq_hz) <= 32)
		{
			baseclk_idx = i;
			divisor = DIV_ROUND_UP(i2c_bus->apb_clk, i2c_bus->timing_info.bus_freq_hz);
		}
> 			break;
> 	}
> 	baseclk_idx = i;
> 	baseclk_idx = min(baseclk_idx, 15);
> 	divisor = min(divisor, 32);
> 	scl_low = min(divisor * 9 / 16 - 1, 15);
> 	scl_high = (divisor - scl_low - 2) & GENMASK(3, 0);
> 	data = (scl_high - 1) << 20 | scl_high << 16 | scl_low << 12 | baseclk_idx;
> 	if (i2c_bus->timeout) {
> 		data |= AST2600_I2CC_TOUTBASECLK(AST_I2C_TIMEOUT_CLK);
> 		data |= AST2600_I2CC_TTIMEOUT(i2c_bus->timeout);
> 	}
> 
> 	return data;
> }
> > ...
> >
> > > > > 	divisor = min_t(unsigned long, divisor, 32);
> > > >
> > > > Can't you use min()? min_t is a beast with some subtle corner cases.
> > > >
> > > Will update to
> > > divisor = min(divisor, (unsigned long)32);
> >
> > No, the idea behind min() is that _both_ arguments are of the same
> > type, the proposed above is wrong.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >

