From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 01 May 2019 21:57:02 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_1/3]_drm/aspeed:_Preserve_DVO_configuration_bits_du?=
 =?UTF-8?Q?ring_initialization?=
In-Reply-To: <1681003008.3393892.1556750962226.JavaMail.zimbra@raptorengineeringinc.com>
References: <1681003008.3393892.1556750962226.JavaMail.zimbra@raptorengineeringinc.com>
Message-ID: <a39f9067-740c-4177-bb20-b55778ccaf7b@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 2 May 2019, at 08:19, Timothy Pearson wrote:
> GFX064 contains DVO enable and mode bits.  These are hardware specific, 
> configured
> via the pinmux from the DT, and should not be cleared during startup.
> 
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c 
> b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index 713a3975852b..1a7a9a000e2e 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -98,6 +98,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
>  	struct aspeed_gfx *priv;
>  	struct resource *res;
>  	int ret;
> +	u32 reg;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -146,7 +147,9 @@ static int aspeed_gfx_load(struct drm_device *drm)
>  
>  	/* Sanitize control registers */
>  	writel(0, priv->base + CRT_CTRL1);
> -	writel(0, priv->base + CRT_CTRL2);
> +	/* Preserve CRT_CTRL2[7:6] (DVO configuration) */
> +	reg = readl(priv->base + CRT_CTRL2) & 0xc0;

I'd prefer we go the route of adding #defines for each bit, then OR'ing them
to create an appropriate mask. This seems a little opaque, even if we have
the comment.

> +	writel(reg, priv->base + CRT_CTRL2);
>  
>  	aspeed_gfx_setup_mode_config(drm);
>  
> -- 
> 2.11.0
> 
>
