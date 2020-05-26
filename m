From: Liviu Dudau <liviu.dudau@arm.com>
Date: Wed, 27 May 2020 00:30:21 +0100
Subject: [PATCH 03/21] drm/arm: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-4-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-4-tzimmermann@suse.de>
Message-ID: <20200526233021.GD159988@e110455-lin.cambridge.arm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 22, 2020 at 03:52:28PM +0200, Thomas Zimmermann wrote:
> The arm driver uses the default implementation for CMA functions. The
> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
> All remaining operations are provided by CMA GEM object functions.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks!
Liviu

> ---
>  drivers/gpu/drm/arm/hdlcd_drv.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index 194419f47c5e5..c83b81a3a582a 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -240,17 +240,7 @@ static struct drm_driver hdlcd_driver = {
>  	.irq_preinstall = hdlcd_irq_preinstall,
>  	.irq_postinstall = hdlcd_irq_postinstall,
>  	.irq_uninstall = hdlcd_irq_uninstall,
> -	.gem_free_object_unlocked = drm_gem_cma_free_object,
> -	.gem_print_info = drm_gem_cma_print_info,
> -	.gem_vm_ops = &drm_gem_cma_vm_ops,
> -	.dumb_create = drm_gem_cma_dumb_create,
> -	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> -	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_vmap = drm_gem_cma_prime_vmap,
> -	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
> -	.gem_prime_mmap = drm_gem_cma_prime_mmap,
> +	DRM_GEM_CMA_DRIVER_OPS,
>  #ifdef CONFIG_DEBUG_FS
>  	.debugfs_init = hdlcd_debugfs_init,
>  #endif
> -- 
> 2.26.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
