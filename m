From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 Sep 2020 01:55:39 +0000
Subject: [PATCH 2/3] soc: aspeed: Add soc info driver
In-Reply-To: <aabf960e-33b3-4094-ad03-8305ca1794c7@www.fastmail.com>
References: <20200916084703.778386-1-joel@jms.id.au>
 <20200916084703.778386-3-joel@jms.id.au>
 <aabf960e-33b3-4094-ad03-8305ca1794c7@www.fastmail.com>
Message-ID: <CACPK8Xdgd-PyfW1pTMW7pebLUVGcbco1XAC_=xBAsDfVsYUGUg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2020 at 23:41, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Wed, 16 Sep 2020, at 18:17, Joel Stanley wrote:

> > +     np = of_find_compatible_node(NULL, NULL, "aspeed,silicon-id");
> > +     if (!of_device_is_available(np)) {
> > +             of_node_put(np);
> > +             return -ENODEV;
> > +     }
> > +
> > +     reg = of_iomap(np, 0);
> > +     if (!reg)
> > +             return -ENODEV;
> > +     siliconid = readl(reg);
> > +     of_node_put(np);
> > +     iounmap(reg);
> > +
> > +     /* This is optional, the ast2400 does not have it */
> > +     reg = of_iomap(np, 1);
>
> Use of np after of_node_put(np) above.
>
> > +     if (reg) {
> > +             has_chipid = true;
> > +             chipid[0] = readl(reg);
> > +             chipid[1] = readl(reg + 4);
> > +             iounmap(reg);
> > +             of_node_put(np);
>
> Double of_node_put() of np.

Good catch.

>
> > +     }
> > +
> > +     attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
> > +     if (!attrs)
> > +             return -ENODEV;
> > +
> > +     /*
> > +      * Machine: Romulus BMC
> > +      * Family: AST2500
> > +      * Revision: A1
> > +      * SoC ID: raw silicon revision id
> > +      * Serial Nnumber: 64-bit chipid
> > +      */
> > +
> > +     np = of_find_node_by_path("/");
> > +     of_property_read_string(np, "model", &machine);
> > +     if (machine)
> > +             attrs->machine = kstrdup(machine, GFP_KERNEL);
> > +     of_node_put(np);
> > +
> > +     attrs->family = kasprintf(GFP_KERNEL, "%s",
> > +                               siliconid_to_name(siliconid));
> > +
> > +     attrs->revision = kasprintf(GFP_KERNEL, "%s",
> > +                                 siliconid_to_rev(siliconid));
>
> `struct soc_device_attribute` declares these as `const char *` and the strings
> are constants in the driver, so is there any reason to use kasprintf() here?

The first iteration of the driver had more complex strings here, so it
was a hold over from that. As long as the strings returned from the
helpers stick around forever then we can do that.

Cheers,

Joel
