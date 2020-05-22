From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 May 2020 21:03:19 +0200
Subject: [PATCH 21/21] drm/zte: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-22-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-22-tzimmermann@suse.de>
Message-ID: <20200522190319.GA1516455@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas.

On Fri, May 22, 2020 at 03:52:46PM +0200, Thomas Zimmermann wrote:
> The zte driver uses the default implementation for CMA functions. The
> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
> All remaining operations are provided by CMA GEM object functions.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/zte/zx_drm_drv.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/zte/zx_drm_drv.c b/drivers/gpu/drm/zte/zx_drm_drv.c
> index 1141c1ed1ed04..42c59eae0ea03 100644
> --- a/drivers/gpu/drm/zte/zx_drm_drv.c
> +++ b/drivers/gpu/drm/zte/zx_drm_drv.c
> @@ -36,16 +36,7 @@ DEFINE_DRM_GEM_CMA_FOPS(zx_drm_fops);
>  
>  static struct drm_driver zx_drm_driver = {
>  	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> -	.gem_free_object_unlocked = drm_gem_cma_free_object,
> -	.gem_vm_ops = &drm_gem_cma_vm_ops,
> -	.dumb_create = drm_gem_cma_dumb_create,
> -	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> -	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_vmap = drm_gem_cma_prime_vmap,
> -	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
> -	.gem_prime_mmap = drm_gem_cma_prime_mmap,
> +	DRM_GEM_CMA_VMAP_DRIVER_OPS,
s/_VMAP// as pointed out by Emil.

	Sam

>  	.fops = &zx_drm_fops,
>  	.name = "zx-vou",
>  	.desc = "ZTE VOU Controller DRM",
> -- 
> 2.26.2
