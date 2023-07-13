From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 13 Jul 2023 09:48:47 +0200
Subject: [Freedreno] [PATCH RFC v1 00/52] drm/crtc: Rename struct
 drm_crtc::dev to drm_dev
In-Reply-To: <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
Message-ID: <8cba166e-b218-791c-392b-f1162eefe1e7@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 12.07.23 um 20:31 schrieb Sean Paul:
> On Wed, Jul 12, 2023 at 10:52?AM Jani Nikula <jani.nikula@intel.com> wrote:
>>
>> On Wed, 12 Jul 2023, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>>> Hello,
>>>
>>> while I debugged an issue in the imx-lcdc driver I was constantly
>>> irritated about struct drm_device pointer variables being named "dev"
>>> because with that name I usually expect a struct device pointer.
>>>
>>> I think there is a big benefit when these are all renamed to "drm_dev".
>>> I have no strong preference here though, so "drmdev" or "drm" are fine
>>> for me, too. Let the bikesheding begin!
>>>
>>> Some statistics:
>>>
>>> $ git grep -ohE 'struct drm_device *\* *[^ (),;]*' v6.5-rc1 | sort | uniq -c | sort -n
>>>        1 struct drm_device *adev_to_drm
>>>        1 struct drm_device *drm_
>>>        1 struct drm_device          *drm_dev
>>>        1 struct drm_device        *drm_dev
>>>        1 struct drm_device *pdev
>>>        1 struct drm_device *rdev
>>>        1 struct drm_device *vdev
>>>        2 struct drm_device *dcss_drv_dev_to_drm
>>>        2 struct drm_device **ddev
>>>        2 struct drm_device *drm_dev_alloc
>>>        2 struct drm_device *mock
>>>        2 struct drm_device *p_ddev
>>>        5 struct drm_device *device
>>>        9 struct drm_device * dev
>>>       25 struct drm_device *d
>>>       95 struct drm_device *
>>>      216 struct drm_device *ddev
>>>      234 struct drm_device *drm_dev
>>>      611 struct drm_device *drm
>>>     4190 struct drm_device *dev
>>>
>>> This series starts with renaming struct drm_crtc::dev to drm_dev. If
>>> it's not only me and others like the result of this effort it should be
>>> followed up by adapting the other structs and the individual usages in
>>> the different drivers.
>>
>> I think this is an unnecessary change. In drm, a dev is usually a drm
>> device, i.e. struct drm_device *. As shown by the numbers above.
>>
> 
> I'd really prefer this patch (series or single) is not accepted. This
> will cause problems for everyone cherry-picking patches to a
> downstream kernel (LTS or distro tree). I usually wouldn't expect
> sympathy here, but the questionable benefit does not outweigh the cost
> IM[biased]O.

I agree.

> 
> Sean
> 
>> If folks insist on following through with this anyway, I'm firmly in the
>> camp the name should be "drm" and nothing else.
>>
>>
>> BR,
>> Jani.
>>
>>
>> --
>> Jani Nikula, Intel Open Source Graphics Center

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: OpenPGP_signature
Type: application/pgp-signature
Size: 840 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230713/f3b231d9/attachment-0001.sig>
