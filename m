From: Noralf Trønnes <noralf@tronnes.org>
Date: Tue, 11 Jan 2022 13:02:50 +0100
Subject: [PATCH v2 1/2] drm/mipi-dbi: Remove dependency on GEM CMA helper
 library
In-Reply-To: <20211106193509.17472-2-tzimmermann@suse.de>
References: <20211106193509.17472-2-tzimmermann@suse.de>
Message-ID: <a9e2d66e-1a85-b61f-ee3b-ca7032e0516f@tronnes.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> The MIPI DBI helpers access struct drm_gem_cma_object.vaddr in a
> few places. Replace all instances with the correct generic GEM
> functions. Use drm_gem_fb_vmap() for mapping a framebuffer's GEM
> objects and drm_gem_fb_vunmap() for unmapping them. This removes
> the dependency on CMA helpers within MIPI DBI.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_mipi_dbi.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c
b/drivers/gpu/drm/drm_mipi_dbi.c
> index 71b646c4131f..f80fd6c0ccf8 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -15,9 +15,10 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_damage_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_gem_cma_helper.h>
> +#include <drm/drm_file.h>
>  #include <drm/drm_format_helper.h>
>  #include <drm/drm_fourcc.h>
> +#include <drm/drm_gem.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_mipi_dbi.h>
>  #include <drm/drm_modes.h>
> @@ -200,13 +201,19 @@ int mipi_dbi_buf_copy(void *dst, struct
drm_framebuffer *fb,
>  		      struct drm_rect *clip, bool swap)
>  {
>  	struct drm_gem_object *gem = drm_gem_fb_get_obj(fb, 0);
> -	struct drm_gem_cma_object *cma_obj = to_drm_gem_cma_obj(gem);
> -	void *src = cma_obj->vaddr;
> +	struct dma_buf_map map[DRM_FORMAT_MAX_PLANES];
> +	struct dma_buf_map data[DRM_FORMAT_MAX_PLANES];
> +	void *src;
>  	int ret;
>
>  	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
>  	if (ret)
>  		return ret;
> +	src = data[0].vaddr; /* TODO: Use mapping abstraction properly */

This assignment should be after the _vmap() call. The MIPI DBI drivers
are currently broken because of this.

Noralf.

> +
> +	ret = drm_gem_fb_vmap(fb, map, data);
> +	if (ret)
> +		goto out_drm_gem_fb_end_cpu_access;
>
>  	switch (fb->format->format) {
>  	case DRM_FORMAT_RGB565:
> @@ -221,9 +228,11 @@ int mipi_dbi_buf_copy(void *dst, struct
drm_framebuffer *fb,
>  	default:
>  		drm_err_once(fb->dev, "Format is not supported: %p4cc\n",
>  			     &fb->format->format);
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
>
> +	drm_gem_fb_vunmap(fb, map);
> +out_drm_gem_fb_end_cpu_access:
>  	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
>
>  	return ret;
>
