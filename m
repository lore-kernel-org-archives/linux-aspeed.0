From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 5 Jun 2020 16:23:51 +0200
Subject: [PATCH v3 01/43] drm/cma-helper: Rename symbols from
 drm_cma_gem_ to drm_gem_cma_
In-Reply-To: <8e2e8394-4110-9fb6-e99e-0495cf9f7218@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
 <20200605073247.4057-2-tzimmermann@suse.de>
 <20200605084026.GB11426@pendragon.ideasonboard.com>
 <8e2e8394-4110-9fb6-e99e-0495cf9f7218@suse.de>
Message-ID: <20200605142351.GA204352@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 05, 2020 at 04:15:46PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 05.06.20 um 10:40 schrieb Laurent Pinchart:
> > Hi Thomas,
> > 
> > Thank you for the patch.
> > 
> > On Fri, Jun 05, 2020 at 09:32:05AM +0200, Thomas Zimmermann wrote:
> >> This fixes the naming of several symbols within CMA helpers. No functional
> >> changes are made.
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > 
> > Thank you for the patch.
> > 
> > Speaking of naming, I wish we could rename drm_gem_cma_* to something
> > else, as those helpers don't use CMA directly (and may not use it at
> > all), but I think that would be too much intrusive changes for too
> > little gain :-(
> 
> I agree. Calling them GEM DMA helpers would be more precise. But I don't
> really see an easy solution without either a big patch that touches
> everything, or a lot of small patches with ugly intermediate states.
> 
> IMHO the best option would probably be an additional header file
> drm_gem_dma_helper.h that defines a dma name for each cma name. Drivers
> could then be converted individually with a single per-driver patch.

From todo.rst:

"
Rename CMA helpers to DMA helpers
---------------------------------

CMA (standing for contiguous memory allocator) is really a bit an accident of
what these were used for first, a much better name would be DMA helpers. In the
text these should even be called coherent DMA memory helpers (so maybe CDM, but
no one knows what that means) since underneath they just use dma_alloc_coherent.

Contact: Laurent Pinchart, Daniel Vetter

Level: Intermediate (mostly because it is a huge tasks without good partial
milestones, not technically itself that challenging)
"

The same?

	Sam

> 
> Best regards
> Thomas
> 
> > 
> >> ---
> >>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c |  2 +-
> >>  drivers/gpu/drm/drm_gem_cma_helper.c    | 10 +++++-----
> >>  include/drm/drm_gem_cma_helper.h        |  4 ++--
> >>  3 files changed, 8 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> >> index 6b27242b9ee3c..5e7ea0459d018 100644
> >> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> >> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> >> @@ -188,7 +188,7 @@ DEFINE_DRM_GEM_CMA_FOPS(fops);
> >>  
> >>  static struct drm_driver aspeed_gfx_driver = {
> >>  	.driver_features        = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> >> -	.gem_create_object	= drm_cma_gem_create_object_default_funcs,
> >> +	.gem_create_object	= drm_gem_cma_create_object_default_funcs,
> >>  	.dumb_create		= drm_gem_cma_dumb_create,
> >>  	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
> >>  	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
> >> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> >> index b3db3ca7bd7a7..842e2fa332354 100644
> >> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> >> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> >> @@ -572,7 +572,7 @@ void drm_gem_cma_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
> >>  }
> >>  EXPORT_SYMBOL_GPL(drm_gem_cma_prime_vunmap);
> >>  
> >> -static const struct drm_gem_object_funcs drm_cma_gem_default_funcs = {
> >> +static const struct drm_gem_object_funcs drm_gem_cma_default_funcs = {
> >>  	.free = drm_gem_cma_free_object,
> >>  	.print_info = drm_gem_cma_print_info,
> >>  	.get_sg_table = drm_gem_cma_prime_get_sg_table,
> >> @@ -581,7 +581,7 @@ static const struct drm_gem_object_funcs drm_cma_gem_default_funcs = {
> >>  };
> >>  
> >>  /**
> >> - * drm_cma_gem_create_object_default_funcs - Create a CMA GEM object with a
> >> + * drm_gem_cma_create_object_default_funcs - Create a CMA GEM object with a
> >>   *                                           default function table
> >>   * @dev: DRM device
> >>   * @size: Size of the object to allocate
> >> @@ -593,7 +593,7 @@ static const struct drm_gem_object_funcs drm_cma_gem_default_funcs = {
> >>   * A pointer to a allocated GEM object or an error pointer on failure.
> >>   */
> >>  struct drm_gem_object *
> >> -drm_cma_gem_create_object_default_funcs(struct drm_device *dev, size_t size)
> >> +drm_gem_cma_create_object_default_funcs(struct drm_device *dev, size_t size)
> >>  {
> >>  	struct drm_gem_cma_object *cma_obj;
> >>  
> >> @@ -601,11 +601,11 @@ drm_cma_gem_create_object_default_funcs(struct drm_device *dev, size_t size)
> >>  	if (!cma_obj)
> >>  		return NULL;
> >>  
> >> -	cma_obj->base.funcs = &drm_cma_gem_default_funcs;
> >> +	cma_obj->base.funcs = &drm_gem_cma_default_funcs;
> >>  
> >>  	return &cma_obj->base;
> >>  }
> >> -EXPORT_SYMBOL(drm_cma_gem_create_object_default_funcs);
> >> +EXPORT_SYMBOL(drm_gem_cma_create_object_default_funcs);
> >>  
> >>  /**
> >>   * drm_gem_cma_prime_import_sg_table_vmap - PRIME import another driver's
> >> diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
> >> index 947ac95eb24a9..64b7e9d42129a 100644
> >> --- a/include/drm/drm_gem_cma_helper.h
> >> +++ b/include/drm/drm_gem_cma_helper.h
> >> @@ -107,7 +107,7 @@ void *drm_gem_cma_prime_vmap(struct drm_gem_object *obj);
> >>  void drm_gem_cma_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
> >>  
> >>  struct drm_gem_object *
> >> -drm_cma_gem_create_object_default_funcs(struct drm_device *dev, size_t size);
> >> +drm_gem_cma_create_object_default_funcs(struct drm_device *dev, size_t size);
> >>  
> >>  /**
> >>   * DRM_GEM_CMA_VMAP_DRIVER_OPS - CMA GEM driver operations ensuring a virtual
> >> @@ -118,7 +118,7 @@ drm_cma_gem_create_object_default_funcs(struct drm_device *dev, size_t size);
> >>   * imported buffers.
> >>   */
> >>  #define DRM_GEM_CMA_VMAP_DRIVER_OPS \
> >> -	.gem_create_object	= drm_cma_gem_create_object_default_funcs, \
> >> +	.gem_create_object	= drm_gem_cma_create_object_default_funcs, \
> >>  	.dumb_create		= drm_gem_cma_dumb_create, \
> >>  	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd, \
> >>  	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle, \
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N?rnberg, Germany
> (HRB 36809, AG N?rnberg)
> Gesch?ftsf?hrer: Felix Imend?rffer
> 



