From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 25 May 2020 14:10:39 +0200
Subject: [PATCH 05/21] drm/atmel-hlcdc: Use GEM CMA object functions
In-Reply-To: <20200522180824.GB1087580@ravnborg.org>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-6-tzimmermann@suse.de>
 <20200522180824.GB1087580@ravnborg.org>
Message-ID: <8a1de3a8-05d2-9abc-57e9-e29928b777d3@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 22.05.20 um 20:08 schrieb Sam Ravnborg:
> Hi Thomas.
> 
> On Fri, May 22, 2020 at 03:52:30PM +0200, Thomas Zimmermann wrote:
>> The atmel-hlcdc driver uses the default implementation for CMA functions. The
>> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
>> All remaining operations are provided by CMA GEM object functions.
> 
> A nice side-effect of introducing the defualt implementation
> of CMA functions is that this driver is now migrated over to use
> drm_gem_object_funcs, which is why we can replace all these
> helpers with a simple macro that defined only 6 helpers.
> 
> With an improved changelog:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> And as I said in the other mail, this is really nice.
> It is now much more obvious that this drivers uses
> all the default helpers for CMA.
> 
> And I can drop one item from my TODO list on top of that.

There's still more to do. The current macro still sets
.gem_object_create to a CMA default. But that pointer is the interface
where drivers can override some of the CMA object defaults, so it should
not be set by CMA helpers.

After the other CMA drivers have been converted to GEM object functions,
this setting can be kept to zero and __drm_gem_cma_create() can set the
default object functions. SHMEM and VRAM helpers already work this way.

Best regards
Thomas

> 
> 	Sam
> 
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 11 +----------
>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> index 112aa5066ceed..871293d1aeeba 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> @@ -821,16 +821,7 @@ static struct drm_driver atmel_hlcdc_dc_driver = {
>>  	.irq_preinstall = atmel_hlcdc_dc_irq_uninstall,
>>  	.irq_postinstall = atmel_hlcdc_dc_irq_postinstall,
>>  	.irq_uninstall = atmel_hlcdc_dc_irq_uninstall,
>> -	.gem_free_object_unlocked = drm_gem_cma_free_object,
>> -	.gem_vm_ops = &drm_gem_cma_vm_ops,
>> -	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>> -	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>> -	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
>> -	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
>> -	.gem_prime_vmap = drm_gem_cma_prime_vmap,
>> -	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
>> -	.gem_prime_mmap = drm_gem_cma_prime_mmap,
>> -	.dumb_create = drm_gem_cma_dumb_create,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.fops = &fops,
>>  	.name = "atmel-hlcdc",
>>  	.desc = "Atmel HLCD Controller DRM",
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200525/5231eac0/attachment-0001.sig>
