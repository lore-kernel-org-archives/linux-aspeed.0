From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 5 Jun 2020 11:14:35 +0300
Subject: [PATCH v3 30/43] drm/rcar-du: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE
In-Reply-To: <20200605073247.4057-31-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
 <20200605073247.4057-31-tzimmermann@suse.de>
Message-ID: <20200605081435.GB10638@pendragon.ideasonboard.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas,

Thank you for the patch.

On Fri, Jun 05, 2020 at 09:32:34AM +0200, Thomas Zimmermann wrote:
> DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE sets the functions in
> struct drm_driver to their defaults. No functional changes are
> made.
> 
> v2:
> 	* update for DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Acked-by: Emil Velikov <emil.velikov@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 43610d5bf8820..f53b0ec710850 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -476,12 +476,7 @@ DEFINE_DRM_GEM_CMA_FOPS(rcar_du_fops);
>  
>  static struct drm_driver rcar_du_driver = {
>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> -	.gem_create_object	= drm_gem_cma_create_object_default_funcs,
> -	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
> -	.dumb_create		= rcar_du_dumb_create,
> +	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(rcar_du_dumb_create),
>  	.fops			= &rcar_du_fops,
>  	.name			= "rcar-du",
>  	.desc			= "Renesas R-Car Display Unit",

-- 
Regards,

Laurent Pinchart
