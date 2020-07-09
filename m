From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 9 Jul 2020 09:10:01 +0200
Subject: [PATCH] drm/aspeed: Call drm_fbdev_generic_setup after
 drm_dev_register
In-Reply-To: <CACPK8Xcb2jskKRsPEQ98Ty-yetkUZbZ8KzTGZ-ncc43nSXsRug@mail.gmail.com>
References: <20200701001002.74997-1-linux@roeck-us.net>
 <20200701091021.GA266726@ravnborg.org>
 <CACPK8Xcb2jskKRsPEQ98Ty-yetkUZbZ8KzTGZ-ncc43nSXsRug@mail.gmail.com>
Message-ID: <c19953bc-869e-c658-9f6c-77518509c663@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



Am 09.07.20 um 08:51 schrieb Joel Stanley:
> On Wed, 1 Jul 2020 at 09:10, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> Hi Guenter.
>>
>> On Tue, Jun 30, 2020 at 05:10:02PM -0700, Guenter Roeck wrote:
>>> The following backtrace is seen when running aspeed G5 kernels.
>>>
>>> WARNING: CPU: 0 PID: 1 at drivers/gpu/drm/drm_fb_helper.c:2233 drm_fbdev_generic_setup+0x138/0x198
>>> aspeed_gfx 1e6e6000.display: Device has not been registered.
>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc3 #1
>>> Hardware name: Generic DT based system
>>> Backtrace:
>>> [<8010d6d0>] (dump_backtrace) from [<8010d9b8>] (show_stack+0x20/0x24)
>>> r7:00000009 r6:60000153 r5:00000000 r4:8119fa94
>>> [<8010d998>] (show_stack) from [<80b8cb98>] (dump_stack+0xcc/0xec)
>>> [<80b8cacc>] (dump_stack) from [<80123ef0>] (__warn+0xd8/0xfc)
>>> r7:00000009 r6:80e62ed0 r5:00000000 r4:974c3ccc
>>> [<80123e18>] (__warn) from [<80123f98>] (warn_slowpath_fmt+0x84/0xc4)
>>> r9:00000009 r8:806a0140 r7:000008b9 r6:80e62ed0 r5:80e631f8 r4:974c2000
>>> [<80123f18>] (warn_slowpath_fmt) from [<806a0140>] (drm_fbdev_generic_setup+0x138/0x198)
>>> r9:00000001 r8:9758fc10 r7:9758fc00 r6:00000000 r5:00000020 r4:9768a000
>>> [<806a0008>] (drm_fbdev_generic_setup) from [<806d4558>] (aspeed_gfx_probe+0x204/0x32c)
>>> r7:9758fc00 r6:00000000 r5:00000000 r4:9768a000
>>> [<806d4354>] (aspeed_gfx_probe) from [<806dfca0>] (platform_drv_probe+0x58/0xa8)
>>>
>>> Since commit 1aed9509b29a6 ("drm/fb-helper: Remove return value from
>>> drm_fbdev_generic_setup()"), drm_fbdev_generic_setup() must be called
>>> after drm_dev_register() to avoid the warning. Do that.
>>>
>>> Fixes: 1aed9509b29a6 ("drm/fb-helper: Remove return value from drm_fbdev_generic_setup()")
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>
>> I thought we had this fixed already - but could not find the patch.
>> Must have been another driver then.
>>
>> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>>
>> I assume Joel Stanley will pick up this patch.
> 
> I do not have the drm maintainer tools set up at the moment. Could one
> of the other maintainers put this in the drm-misc tree?

Added to drm-misc-fixes

Best regards
Thomas

> 
> Acked-by: Joel Stanley <joel@jms.id.au>
> 
> Cheers,
> 
> Joel
> 
>>
>>         Sam
>>
>>> ---
>>>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
>>> index 6b27242b9ee3..bca3fcff16ec 100644
>>> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
>>> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
>>> @@ -173,8 +173,6 @@ static int aspeed_gfx_load(struct drm_device *drm)
>>>
>>>       drm_mode_config_reset(drm);
>>>
>>> -     drm_fbdev_generic_setup(drm, 32);
>>> -
>>>       return 0;
>>>  }
>>>
>>> @@ -225,6 +223,7 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
>>>       if (ret)
>>>               goto err_unload;
>>>
>>> +     drm_fbdev_generic_setup(&priv->drm, 32);
>>>       return 0;
>>>
>>>  err_unload:
>>> --
>>> 2.17.1
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel at lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200709/2eca1cfd/attachment.sig>
