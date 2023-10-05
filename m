From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 5 Oct 2023 14:56:16 +0300
Subject: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <SEZPR06MB52699EC5463397F4BFF244DBF2CAA@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230714074522.23827-1-ryan_chen@aspeedtech.com>
 <20230714074522.23827-3-ryan_chen@aspeedtech.com>
 <ZLENe5B3gi/oNTQp@smile.fi.intel.com>
 <SEZPR06MB5269831E049E2267661F181FF2E8A@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <ZPcXJ4adUNMv4LDr@smile.fi.intel.com>
 <SEZPR06MB52699EC5463397F4BFF244DBF2CAA@SEZPR06MB5269.apcprd06.prod.outlook.com>
Message-ID: <ZR6kYMOB67+WJonG@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 05, 2023 at 06:21:35AM +0000, Ryan Chen wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Tuesday, September 5, 2023 7:55 PM
> > On Tue, Sep 05, 2023 at 06:52:37AM +0000, Ryan Chen wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: Friday, July 14, 2023 4:55 PM
> > > > On Fri, Jul 14, 2023 at 03:45:22PM +0800, Ryan Chen wrote:

...

> > > 			divisor = DIV_ROUND_UP(base_clk[3],
> > i2c_bus->timing_info.bus_freq_hz);
> > > 			for_each_set_bit(divisor, &divisor, 32) {
> > 
> > This is wrong.
> > 
> > > 				if ((divisor + 1) <= 32)
> > > 					break;
> > 
> > > 				divisor >>= 1;
> > 
> > And this.
> > 
> > > 				baseclk_idx++;
> > 
> > > 			}
> > 
> > for_each_set_bit() should use two different variables.
> 
> Will update by following.
> 
> for_each_set_bit(bit, &divisor, 32) {
>     divisor >>= 1;
>     baseclk_idx++;
> }

It's unclear what you are trying to achieve here as the code is not equivalent
to the above.

> > > 		} else {
> > > 			baseclk_idx = i + 1;
> > > 			divisor = DIV_ROUND_UP(base_clk[i],
> > i2c_bus->timing_info.bus_freq_hz);
> > > 		}
> > > 	}

...

> > > 	divisor = min_t(unsigned long, divisor, 32);
> > 
> > Can't you use min()? min_t is a beast with some subtle corner cases.
> > 
> Will update to 
> divisor = min(divisor, (unsigned long)32);

No, the idea behind min() is that _both_ arguments are of the same type,
the proposed above is wrong.

-- 
With Best Regards,
Andy Shevchenko


