From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 01 Mar 2023 16:17:39 +0800
Subject: [PATCH v4 3/5] clk: ast2600: Add full configs for I3C clocks
In-Reply-To: <1024ddf2c4047e5a6cd516809d4d15ea5e0349b6.camel@codeconstruct.com.au>
References: <20230228091638.206569-1-jk@codeconstruct.com.au>
	 <20230228091638.206569-4-jk@codeconstruct.com.au>
	 <CACPK8XfZCaLK+1kRkHa+wvGyt3YCwiZDR7CKRPKxdjuBFH+01Q@mail.gmail.com>
	 <1024ddf2c4047e5a6cd516809d4d15ea5e0349b6.camel@codeconstruct.com.au>
Message-ID: <f5c9ecb7b1a850b196dfd3a5207f03226f514721.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> > > @@ -15,7 +16,7 @@
> > > 
> > > ?#include "clk-aspeed.h"
> > > 
> > > -#define ASPEED_G6_NUM_CLKS???????????? 71
> > > +#define ASPEED_G6_NUM_CLKS???????????? 72
> > 
> > NUM_CLKS seems dangerous. Should we instead use
> > ARRAY_SIZE(aspeed_g6_gates)?
> 
> Yep, that would have saved me some time debugging. That would suit as
> a separate change though, would you like it in the same series?

No wait, it's not just ARRAY_SIZE(aspeed_g6_gates), there's a bunch of
manually-configured clocks in the aspeed_g6_clk_data->hws[] array too.

This might require a bit more of a restructure if we want to get rid of
the NUM_CLKS definitions...

Cheers,


Jeremy
