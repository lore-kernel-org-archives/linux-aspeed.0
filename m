From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 9 Nov 2021 08:40:23 +0800
Subject: [PATCH] media: aspeed: Fix signal status not updated immediately
In-Reply-To: <cd62eba4-2553-6837-6069-52a209e48b8c@molgen.mpg.de>
References: <20211108061155.14479-1-jammy_huang@aspeedtech.com>
 <cd62eba4-2553-6837-6069-52a209e48b8c@molgen.mpg.de>
Message-ID: <326116c0-acd2-ccc2-d803-486df9c1fa3a@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Paul,

Thanks for your help. I will update in the next patch.

On 2021/11/8 ?? 03:57, Paul Menzel wrote:
> Dear Jammy,
>
>
> Am 08.11.21 um 07:11 schrieb Jammy Huang:
>
> Maybe for the commit message summary:
>
> media: aspeed: Update signal status immediately to ensure sane hw state
>
>
>> If res-chg, VE_INTERRUPT_MODE_DETECT_WD irq will be raised. But
>> v4l2_input_status wont't be updated to no-signal immediately until
> won?t
>
>> aspeed_video_get_resolution() in aspeed_video_resolution_work().
>>
>> During the period of time, aspeed_video_start_frame() could be called
>> because it doesn't know signal is unstable now. If it goes with
>> aspeed_video_init_regs() of aspeed_video_irq_res_change() simultaneously
>> , it will mess up hw state.
> Please do not start a line with a comma, for example, put the comma on
> the line above.
>
>> To fix this problem, v4l2_input_status will be updated to no-signal
> ? status is updated _ (Present tense in commit messages.)
>
>> immediately for VE_INTERRUPT_MODE_DETECT_WD irq.
>>
>> Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>    drivers/media/platform/aspeed-video.c | 6 +++---
>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index 1ade264a8b69..3facd7ecc1a1 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -762,6 +762,8 @@ static void aspeed_video_irq_res_change(struct aspeed_video *video, ulong delay)
>>    	set_bit(VIDEO_RES_CHANGE, &video->flags);
>>    	clear_bit(VIDEO_FRAME_INPRG, &video->flags);
>>    
>> +	video->v4l2_input_status = V4L2_IN_ST_NO_SIGNAL;
>> +
>>    	aspeed_video_off(video);
>>    	aspeed_video_on(video);
>>    	aspeed_video_bufs_done(video, VB2_BUF_STATE_ERROR);
>> @@ -1889,7 +1891,6 @@ static void aspeed_video_resolution_work(struct work_struct *work)
>>    	struct delayed_work *dwork = to_delayed_work(work);
>>    	struct aspeed_video *video = container_of(dwork, struct aspeed_video,
>>    						  res_work);
>> -	u32 input_status = video->v4l2_input_status;
>>    
>>    	/* Exit early in case no clients remain */
>>    	if (test_bit(VIDEO_STOPPED, &video->flags))
>> @@ -1902,8 +1903,7 @@ static void aspeed_video_resolution_work(struct work_struct *work)
>>    	aspeed_video_get_resolution(video);
>>    
>>    	if (video->detected_timings.width != video->active_timings.width ||
>> -	    video->detected_timings.height != video->active_timings.height ||
>> -	    input_status != video->v4l2_input_status) {
>> +	    video->detected_timings.height != video->active_timings.height) {
>>    		static const struct v4l2_event ev = {
>>    			.type = V4L2_EVENT_SOURCE_CHANGE,
>>    			.u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION,
>>
> Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

-- 
Best Regards
Jammy

