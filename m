From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 3 Nov 2021 13:02:38 +0800
Subject: [PATCH v2] media: aspeed: fix mode-detect always time out at 2nd
 run
In-Reply-To: <CACPK8XezrCtCbKVgNOPNt+N_7ki6Rctf9M8oLBHyixa+Wph2Sw@mail.gmail.com>
References: <20211103011357.22067-1-jammy_huang@aspeedtech.com>
 <CACPK8XcuhVVvbs4m5k=1d6oFiewEo2RqqOqf5R72KJ4yjiEiUw@mail.gmail.com>
 <CACPK8XezrCtCbKVgNOPNt+N_7ki6Rctf9M8oLBHyixa+Wph2Sw@mail.gmail.com>
Message-ID: <3a40bb81-2c6e-47e3-fb85-e615aecd129a@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Joel,

Sure. Thanks for your reminder.

On 2021/11/3 ?? 09:53, Joel Stanley wrote:
> On Wed, 3 Nov 2021 at 01:47, Joel Stanley <joel@jms.id.au> wrote:
>> On Wed, 3 Nov 2021 at 01:13, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>>> aspeed_video_get_resolution() will try to do res-detect again if the
>>> timing got in last try is invalid. But it will always time out because
>>> VE_SEQ_CTRL_TRIG_MODE_DET is only cleared after 1st mode-detect.
>>>
>>> To fix the problem, just clear VE_SEQ_CTRL_TRIG_MODE_DET before setting
>>> it in aspeed_video_enable_mode_detect().
>>>
>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
> When applying, can we please have this tag added:
>
> Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
>
> Cheers,
>
> Joel
>
>
>>> ---
>>> v2:
>>>    - update commit message
>>> ---
>>>   drivers/media/platform/aspeed-video.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>>> index 5ffbabf884eb..fea5e4d0927e 100644
>>> --- a/drivers/media/platform/aspeed-video.c
>>> +++ b/drivers/media/platform/aspeed-video.c
>>> @@ -518,6 +518,10 @@ static void aspeed_video_enable_mode_detect(struct aspeed_video *video)
>>>          aspeed_video_update(video, VE_INTERRUPT_CTRL, 0,
>>>                              VE_INTERRUPT_MODE_DETECT);
>>>
>>> +       /* Disable mode detect in order to re-trigger */
>>> +       aspeed_video_update(video, VE_SEQ_CTRL,
>>> +                           VE_SEQ_CTRL_TRIG_MODE_DET, 0);
>>> +
>>>          /* Trigger mode detect */
>>>          aspeed_video_update(video, VE_SEQ_CTRL, 0, VE_SEQ_CTRL_TRIG_MODE_DET);
>>>   }
>>> @@ -809,10 +813,6 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>>>                          return;
>>>                  }
>>>
>>> -               /* Disable mode detect in order to re-trigger */
>>> -               aspeed_video_update(video, VE_SEQ_CTRL,
>>> -                                   VE_SEQ_CTRL_TRIG_MODE_DET, 0);
>>> -
>>>                  aspeed_video_check_and_set_polarity(video);
>>>
>>>                  aspeed_video_enable_mode_detect(video);
>>> --
>>> 2.25.1
>>>
-- 
Best Regards
Jammy

