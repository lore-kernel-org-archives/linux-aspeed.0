From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 24 Jun 2020 12:03:29 +0300
Subject: [PATCH v3 38/43] drm/tilcdc: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS
In-Reply-To: <20200605073247.4057-39-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
 <20200605073247.4057-39-tzimmermann@suse.de>
Message-ID: <44a68de2-b176-f1c6-3865-ccd092ca3353@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/06/2020 10:32, Thomas Zimmermann wrote:
> DRM_GEM_CMA_DRIVER_OPS sets the functions in struct drm_driver
> to their defaults. No functional changes are made.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Emil Velikov <emil.velikov@collabora.com>

Reviewed-by: Jyri Sarha <jsarha@ti.com>
Tested-by: Jyri Sarha <jsarha@ti.com>

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index a6582325651bd..0d74a64432633 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -496,13 +496,7 @@ DEFINE_DRM_GEM_CMA_FOPS(fops);
>  static struct drm_driver tilcdc_driver = {
>  	.driver_features    = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>  	.irq_handler        = tilcdc_irq,
> -	.gem_create_object  = drm_gem_cma_create_object_default_funcs,
> -	.dumb_create        = drm_gem_cma_dumb_create,
> -
> -	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
> +	DRM_GEM_CMA_DRIVER_OPS,
>  #ifdef CONFIG_DEBUG_FS
>  	.debugfs_init       = tilcdc_debugfs_init,
>  #endif
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
