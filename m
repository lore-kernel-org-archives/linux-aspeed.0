From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 12 Jul 2023 21:22:44 +0200
Subject: [Freedreno] [PATCH RFC v1 00/52] drm/crtc: Rename struct
 drm_crtc::dev to drm_dev
In-Reply-To: <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
Message-ID: <2eeb1271-731a-1a70-4c83-449567452f8f@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/07/2023 20:31, Sean Paul wrote:
>>>     216 struct drm_device *ddev
>>>     234 struct drm_device *drm_dev
>>>     611 struct drm_device *drm
>>>    4190 struct drm_device *dev
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

You know, every code cleanup and style adjustment is interfering with
backporting. The only argument for a fast-pacing kernel should be
whether the developers of this code find it more readable with such cleanup.

Best regards,
Krzysztof

