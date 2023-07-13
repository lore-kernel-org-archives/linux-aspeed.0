From: Luben Tuikov <luben.tuikov@amd.com>
Date: Wed, 12 Jul 2023 20:06:58 -0400
Subject: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
In-Reply-To: <603f0b69-71d3-ad8f-4b5e-53b63a6fd521@amd.com>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <94eb6e4d-9384-152f-351b-ebb217411da9@amd.com>
 <20230712110253.paoyrmcbvlhpfxbf@pengutronix.de>
 <o3dc4q27ap6rajsvpfwfvs3z3afekkwbhnclvswkaietciy2kc@unjf67gz5tur>
 <20230712133803.rf26cbg5wz7wsmgl@pengutronix.de>
 <603f0b69-71d3-ad8f-4b5e-53b63a6fd521@amd.com>
Message-ID: <83bba180-faac-e2a9-e7d3-c5fdf5df2303@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2023-07-12 09:53, Christian K?nig wrote:
> Am 12.07.23 um 15:38 schrieb Uwe Kleine-K?nig:
>> Hello Maxime,
>>
>> On Wed, Jul 12, 2023 at 02:52:38PM +0200, Maxime Ripard wrote:
>>> On Wed, Jul 12, 2023 at 01:02:53PM +0200, Uwe Kleine-K?nig wrote:
>>>>> Background is that this makes merge conflicts easier to handle and detect.
>>>> Really?
>>> FWIW, I agree with Christian here.
>>>
>>>> Each file (apart from include/drm/drm_crtc.h) is only touched once. So
>>>> unless I'm missing something you don't get less or easier conflicts by
>>>> doing it all in a single patch. But you gain the freedom to drop a
>>>> patch for one driver without having to drop the rest with it.
>>> Not really, because the last patch removed the union anyway. So you have
>>> to revert both the last patch, plus that driver one. And then you need
>>> to add a TODO to remove that union eventually.
>> Yes, with a single patch you have only one revert (but 194 files changed,
>> 1264 insertions(+), 1296 deletions(-)) instead of two (one of them: 1
>> file changed, 9 insertions(+), 1 deletion(-); the other maybe a bit
>> bigger). (And maybe you get away with just reverting the last patch.)
>>
>> With a single patch the TODO after a revert is "redo it all again (and
>> prepare for a different set of conflicts)" while with the split series
>> it's only "fix that one driver that was forgotten/borked" + reapply that
>> 10 line patch.
> 
> Yeah, but for a maintainer the size of the patches doesn't matter. 
> That's only interesting if you need to manually review the patch, which 
> you hopefully doesn't do in case of something auto-generated.
> 
> In other words if the patch is auto-generated re-applying it completely 
> is less work than fixing things up individually.
> 
>>   As the one who gets that TODO, I prefer the latter.
> 
> Yeah, but your personal preferences are not a technical relevant 
> argument to a maintainer.
> 
> At the end of the day Dave or Daniel need to decide, because they need 
> to live with it.
> 
> Regards,
> Christian.
> 
>>
>> So in sum: If your metric is "small count of reverted commits", you're
>> right. If however your metric is: Better get 95% of this series' change
>> in than maybe 0%, the split series is the way to do it.
>>
>> With me having spend ~3h on this series' changes, it's maybe
>> understandable that I did it the way I did.
>>
>> FTR: This series was created on top of v6.5-rc1. If you apply it to
>> drm-misc-next you get a (trivial) conflict in patch #2. If I consider to
>> be the responsible maintainer who applies this series, I like being able
>> to just do git am --skip then.
>>
>> FTR#2: In drm-misc-next is a new driver
>> (drivers/gpu/drm/loongson/lsdc_crtc.c) so skipping the last patch for
>> now might indeed be a good idea.
>>
>>>> So I still like the split version better, but I'm open to a more
>>>> verbose reasoning from your side.
>>> You're doing only one thing here, really: you change the name of a
>>> structure field. If it was shared between multiple maintainers, then
>>> sure, splitting that up is easier for everyone, but this will go through
>>> drm-misc, so I can't see the benefit it brings.
>> I see your argument, but I think mine weights more.

I'm with Maxime and Christian on this--a single action necessitates a single patch.
One single movement. As Maxime said "either 0 or 100."

As to the name, perhaps "drm_dev" is more descriptive than just "drm".
What is "drm"? Ah it's a "dev", as in "drm dev"... Then why not rename it
to "drm_dev"? You are renaming it from "dev" to something more descriptive
after all. "dev" --> "drm" is no better, but "dev" --> "drm_dev" is just
right.
-- 
Regards,
Luben

