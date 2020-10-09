From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 9 Oct 2020 10:26:26 +0200
Subject: [PATCH 04/21] drm/aspeed: Set driver CMA functions with
 DRM_GEM_CMA_DRIVER_OPS
In-Reply-To: <CACPK8XcAXrf6ySuWo4izjD4EU6tMSULs0tP4cy-+TA35PSOUgw@mail.gmail.com>
References: <20200522135246.10134-1-tzimmermann@suse.de>
 <20200522135246.10134-5-tzimmermann@suse.de>
 <CACPK8XcGOAjocCMp9ubgQpfiBaqSj61i_frSU7ZdiKO_uSt-hQ@mail.gmail.com>
 <3df12a74-d8f3-d607-78ff-5a0f21e86cb9@suse.de>
 <CACPK8XcAXrf6ySuWo4izjD4EU6tMSULs0tP4cy-+TA35PSOUgw@mail.gmail.com>
Message-ID: <c3419660-770c-dadd-21bd-9a6dc0e10a8d@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 09.10.20 um 10:06 schrieb Joel Stanley:
> On Fri, 9 Oct 2020 at 08:01, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>> Hi
>>
>> Am 09.10.20 um 09:54 schrieb Joel Stanley:
>>> On Fri, 22 May 2020 at 13:52, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>>>
>>>> DRM_GEM_CMA_DRIVER_OPS sets the functions in struct drm_driver
>>>> to their defaults. No functional changes are made.
>>>>
>>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>>
>>> I just found this in my inbox. I assume it has not been applied as you
>>> were after a review.
>>
>> The patchset as a whole got an A-b and was merged a while ago.
> 
> I'm a bit confused, I couldn't see it in any tree. The aspeed one
> seemed to have been skipped when applying the series.
> 
> I looked at today's linux-next and drm-misc-next.

Indeed. The other patches are in drm-misc-next, but not this one. I must
have lost it during the merge process.

> 
>>>
>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>
>> Nevertheless thanks for taking a look at the patch.
>>
>> Best regards
>> Thomas
>>
>>>
>>> I will apply it to drm-misc-next.

So please ahead and apply it. There's also an ack by Emil, which you may
want to add as well.

  Acked-by: Emil Velikov <emil.velikov@collabora.com>

Sorry about missing the patch and thanks for taking care.

Best regards
Thomas

>>>
>>> Cheers,
>>>
>>> Joel
>>>
>>>> ---
>>>>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 7 +------
>>>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
>>>> index 6b27242b9ee3c..1167ff78e24a3 100644
>>>> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
>>>> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
>>>> @@ -188,12 +188,7 @@ DEFINE_DRM_GEM_CMA_FOPS(fops);
>>>>
>>>>  static struct drm_driver aspeed_gfx_driver = {
>>>>         .driver_features        = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
>>>> -       .gem_create_object      = drm_cma_gem_create_object_default_funcs,
>>>> -       .dumb_create            = drm_gem_cma_dumb_create,
>>>> -       .prime_handle_to_fd     = drm_gem_prime_handle_to_fd,
>>>> -       .prime_fd_to_handle     = drm_gem_prime_fd_to_handle,
>>>> -       .gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
>>>> -       .gem_prime_mmap         = drm_gem_prime_mmap,
>>>> +       DRM_GEM_CMA_DRIVER_OPS,
>>>>         .fops = &fops,
>>>>         .name = "aspeed-gfx-drm",
>>>>         .desc = "ASPEED GFX DRM",
>>>> --
>>>> 2.26.2
>>>>
>>
>> --
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 N?rnberg, Germany
>> (HRB 36809, AG N?rnberg)
>> Gesch?ftsf?hrer: Felix Imend?rffer
>>
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
Size: 516 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20201009/dad9b509/attachment.sig>
