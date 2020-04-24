From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 24 Apr 2020 20:10:02 +0200
Subject: [PATCH 56/59] drm/aspeed: Use managed drmm_mode_config_cleanup
In-Reply-To: <20200415074034.175360-57-daniel.vetter@ffwll.ch>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
 <20200415074034.175360-57-daniel.vetter@ffwll.ch>
Message-ID: <20200424181002.GL7074@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 15, 2020 at 09:40:31AM +0200, Daniel Vetter wrote:
> Since aspeed doesn't use devm_kzalloc anymore we can use the managed
> mode config cleanup.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: linux-aspeed at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org

Hmm, the helper function makes no sense, maybe embed it?

One Q below. Whith Q addressed:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> ---
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index 6b27242b9ee3..6e464b84a256 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -63,15 +63,15 @@ static const struct drm_mode_config_funcs aspeed_gfx_mode_config_funcs = {
>  	.atomic_commit		= drm_atomic_helper_commit,
>  };
>  
> -static void aspeed_gfx_setup_mode_config(struct drm_device *drm)
> +static int aspeed_gfx_setup_mode_config(struct drm_device *drm)
>  {
> -	drm_mode_config_init(drm);
> -
>  	drm->mode_config.min_width = 0;
>  	drm->mode_config.min_height = 0;
>  	drm->mode_config.max_width = 800;
>  	drm->mode_config.max_height = 600;
>  	drm->mode_config.funcs = &aspeed_gfx_mode_config_funcs;
> +
> +	return drmm_mode_config_init(drm);

I do not see anything that documents that it is OK to init min/max
width/heigh not funcs before drmm_mode_config_init() is called.
Maybe drmm_mode_config_init() gain an memset(drm->mode_config),
and we loose all the assingments from before the call to init().

Also most (all?) other users of drmm_mode_config_init()
set them after the call to drmm_mode_config_init().
So re-order here and then embed while you are touching the code again.

	Sam

>  }
>  
>  static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)
> @@ -144,7 +144,9 @@ static int aspeed_gfx_load(struct drm_device *drm)
>  	writel(0, priv->base + CRT_CTRL1);
>  	writel(0, priv->base + CRT_CTRL2);
>  
> -	aspeed_gfx_setup_mode_config(drm);
> +	ret = aspeed_gfx_setup_mode_config(drm);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = drm_vblank_init(drm, 1);
>  	if (ret < 0) {
> @@ -181,7 +183,6 @@ static int aspeed_gfx_load(struct drm_device *drm)
>  static void aspeed_gfx_unload(struct drm_device *drm)
>  {
>  	drm_kms_helper_poll_fini(drm);
> -	drm_mode_config_cleanup(drm);
>  }
>  
>  DEFINE_DRM_GEM_CMA_FOPS(fops);
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
