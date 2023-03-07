From: sarha@kapsi.fi <sarha@kapsi.fi>
Date: Tue, 07 Mar 2023 14:06:52 +0000
Subject: [PATCH 18/22] drm/tilcdc: Use GEM DMA fbdev emulation
Message-ID: <25a439e6a6d58701e5a73b33ed0d7a4a0d9a68e2@kapsi.fi>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

March 1, 2023 at 5:30 PM, "Thomas Zimmermann" <tzimmermann at suse.de mailto:tzimmermann@suse.de?to=%22Thomas%20Zimmermann%22%20%3Ctzimmermann%40suse.de%3E > wrote:

> 
> Use the fbdev emulation that is optimized for DMA helpers. Avoids
> possible shadow buffering and makes the code simpler.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 

Acked-by: Jyri Sarha <jyri.s

> 
> ---
> drivers/gpu/drm/tilcdc/tilcdc_drv.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index 4ca426007dc8..fe56beea3e93 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -16,7 +16,7 @@
> #include <drm/drm_atomic_helper.h>
> #include <drm/drm_debugfs.h>
> #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_dma.h>
> #include <drm/drm_fourcc.h>
> #include <drm/drm_gem_dma_helper.h>
> #include <drm/drm_gem_framebuffer_helper.h>
> @@ -384,7 +384,7 @@ static int tilcdc_init(const struct drm_driver *ddrv, struct device *dev)
> goto init_failed;
> priv->is_registered = true;
> 
> - drm_fbdev_generic_setup(ddev, bpp);
> + drm_fbdev_dma_setup(ddev, bpp);
> return 0;
> 
> init_failed:
> -- 
> 2.39.2
>
