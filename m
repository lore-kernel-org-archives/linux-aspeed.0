From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 02 Feb 2021 12:38:45 +0800
Subject: [PATCH 1/2] drm/aspeed: Look up syscon by phandle
In-Reply-To: <20210111044638.290909-2-joel@jms.id.au>
References: <20210111044638.290909-1-joel@jms.id.au>
 <20210111044638.290909-2-joel@jms.id.au>
Message-ID: <8ff9f9d92271b25bd11cf473bf64466816efe93b.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

Sounds like a good idea! One comment though:

> @@ -111,10 +112,13 @@ static int aspeed_gfx_load(struct drm_device *drm)
> ????????if (IS_ERR(priv->base))
> ????????????????return PTR_ERR(priv->base);
> ?
> -???????priv->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2500-scu");
> +???????priv->scu = syscon_regmap_lookup_by_phandle(np, "syscon");
> ????????if (IS_ERR(priv->scu)) {
> -???????????????dev_err(&pdev->dev, "failed to find SCU regmap\n");
> -???????????????return PTR_ERR(priv->scu);
> +???????????????priv->scu = syscon_regmap_lookup_by_compatible("aspeed,aspeed-scu");

Is this (more generic) compatible value guaranteed to exist alongside
aspeed,ast2500-scu? The scu binding only specifies the model-specific
ones:

    Documentation/devicetree/bindings/mfd/aspeed-scu.txt:

    Required properties:
    - compatible:	One of:
                    "aspeed,ast2400-scu", "syscon", "simple-mfd"
                    "aspeed,ast2500-scu", "syscon", "simple-mfd"

- the only mention of the new compatible value that I can find is this
thread. Maybe we should retain the existing one to keep the fallback
case working?

Cheers,


Jeremy

