From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 5 Jun 2020 11:13:05 +0300
Subject: [PATCH v3 32/43] drm/shmobile: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS
In-Reply-To: <20200605073247.4057-33-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
 <20200605073247.4057-33-tzimmermann@suse.de>
Message-ID: <20200605081305.GA10638@pendragon.ideasonboard.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas,

Thank you for the patch.

On Fri, Jun 05, 2020 at 09:32:36AM +0200, Thomas Zimmermann wrote:
> DRM_GEM_CMA_DRIVER_OPS sets the functions in struct drm_driver
> to their defaults. No functional changes are made.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Emil Velikov <emil.velikov@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> index e209610d4b8a1..26a15c214bd3f 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
> @@ -131,12 +131,7 @@ DEFINE_DRM_GEM_CMA_FOPS(shmob_drm_fops);
>  static struct drm_driver shmob_drm_driver = {
>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET,
>  	.irq_handler		= shmob_drm_irq,
> -	.gem_create_object	= drm_gem_cma_create_object_default_funcs,
> -	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
> -	.dumb_create		= drm_gem_cma_dumb_create,
> +	DRM_GEM_CMA_DRIVER_OPS,
>  	.fops			= &shmob_drm_fops,
>  	.name			= "shmob-drm",
>  	.desc			= "Renesas SH Mobile DRM",

-- 
Regards,

Laurent Pinchart
