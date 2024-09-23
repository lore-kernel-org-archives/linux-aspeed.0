From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 23 Sep 2024 02:20:59 +0000
Subject: [PATCH v4 3/6] gpio: aspeed: Create llops to handle hardware
 access
In-Reply-To: <1333d8dd77c80825cb20bc5a9885a6ced774183b.camel@codeconstruct.com.au>
References: <20240919094339.2407641-1-billy_tsai@aspeedtech.com>
	 <20240919094339.2407641-4-billy_tsai@aspeedtech.com>
	 <7aaed8cf171b67300aa5b7e861628278de948a27.camel@codeconstruct.com.au>
	 <OSQPR06MB7252FDD739DCE7D4A44F63248B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <1333d8dd77c80825cb20bc5a9885a6ced774183b.camel@codeconstruct.com.au>
Message-ID: <OSQPR06MB725290B4D7BFC47A26A0E10B8B6F2@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > >
> > > > @@ -1191,6 +1203,9 @@ static int __init aspeed_gpio_probe(struct
> > > > platform_device *pdev)
> > > >
> > > >       gpio->config = gpio_id->data;
> > > >
> > > > +     if (!gpio->config->llops->reg_bit_set || !gpio->config-
> > > > >llops->reg_bits_get)
> > > > +             return -EINVAL;
> > > > +
> >
> > > This will need to clean up gpio->clk. Perhaps you could move it
> > > above
> > > the of_clk_get() call instead?
> >
> > How about change the `of_clk_get` to `devm_clk_get(&pdev->dev, 0);`?

> Yep.

> >
> > > However, looking through the rest it seems we have a few issues
> > > with
> > > this leak :/
> >
> > This gpio driver doesn't have the reset, is it?

> No, just leaking the resource.

> However, I can't see that we prepare/enable (and disable/unprepare) the
> clock either :( [1]. Do you mind fixing that as well? It would be best
> if debounce didn't work by accident.

> Andrew

> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/clk.h?h=v6.11#n527

Okay, I will update the clock API to use the `devm` prefix.

Thanks

Billy Tsai
