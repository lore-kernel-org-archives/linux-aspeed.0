From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 20 Oct 2022 14:00:59 +0200
Subject: [PATCH 01/21] drm/amdgpu: Don't set struct drm_driver.lastclose
In-Reply-To: <b26e508b-7599-3953-6803-7db00b3cfbcb@amd.com>
References: <20221020103755.24058-1-tzimmermann@suse.de>
 <20221020103755.24058-2-tzimmermann@suse.de>
 <b26e508b-7599-3953-6803-7db00b3cfbcb@amd.com>
Message-ID: <8f3a7b67-d193-eb47-a5a6-8826e9c82f83@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 20.10.22 um 13:48 schrieb Christian K?nig:
> Am 20.10.22 um 12:37 schrieb Thomas Zimmermann:
>> Don't set struct drm_driver.lastclose. It's used to restore the
>> fbdev console. But as amdgpu uses generic fbdev emulation, the
>> console is being restored by the DRM client helpers already. See
>> the call to drm_client_dev_restore() in drm_lastclose().
> 
> ???
> 
> The commit message doesn't match what the patch is doing. You are 
> removing output_poll_changed instead of lastclose here.
> 
> Did something got mixed up?

Arghh. There are patches for lastclose and output_poll_changed. The 
reason for removing them is the same, but thanks to copy and paste the 
names are wrong. So the patch is correct, but the description isn't. 
Will be fixed.

Best regards
Thomas

> 
> Cheers,
> Christian.
> 
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>> ? drivers/gpu/drm/amd/amdgpu/amdgpu_display.c?????? | 1 -
>> ? drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
>> ? 2 files changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index 23998f727c7f9..fb7186c5ade2a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -1224,7 +1224,6 @@ amdgpu_display_user_framebuffer_create(struct 
>> drm_device *dev,
>> ? const struct drm_mode_config_funcs amdgpu_mode_funcs = {
>> ????? .fb_create = amdgpu_display_user_framebuffer_create,
>> -??? .output_poll_changed = drm_fb_helper_output_poll_changed,
>> ? };
>> ? static const struct drm_prop_enum_list amdgpu_underscan_enum_list[] =
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index f6a9e8fdd87d6..e9a28a5363b9a 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -82,7 +82,6 @@
>> ? #include <drm/drm_atomic_uapi.h>
>> ? #include <drm/drm_atomic_helper.h>
>> ? #include <drm/drm_blend.h>
>> -#include <drm/drm_fb_helper.h>
>> ? #include <drm/drm_fourcc.h>
>> ? #include <drm/drm_edid.h>
>> ? #include <drm/drm_vblank.h>
>> @@ -2810,7 +2809,6 @@ const struct amdgpu_ip_block_version dm_ip_block =
>> ? static const struct drm_mode_config_funcs amdgpu_dm_mode_funcs = {
>> ????? .fb_create = amdgpu_display_user_framebuffer_create,
>> ????? .get_format_info = amd_get_format_info,
>> -??? .output_poll_changed = drm_fb_helper_output_poll_changed,
>> ????? .atomic_check = amdgpu_dm_atomic_check,
>> ????? .atomic_commit = drm_atomic_helper_commit,
>> ? };
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N?rnberg, Germany
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Ivo Totev
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OpenPGP_signature
Type: application/pgp-signature
Size: 840 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20221020/9be1e88e/attachment-0001.sig>
