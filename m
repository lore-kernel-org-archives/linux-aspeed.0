From: Philippe CORNU <philippe.cornu@st.com>
Date: Tue, 26 May 2020 13:22:18 +0000
Subject: [PATCH 17/21] drm/stm: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-18-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-18-tzimmermann@suse.de>
Message-ID: <ee29b996-77ec-9ada-2e96-090399dc5383@st.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/22/20 3:52 PM, Thomas Zimmermann wrote:
> The stm driver uses the default implementation for CMA functions; except
> for the .dumb_create callback. The __DRM_GEM_CMA_DRIVER_OPS macro now sets
> these defaults and .dumb_create in struct drm_driver. All remaining
> operations are provided by CMA GEM object functions.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/stm/drv.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 0f85dd86cafa7..d6238c71fabf6 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -62,16 +62,7 @@ static struct drm_driver drv_driver = {
>   	.minor = 0,
>   	.patchlevel = 0,
>   	.fops = &drv_driver_fops,
> -	.dumb_create = stm_gem_cma_dumb_create,
> -	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> -	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> -	.gem_free_object_unlocked = drm_gem_cma_free_object,
> -	.gem_vm_ops = &drm_gem_cma_vm_ops,
> -	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
> -	.gem_prime_vmap = drm_gem_cma_prime_vmap,
> -	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
> -	.gem_prime_mmap = drm_gem_cma_prime_mmap,
> +	__DRM_GEM_CMA_DRIVER_OPS(stm_gem_cma_dumb_create),
>   };
>   
>   static int drv_load(struct drm_device *ddev)
> 
Hi Thomas,
Thank you for the patch.
Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
Philippe :-)
