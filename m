From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu, 13 Jul 2023 09:47:51 +0200
Subject: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
In-Reply-To: <20230712161025.22op3gtzgujrhytb@pengutronix.de>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com> <20230712161025.22op3gtzgujrhytb@pengutronix.de>
Message-ID: <955528fe-fd45-b8c1-8458-b3a7cd3dfbbb@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi

Am 12.07.23 um 18:10 schrieb Uwe Kleine-K?nig:
> Hello Jani,
> 
> On Wed, Jul 12, 2023 at 05:34:28PM +0300, Jani Nikula wrote:
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
>> device, i.e. struct drm_device *.
> 
> Well, unless it's not. Prominently there is
> 
> 	struct drm_device {
> 		...
> 		struct device *dev;
> 		...
> 	};

Jani's point is that it's only inconvenient at the first time. Everyone 
gets use to it.

Best regards
Thomas

> 
> which yields quite a few code locations using dev->dev which is
> IMHO unnecessary irritating:
> 
> 	$ git grep '\<dev->dev' v6.5-rc1 drivers/gpu/drm | wc -l
> 	1633
> 
> Also the functions that deal with both a struct device and a struct
> drm_device often use "dev" for the struct device and then "ddev" for
> the drm_device (see for example amdgpu_device_get_pcie_replay_count()).
> 
>> If folks insist on following through with this anyway, I'm firmly in the
>> camp the name should be "drm" and nothing else.
> 
> Up to now positive feedback is in the majority.
> 
> Best regards
> Uwe
> 

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230713/b2543b35/attachment-0001.sig>
