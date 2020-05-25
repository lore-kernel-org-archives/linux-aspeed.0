From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 25 May 2020 14:49:46 +0200
Subject: [PATCH 15/21] drm/rcar-du: Use GEM CMA object functions
In-Reply-To: <20200522201240.GE5824@pendragon.ideasonboard.com>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-16-tzimmermann@suse.de>
 <20200522201240.GE5824@pendragon.ideasonboard.com>
Message-ID: <816a8a0e-bb98-ea6c-5016-94b18e045fb5@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 22.05.20 um 22:12 schrieb Laurent Pinchart:
> Hi Thomas,
> 
> Thank you for the patch.
> 
> On Fri, May 22, 2020 at 03:52:40PM +0200, Thomas Zimmermann wrote:
>> The rcar-du driver uses the default implementation for CMA functions;
>> except for the .dumb_create callback. The __DRM_GEM_CMA_DRIVER_OPS macro
>> now sets these defaults and .dumb_create in struct drm_driver. All
>> remaining operations are provided by CMA GEM object functions.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 11 +----------
>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> index 3e67cf70f0402..3728038cec1d1 100644
>> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
>> @@ -476,16 +476,7 @@ DEFINE_DRM_GEM_CMA_FOPS(rcar_du_fops);
>>  
>>  static struct drm_driver rcar_du_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>> -	.gem_free_object_unlocked = drm_gem_cma_free_object,
>> -	.gem_vm_ops		= &drm_gem_cma_vm_ops,
>> -	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
>> -	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
>> -	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
>> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
>> -	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
>> -	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
>> -	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
>> -	.dumb_create		= rcar_du_dumb_create,
>> +	__DRM_GEM_CMA_DRIVER_OPS(rcar_du_dumb_create),
> 
> Your __DRM_GEM_CMA_DRIVER_OPS is defined as
> 
> #define __DRM_GEM_CMA_DRIVER_OPS(__dumb_create) \
>         .gem_create_object      = drm_cma_gem_create_object_default_funcs, \
>         .dumb_create            = (__dumb_create), \
>         .prime_handle_to_fd     = drm_gem_prime_handle_to_fd, \
>         .prime_fd_to_handle     = drm_gem_prime_fd_to_handle, \
>         .gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table_vmap, \
>         .gem_prime_mmap         = drm_gem_prime_mmap
> 
> The patch thus introduces several changes:
> 
> - drm_gem_cma_prime_import_sg_table_vmap() is used instead of
>   drm_gem_cma_prime_import_sg_table() combined with .gem_prime_vmap()
>   and .gem_prime_vunmap(). I believe that's fine, but splitting that
>   change in a separate commit, or at the very least explaining it in
>   details in the commit message, would make review easier.
> 
> - .gem_create_object() is now set. That seems to be OK, but I'm not sure
>   to grasp all the implications. This should also be explained in the
>   commit message, and ideally split to a separate patch.

That's relevant during object creation and sets the object functions.
See one of my other replies for how this can go away after all CMA
drivers have been updated to GEM object functions.


> 
> - drm_gem_cma_prime_mmap() is replaced with drm_gem_prime_mmap(). Same
>   comments :-)

I relied on the aspeed driver to be correct. After Sam's comment on
that, I read the code once again several times. The original
implementation clears VM_PFNMAP. And I cannot find that code any longer.
Going back to the original function might be better.


> 
> This patch hides way too many changes in what is documented as just
> innocent refactoring. It seems other drivers are affected too.

Could you test the patchset? I don't have the HW.

Best regards
Thomas

> 
>>  	.fops			= &rcar_du_fops,
>>  	.name			= "rcar-du",
>>  	.desc			= "Renesas R-Car Display Unit",
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N?rnberg, Germany
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Felix Imend?rffer

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200525/7c94f342/attachment-0001.sig>
