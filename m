From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 02 Feb 2021 12:46:52 +0800
Subject: [PATCH 2/2] drm/aspeed: Use dt matching for default register
 values
In-Reply-To: <20210111044638.290909-3-joel@jms.id.au>
References: <20210111044638.290909-1-joel@jms.id.au>
 <20210111044638.290909-3-joel@jms.id.au>
Message-ID: <21b49b6a6303bf8c188929bb2cb328ecea33520f.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> There are minor differences in the values for the threshold value and
> the scan line size between families of ASPEED SoC. Additionally the
> SCU register for the output control differs between families.
> 
> This adds device tree matching to parameterise these values, allowing
> us to add support for the AST2400 now, and in the future the AST2600.

Looks good to me. Two super minor things:

> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> @@ -60,7 +60,8 @@ static void aspeed_gfx_enable_controller(struct
> aspeed_gfx *priv)
> ????????u32 ctrl2 = readl(priv->base + CRT_CTRL2);
> ?
> ????????/* SCU2C: set DAC source for display output to Graphics CRT (GFX) */
> -???????regmap_update_bits(priv->scu, 0x2c, BIT(16), BIT(16));
> +???????regmap_update_bits(priv->scu, priv->dac_reg, BIT(16), BIT(16));

The comment references SCU2C; but you've implied that this will
change...

> @@ -228,7 +258,7 @@ static ssize_t dac_mux_store(struct device *dev,
> struct device_attribute *attr,
> ????????if (val > 3)
> ????????????????return -EINVAL;
> ?
> -???????rc = regmap_update_bits(priv->scu, ASPEED_SCU_MISC_CTRL, 0x30000, val << 16);
> +???????rc = regmap_update_bits(priv->scu, priv->dac_reg, 0x30000, val << 16);
> ????????if (rc < 0)
> ????????????????return 0;
> ?
> @@ -241,7 +271,7 @@ static ssize_t dac_mux_show(struct device *dev,
> struct device_attribute *attr, c
> ????????u32 reg;
> ????????int rc;
> ?
> -???????rc = regmap_read(priv->scu, ASPEED_SCU_MISC_CTRL, &reg);
> +???????rc = regmap_read(priv->scu, priv->dac_reg, &reg);
> ????????if (rc)
> ????????????????return rc;

You've removed the only uses of ASPEED_SCU_MISC_CTRL here, maybe drop
the #define too?

Regardless:

Reviewed-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy


