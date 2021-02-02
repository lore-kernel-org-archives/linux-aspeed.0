From: Joel Stanley <joel@jms.id.au>
Date: Tue, 2 Feb 2021 05:00:00 +0000
Subject: [PATCH 1/2] drm/aspeed: Look up syscon by phandle
In-Reply-To: <8ff9f9d92271b25bd11cf473bf64466816efe93b.camel@ozlabs.org>
References: <20210111044638.290909-1-joel@jms.id.au>
 <20210111044638.290909-2-joel@jms.id.au>
 <8ff9f9d92271b25bd11cf473bf64466816efe93b.camel@ozlabs.org>
Message-ID: <CACPK8XeTZ7kNPL4dWUJT44Zd+69VJ3FCMb7K=t6L0apwQOM1kQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2 Feb 2021 at 04:39, Jeremy Kerr <jk@ozlabs.org> wrote:
>
> Hi Joel,
>
> Sounds like a good idea! One comment though:
>
> > @@ -111,10 +112,13 @@ static int aspeed_gfx_load(struct drm_device *drm)
> >         if (IS_ERR(priv->base))
> >                 return PTR_ERR(priv->base);
> >
> > -       priv->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2500-scu");
> > +       priv->scu = syscon_regmap_lookup_by_phandle(np, "syscon");
> >         if (IS_ERR(priv->scu)) {
> > -               dev_err(&pdev->dev, "failed to find SCU regmap\n");
> > -               return PTR_ERR(priv->scu);
> > +               priv->scu = syscon_regmap_lookup_by_compatible("aspeed,aspeed-scu");
>
> Is this (more generic) compatible value guaranteed to exist alongside
> aspeed,ast2500-scu? The scu binding only specifies the model-specific
> ones:
>
>     Documentation/devicetree/bindings/mfd/aspeed-scu.txt:
>
>     Required properties:
>     - compatible:       One of:
>                     "aspeed,ast2400-scu", "syscon", "simple-mfd"
>                     "aspeed,ast2500-scu", "syscon", "simple-mfd"
>
> - the only mention of the new compatible value that I can find is this
> thread. Maybe we should retain the existing one to keep the fallback
> case working?

Yes, it was a mistake to change ast2500-scu to aspeed-scu. The only
reason to keep the lookup_by_compatible was to decouple this patch
from the device tree changes.

I will send a v2 with syscon_regmap_lookup_by_compatible("aspeed,ast2500-scu").
