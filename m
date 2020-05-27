From: Paul Cercueil <paul@crapouillou.net>
Date: Wed, 27 May 2020 02:28:31 +0200
Subject: [PATCH 09/21] drm/ingenic: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-10-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-10-tzimmermann@suse.de>
Message-ID: <JZRYAQ.1QIOMTT6TPVS1@crapouillou.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas,

Le ven. 22 mai 2020 ? 15:52, Thomas Zimmermann <tzimmermann@suse.de> a 
?crit :
> The ingenic driver uses the default implementation for CMA functions. 
> The
> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct 
> drm_driver.
> All remaining operations are provided by CMA GEM object functions.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Tested-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/gpu/drm/ingenic/ingenic-drm.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c 
> b/drivers/gpu/drm/ingenic/ingenic-drm.c
> index eff57a1f70fb0..1c1cee367b752 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
> @@ -519,18 +519,7 @@ static struct drm_driver ingenic_drm_driver_data 
> = {
>  	.patchlevel		= 0,
> 
>  	.fops			= &ingenic_drm_fops,
> -
> -	.dumb_create		= drm_gem_cma_dumb_create,
> -	.gem_free_object_unlocked = drm_gem_cma_free_object,
> -	.gem_vm_ops		= &drm_gem_cma_vm_ops,
> -
> -	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> -	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
> -	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
> -	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
> +	DRM_GEM_CMA_DRIVER_OPS,
> 
>  	.irq_handler		= ingenic_drm_irq_handler,
>  };
> --
> 2.26.2
> 


