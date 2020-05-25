From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 25 May 2020 14:37:33 +0200
Subject: [PATCH 05/21] drm/atmel-hlcdc: Use GEM CMA object functions
In-Reply-To: <20200522192546.GA1516695@ravnborg.org>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-6-tzimmermann@suse.de>
 <20200522192546.GA1516695@ravnborg.org>
Message-ID: <2c220ab0-e96b-2f5a-0d7f-8e770a13ef56@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 22.05.20 um 21:25 schrieb Sam Ravnborg:
> Hi Thomas.
> 
> On Fri, May 22, 2020 at 03:52:30PM +0200, Thomas Zimmermann wrote:
>> The atmel-hlcdc driver uses the default implementation for CMA functions. The
>> DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
>> All remaining operations are provided by CMA GEM object functions.
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
> 
>> -	.gem_prime_mmap = drm_gem_cma_prime_mmap,
> When using DRM_GEM_CMA_DRIVER_OPS gem_prime_mmap is set to
> drm_gem_prime_mmap.
> Why is this the same as drm_gem_cma_prime_mmap?
> 
> Maybe this is all obvious when you know all the CMA stuff,
> but this puzzeled me.

Following through the calls is far from easy.

I took the macro from the aspeed driver. I had some doubts about the
mmap code, but expected the driver to be working correctly. Maybe we
should set that field to drm_gem_cma_prime_mmap or implement the mmap
object function.

Best regards
Thomas



> 
> 	Sam
> 
> 
>> -	.dumb_create = drm_gem_cma_dumb_create,
>> +	DRM_GEM_CMA_DRIVER_OPS,
>>  	.fops = &fops,
>>  	.name = "atmel-hlcdc",
>>  	.desc = "Atmel HLCD Controller DRM",
>> -- 
>> 2.26.2

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200525/8d211b2a/attachment-0001.sig>
