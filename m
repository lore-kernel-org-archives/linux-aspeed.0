From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 16 Jan 2023 21:27:15 +0100
Subject: [PATCH 05/22] drm/aspeed: Remove unnecessary include statements
 for drm_crtc_helper.h
In-Reply-To: <20230116131235.18917-6-tzimmermann@suse.de>
References: <20230116131235.18917-1-tzimmermann@suse.de>
 <20230116131235.18917-6-tzimmermann@suse.de>
Message-ID: <Y8WzI8LNLHAbcUzl@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 16, 2023 at 02:12:18PM +0100, Thomas Zimmermann wrote:
> Several source files include drm_crtc_helper.h without needing it or
> only to get its transitive include statements; leading to unnecessary
> compile-time dependencies.
> 
> Directly include required headers and drop drm_crtc_helper.h where
> possible.

Nitpicking... The above is the standard text you use.
But in many cases, like this case, the patch just drop the wrong use of
the header and do not include any required headers.

If you want to rephrase for future changelog diggers or leave it as is,
is up to you.

	Sam

> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 1 -
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  | 1 -
>  drivers/gpu/drm/aspeed/aspeed_gfx_out.c  | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> index 55a3444a51d8..7877a57b8e26 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> @@ -5,7 +5,6 @@
>  #include <linux/reset.h>
>  #include <linux/regmap.h>
>  
> -#include <drm/drm_crtc_helper.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_fb_dma_helper.h>
>  #include <drm/drm_fourcc.h>
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index 718119e168a6..ecfb060d2557 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -14,7 +14,6 @@
>  #include <linux/reset.h>
>  
>  #include <drm/drm_atomic_helper.h>
> -#include <drm/drm_crtc_helper.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_fbdev_generic.h>
>  #include <drm/drm_gem_dma_helper.h>
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> index 4f2187025a21..78775e0c853f 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_out.c
> @@ -3,7 +3,6 @@
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_connector.h>
> -#include <drm/drm_crtc_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_probe_helper.h>
>  
> -- 
> 2.39.0
