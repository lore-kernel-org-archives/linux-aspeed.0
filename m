From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 25 May 2020 14:03:39 +0200
Subject: [PATCH 01/21] drm/cma-helper: Rework DRM_GEM_CMA_VMAP_DRIVER_OPS
 macro
In-Reply-To: <20200522174835.GA1087580@ravnborg.org>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-2-tzimmermann@suse.de>
 <20200522174835.GA1087580@ravnborg.org>
Message-ID: <b6f36f00-b68f-b111-5bcd-55c2658b1f27@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Sam

Am 22.05.20 um 19:48 schrieb Sam Ravnborg:
> Hi Thomas.
> 
> On Fri, May 22, 2020 at 03:52:26PM +0200, Thomas Zimmermann wrote:
>> Rename the macro to DRM_GEM_CMA_DRIVER_OPS to align with SHMEM
>> helpers.
> This part is fine, I like that the naming is somehow consistent.
> 
>> An internal version is provided for drivers that override
>> the default .dumb_create callback. Adapt drivers to the changes.
> I loathe anything named __foo or __FOO. This __ signals to me
> that the author was clueless in naming - or some sort.
> I know that __ is used in some lib headers - but thats not the case
> here.

I agree with your comment and I've been trying to find a better name
before posting the patchset. I considered something like
DRM_GEM_CMA_DRIVER_OPS_INTERNAL(), but wasn't happy with that either. In
the end, I uses the double underscore to push driver authors towards the
other macro. This one's only for the special case of settings a separate
implementation for .dumb_create().

> 
> But I love that we have a variant that takes a create function.
> So we do not have to escape from the nice macro.
> The macro is another way to tell me as rewiewer that this
> drivers uses all the default helpers for this.
> 
> 
> So critizising the name I better suggest something that
> I personally like better:
> 
> DRM_GEM_CMA_DRIVER_OPS_CREATE()

Can we at least use DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE ? Because
there's also gem_object_create.

I'll update the patches accordingly.

I noticed that most of the affected drivers do some kind of alignment
calculation in their dumb_create code. IMHO in the long run, we should
move such calculations into the default implementation and put the
control paramters into struct drm_mode_config.

Best regards
Thomas

