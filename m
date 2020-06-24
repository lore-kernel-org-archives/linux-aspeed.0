From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 24 Jun 2020 12:03:16 +0300
Subject: [PATCH v3 37/43] drm/tilcdc: Use GEM CMA object functions
In-Reply-To: <20200605073247.4057-38-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
 <20200605073247.4057-38-tzimmermann@suse.de>
Message-ID: <b66ccc2f-221f-5ae7-b60b-9e2b77a98fc7@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 05/06/2020 10:32, Thomas Zimmermann wrote:
> Create GEM objects with drm_gem_cma_create_object_default_funcs(), which
> allocates the object and sets CMA's default object functions. Corresponding
> callbacks in struct drm_driver are cleared. No functional changes are made.
> 
> Driver and object-function instances use the same callback functions, with
> the exception of vunmap. The implementation of vunmap is empty and left out
> in CMA's default object functions.
> 
> v3:
> 	* convert to DRIVER_OPS macro in a separate patch
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Emil Velikov <emil.velikov@collabora.com>

Reviewed-by: Jyri Sarha <jsarha@ti.com>
Tested-by: Jyri Sarha <jsarha@ti.com>

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index a5e9ee4c7fbf4..a6582325651bd 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -496,17 +496,12 @@ DEFINE_DRM_GEM_CMA_FOPS(fops);
>  static struct drm_driver tilcdc_driver = {
>  	.driver_features    = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>  	.irq_handler        = tilcdc_irq,
> -	.gem_free_object_unlocked = drm_gem_cma_free_object,
> -	.gem_print_info     = drm_gem_cma_print_info,
> -	.gem_vm_ops         = &drm_gem_cma_vm_ops,
> +	.gem_create_object  = drm_gem_cma_create_object_default_funcs,
>  	.dumb_create        = drm_gem_cma_dumb_create,
>  
>  	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
>  	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> -	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
>  	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
> -	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
>  	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
>  #ifdef CONFIG_DEBUG_FS
>  	.debugfs_init       = tilcdc_debugfs_init,
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
