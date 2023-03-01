From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 01 Mar 2023 08:58:43 +0800
Subject: [PATCH v4 3/5] clk: ast2600: Add full configs for I3C clocks
In-Reply-To: <CACPK8XfZCaLK+1kRkHa+wvGyt3YCwiZDR7CKRPKxdjuBFH+01Q@mail.gmail.com>
References: <20230228091638.206569-1-jk@codeconstruct.com.au>
	 <20230228091638.206569-4-jk@codeconstruct.com.au>
	 <CACPK8XfZCaLK+1kRkHa+wvGyt3YCwiZDR7CKRPKxdjuBFH+01Q@mail.gmail.com>
Message-ID: <1024ddf2c4047e5a6cd516809d4d15ea5e0349b6.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

Thanks for the review. Some replies inline:

> > @@ -15,7 +16,7 @@
> > 
> > ?#include "clk-aspeed.h"
> > 
> > -#define ASPEED_G6_NUM_CLKS???????????? 71
> > +#define ASPEED_G6_NUM_CLKS???????????? 72
> 
> NUM_CLKS seems dangerous. Should we instead use
> ARRAY_SIZE(aspeed_g6_gates)?

Yep, that would have saved me some time debugging. That would suit as a
separate change though, would you like it in the same series?

> > ??????? /* USB 2.0 port1 phy 40MHz clock */
> > ??????? hw = clk_hw_register_fixed_rate(NULL, "usb-phy-40m", NULL,
> > 0, 40000000);
> > ??????? aspeed_g6_clk_data->hws[ASPEED_CLK_USBPHY_40M] = hw;
> > +
> > +?????? /* i3c clock: source from apll, divide by 8 */
> > +?????? regmap_read(map, ASPEED_G6_CLK_SELECTION5, &val);
> > +?????? val &= ~(I3C_CLK_SELECTION | APLL_DIV_SELECTION);
> 
> Is there any value in registering a mux device here? See the emmc
> extclk device.

We won't be doing any mux configuration here, so I figure the static
setup is fine.

> > +?????? val |= FIELD_PREP(I3C_CLK_SELECTION,
> > I3C_CLK_SELECT_APLL_DIV);
> > +?????? val |= FIELD_PREP(APLL_DIV_SELECTION, APLL_DIV_8);
> > +?????? regmap_write(map, ASPEED_G6_CLK_SELECTION5, val);
> 
> This is a departure in style from the existing code. The existing
> code did things like this:
> 
> ??????? regmap_update_bits(map, ASPEED_G6_CLK_SELECTION1, GENMASK(10, 8), BIT(10));
> 
> Which uses the regmap API instead of FIELD_PREP macros.

Yep, that's much nicer, I'll change. The FIELD_PREP parts are just from
the initial ASPEED implementation.

Cheers,


Jeremy