> 
> It would look like this:
> 	/* GEM Operations */
> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
> -	.dumb_create            = drm_sun4i_gem_dumb_create,
> +	DRM_GEM_CMA_DRIVER_OPS_CREATE(drm_sun4i_gem_dumb_create),
> 
> 
> 
> Please fix zte/zx_drm_drv.c which also uses DRM_GEM_CMA_VMAP_DRIVER_OPS.
> 
> 
> The naming is a bikeshedding topic that we may not agree on, soo..
> 
> With zte fixed the patch is:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> 	Sam
> 
> 
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/gpu/drm/drm_gem_cma_helper.c |  2 +-
>>  drivers/gpu/drm/sun4i/sun4i_drv.c    |  3 +--
>>  drivers/gpu/drm/tidss/tidss_drv.c    |  2 +-
>>  drivers/gpu/drm/tiny/hx8357d.c       |  2 +-
>>  drivers/gpu/drm/tiny/ili9225.c       |  2 +-
>>  drivers/gpu/drm/tiny/ili9341.c       |  2 +-
>>  drivers/gpu/drm/tiny/ili9486.c       |  2 +-
>>  drivers/gpu/drm/tiny/mi0283qt.c      |  2 +-
>>  drivers/gpu/drm/tiny/repaper.c       |  2 +-
>>  drivers/gpu/drm/tiny/st7586.c        |  2 +-
>>  drivers/gpu/drm/tiny/st7735r.c       |  2 +-
>>  include/drm/drm_gem_cma_helper.h     | 24 ++++++++++++++++++++----
>>  12 files changed, 31 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
>> index 12e98fb28229d..6fa4d2f2e3987 100644
>> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
>> @@ -620,7 +620,7 @@ EXPORT_SYMBOL(drm_cma_gem_create_object_default_funcs);
>>   * address set. This address is released when the object is freed.
>>   *
>>   * This function can be used as the &drm_driver.gem_prime_import_sg_table
>> - * callback. The DRM_GEM_CMA_VMAP_DRIVER_OPS() macro provides a shortcut to set
>> + * callback. The &DRM_GEM_CMA_DRIVER_OPS macro provides a shortcut to set
>>   * the necessary DRM driver operations.
>>   *
>>   * Returns:
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
>> index 328272ff77d84..012855fd89c24 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
>> @@ -52,8 +52,7 @@ static struct drm_driver sun4i_drv_driver = {
>>  	.minor			= 0,
>>  
>>  	/* GEM Operations */
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> -	.dumb_create		= drm_sun4i_gem_dumb_create,
>> +	__DRM_GEM_CMA_DRIVER_OPS(drm_sun4i_gem_dumb_create),
>>  };
>>  
>>  static int sun4i_drv_bind(struct device *dev)
>> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
>> index 99edc66ebdef2..1753cdc74ebda 100644
>> --- a/drivers/gpu/drm/tidss/tidss_drv.c
>> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
>> @@ -112,7 +112,7 @@ static struct drm_driver tidss_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &tidss_fops,
>>  	.release		= tidss_release,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.name			= "tidss",
>>  	.desc			= "TI Keystone DSS",
>>  	.date			= "20180215",
>> diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
>> index b4bc358a3269a..592da71d7ca70 100644
>> --- a/drivers/gpu/drm/tiny/hx8357d.c
>> +++ b/drivers/gpu/drm/tiny/hx8357d.c
>> @@ -196,7 +196,7 @@ DEFINE_DRM_GEM_CMA_FOPS(hx8357d_fops);
>>  static struct drm_driver hx8357d_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &hx8357d_fops,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.debugfs_init		= mipi_dbi_debugfs_init,
>>  	.name			= "hx8357d",
>>  	.desc			= "HX8357D",
>> diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
>> index d1a5ab6747d5c..368ff6c8a1efb 100644
>> --- a/drivers/gpu/drm/tiny/ili9225.c
>> +++ b/drivers/gpu/drm/tiny/ili9225.c
>> @@ -346,7 +346,7 @@ DEFINE_DRM_GEM_CMA_FOPS(ili9225_fops);
>>  static struct drm_driver ili9225_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &ili9225_fops,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.name			= "ili9225",
>>  	.desc			= "Ilitek ILI9225",
>>  	.date			= "20171106",
>> diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
>> index bb819f45a5d3b..e1b9043ef7a0a 100644
>> --- a/drivers/gpu/drm/tiny/ili9341.c
>> +++ b/drivers/gpu/drm/tiny/ili9341.c
>> @@ -152,7 +152,7 @@ DEFINE_DRM_GEM_CMA_FOPS(ili9341_fops);
>>  static struct drm_driver ili9341_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &ili9341_fops,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.debugfs_init		= mipi_dbi_debugfs_init,
>>  	.name			= "ili9341",
>>  	.desc			= "Ilitek ILI9341",
>> diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
>> index 2702ea557d297..90a17f40fdf0c 100644
>> --- a/drivers/gpu/drm/tiny/ili9486.c
>> +++ b/drivers/gpu/drm/tiny/ili9486.c
>> @@ -165,7 +165,7 @@ DEFINE_DRM_GEM_CMA_FOPS(ili9486_fops);
>>  static struct drm_driver ili9486_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &ili9486_fops,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.debugfs_init		= mipi_dbi_debugfs_init,
>>  	.name			= "ili9486",
>>  	.desc			= "Ilitek ILI9486",
>> diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
>> index 08ac549ab0f7f..6624c2098fba2 100644
>> --- a/drivers/gpu/drm/tiny/mi0283qt.c
>> +++ b/drivers/gpu/drm/tiny/mi0283qt.c
>> @@ -156,7 +156,7 @@ DEFINE_DRM_GEM_CMA_FOPS(mi0283qt_fops);
>>  static struct drm_driver mi0283qt_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &mi0283qt_fops,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.debugfs_init		= mipi_dbi_debugfs_init,
>>  	.name			= "mi0283qt",
>>  	.desc			= "Multi-Inno MI0283QT",
>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
>> index 1c0e7169545b4..877dcece25828 100644
>> --- a/drivers/gpu/drm/tiny/repaper.c
>> +++ b/drivers/gpu/drm/tiny/repaper.c
>> @@ -946,7 +946,7 @@ DEFINE_DRM_GEM_CMA_FOPS(repaper_fops);
>>  static struct drm_driver repaper_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &repaper_fops,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.name			= "repaper",
>>  	.desc			= "Pervasive Displays RePaper e-ink panels",
>>  	.date			= "20170405",
>> diff --git a/drivers/gpu/drm/tiny/st7586.c b/drivers/gpu/drm/tiny/st7586.c
>> index 2a1fae422f7a2..ec84bdc51f60d 100644
>> --- a/drivers/gpu/drm/tiny/st7586.c
>> +++ b/drivers/gpu/drm/tiny/st7586.c
>> @@ -285,7 +285,7 @@ DEFINE_DRM_GEM_CMA_FOPS(st7586_fops);
>>  static struct drm_driver st7586_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &st7586_fops,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.debugfs_init		= mipi_dbi_debugfs_init,
>>  	.name			= "st7586",
>>  	.desc			= "Sitronix ST7586",
>> diff --git a/drivers/gpu/drm/tiny/st7735r.c b/drivers/gpu/drm/tiny/st7735r.c
>> index 0af1b15efdf8a..cfd4933f3b30c 100644
>> --- a/drivers/gpu/drm/tiny/st7735r.c
>> +++ b/drivers/gpu/drm/tiny/st7735r.c
>> @@ -157,7 +157,7 @@ DEFINE_DRM_GEM_CMA_FOPS(st7735r_fops);
>>  static struct drm_driver st7735r_driver = {
>>  	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>  	.fops			= &st7735r_fops,
>> -	DRM_GEM_CMA_VMAP_DRIVER_OPS,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.debugfs_init		= mipi_dbi_debugfs_init,
>>  	.name			= "st7735r",
>>  	.desc			= "Sitronix ST7735R",
>> diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
>> index 947ac95eb24a9..917d42603db06 100644
>> --- a/include/drm/drm_gem_cma_helper.h
>> +++ b/include/drm/drm_gem_cma_helper.h
>> @@ -110,21 +110,37 @@ struct drm_gem_object *
>>  drm_cma_gem_create_object_default_funcs(struct drm_device *dev, size_t size);
>>  
>>  /**
>> - * DRM_GEM_CMA_VMAP_DRIVER_OPS - CMA GEM driver operations ensuring a virtual
>> - *                               address on the buffer
>> + * __DRM_GEM_CMA_DRIVER_OPS - CMA GEM driver operations ensuring a
>> + *                            virtual address on the buffer
>> + * @__dumb_create: callback function for .dumb_create
>>   *
>>   * This macro provides a shortcut for setting the default GEM operations in the
>>   * &drm_driver structure for drivers that need the virtual address also on
>>   * imported buffers.
>> + *
>> + * This macro is a variant of DRM_GEM_CMA_DRIVER_OPS for drivers that
>> + * override the default implementation of .dumb_create. Use
>> + * DRM_GEM_CMA_DRIVER_OPS if possible.
>>   */
>> -#define DRM_GEM_CMA_VMAP_DRIVER_OPS \
>> +#define __DRM_GEM_CMA_DRIVER_OPS(__dumb_create) \
>>  	.gem_create_object	= drm_cma_gem_create_object_default_funcs, \
>> -	.dumb_create		= drm_gem_cma_dumb_create, \
>> +	.dumb_create		= (__dumb_create), \
>>  	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd, \
>>  	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle, \
>>  	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table_vmap, \
>>  	.gem_prime_mmap		= drm_gem_prime_mmap
>>  
>> +/**
>> + * DRM_GEM_CMA_DRIVER_OPS - CMA GEM driver operations ensuring a virtual
>> + *                          address on the buffer
>> + *
>> + * This macro provides a shortcut for setting the default GEM operations in the
>> + * &drm_driver structure for drivers that need the virtual address also on
>> + * imported buffers.
>> + */
>> +#define DRM_GEM_CMA_DRIVER_OPS \
>> +	__DRM_GEM_CMA_DRIVER_OPS(drm_gem_cma_dumb_create)
>> +
>>  struct drm_gem_object *
>>  drm_gem_cma_prime_import_sg_table_vmap(struct drm_device *drm,
>>  				       struct dma_buf_attachment *attach,
>> -- 
>> 2.26.2
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200525/d393bb4a/attachment-0001.sig>
