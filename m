From: Liviu Dudau <liviu.dudau@arm.com>
Date: Wed, 27 May 2020 00:33:05 +0100
Subject: [PATCH 10/21] drm/komeda: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-11-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-11-tzimmermann@suse.de>
Message-ID: <20200526233305.GE159988@e110455-lin.cambridge.arm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 22, 2020 at 03:52:35PM +0200, Thomas Zimmermann wrote:
> The komeda driver uses the default implementation for CMA functions; except
> for the .dumb_create callback. The __DRM_GEM_CMA_DRIVER_OPS macro now sets
> these defaults and .dumb_create in struct drm_driver. All remaining
> operations are provided by CMA GEM object functions.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 6b85d5f4caa85..bdfbcbc416260 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -61,16 +61,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
>  static struct drm_driver komeda_kms_driver = {
>  	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>  	.lastclose			= drm_fb_helper_lastclose,
> -	.gem_free_object_unlocked	= drm_gem_cma_free_object,
> -	.gem_vm_ops			= &drm_gem_cma_vm_ops,
> -	.dumb_create			= komeda_gem_cma_dumb_create,
> -	.prime_handle_to_fd		= drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle		= drm_gem_prime_fd_to_handle,
> -	.gem_prime_get_sg_table		= drm_gem_cma_prime_get_sg_table,
> -	.gem_prime_import_sg_table	= drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_vmap			= drm_gem_cma_prime_vmap,
> -	.gem_prime_vunmap		= drm_gem_cma_prime_vunmap,
> -	.gem_prime_mmap			= drm_gem_cma_prime_mmap,
> +	__DRM_GEM_CMA_DRIVER_OPS(komeda_gem_cma_dumb_create),
>  	.fops = &komeda_cma_fops,
>  	.name = "komeda",
>  	.desc = "Arm Komeda Display Processor driver",
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
