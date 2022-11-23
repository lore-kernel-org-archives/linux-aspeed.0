From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 23 Nov 2022 09:08:30 +0100
Subject: [PATCH] media: aspeed: Use v4l2_dbg to replace v4l2_warn to avoid
 log spam
In-Reply-To: <20221110095611.522-1-jammy_huang@aspeedtech.com>
References: <20221110095611.522-1-jammy_huang@aspeedtech.com>
Message-ID: <c8a4a3b6-6591-2710-433f-642277eeb8f3@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Jammy,


Am 10.11.22 um 10:56 schrieb Jammy Huang:
> If the host is powered off, there will be many warning log. To avoid the

?, many warnings are logged.

Also, please paste one example message.

Are the messages really just debug messages, or only in the one 
condition? If the latter, another solution should be found, like 
checking if the host is powered off, or rate limiting the message.

> log spam in this condition, replace v4l2_warn with v4l2_dbg.

Please add a reference, to Zev?s report on the mailing list.

Link: ?

> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   drivers/media/platform/aspeed/aspeed-video.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index cf76aeee8cb6..662465d13a0e 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -586,13 +586,13 @@ static int aspeed_video_start_frame(struct aspeed_video *video)
>   	bool bcd_buf_need = (video->format != VIDEO_FMT_STANDARD);
>   
>   	if (video->v4l2_input_status) {
> -		v4l2_warn(&video->v4l2_dev, "No signal; don't start frame\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "No signal; don't start frame\n");
>   		return 0;
>   	}
>   
>   	if (!(seq_ctrl & VE_SEQ_CTRL_COMP_BUSY) ||
>   	    !(seq_ctrl & VE_SEQ_CTRL_CAP_BUSY)) {
> -		v4l2_warn(&video->v4l2_dev, "Engine busy; don't start frame\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "Engine busy; don't start frame\n");
>   		return -EBUSY;
>   	}
>   
> @@ -615,7 +615,7 @@ static int aspeed_video_start_frame(struct aspeed_video *video)
>   				       struct aspeed_video_buffer, link);
>   	if (!buf) {
>   		spin_unlock_irqrestore(&video->lock, flags);
> -		v4l2_warn(&video->v4l2_dev, "No buffers; don't start frame\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "No buffers; don't start frame\n");
>   		return -EPROTO;
>   	}
>   
> @@ -796,7 +796,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>   			if (video->format == VIDEO_FMT_STANDARD &&
>   			    list_is_last(&buf->link, &video->buffers)) {
>   				empty = false;
> -				v4l2_warn(&video->v4l2_dev, "skip to keep last frame updated\n");
> +				v4l2_dbg(1, debug, &video->v4l2_dev, "skip to keep last frame updated\n");
>   			} else {
>   				buf->vb.vb2_buf.timestamp = ktime_get_ns();
>   				buf->vb.sequence = video->sequence++;
> @@ -1060,7 +1060,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   						      res_check(video),
>   						      MODE_DETECT_TIMEOUT);
>   		if (!rc) {
> -			v4l2_warn(&video->v4l2_dev, "Timed out; first mode detect\n");
> +			v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out; first mode detect\n");
>   			clear_bit(VIDEO_RES_DETECT, &video->flags);
>   			return;
>   		}
> @@ -1081,7 +1081,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   						      MODE_DETECT_TIMEOUT);
>   		clear_bit(VIDEO_RES_DETECT, &video->flags);
>   		if (!rc) {
> -			v4l2_warn(&video->v4l2_dev, "Timed out; second mode detect\n");
> +			v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out; second mode detect\n");
>   			return;
>   		}
>   
> @@ -1104,7 +1104,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   	} while (invalid_resolution && (tries++ < INVALID_RESOLUTION_RETRIES));
>   
>   	if (invalid_resolution) {
> -		v4l2_warn(&video->v4l2_dev, "Invalid resolution detected\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "Invalid resolution detected\n");
>   		return;
>   	}
>   
> @@ -1856,7 +1856,7 @@ static void aspeed_video_stop_streaming(struct vb2_queue *q)
>   				!test_bit(VIDEO_FRAME_INPRG, &video->flags),
>   				STOP_TIMEOUT);
>   	if (!rc) {
> -		v4l2_warn(&video->v4l2_dev, "Timed out when stopping streaming\n");
> +		v4l2_dbg(1, debug, &video->v4l2_dev, "Timed out when stopping streaming\n");
>   
>   		/*
>   		 * Need to force stop any DMA and try and get HW into a good
> 
> base-commit: aae703b02f92bde9264366c545e87cec451de471
> prerequisite-patch-id: bf47e8ab2998acfbc32be5a4b7b5ae8a3ae4218b
> prerequisite-patch-id: bf82715983e08f2e810ff1a82ce644f5f9006cd9
> prerequisite-patch-id: 28a2040ef0235e5765f05d2fc5529bce2a0f4c6f
> prerequisite-patch-id: 7e761c779730536db8baf50db5fc8caf058e95af
> prerequisite-patch-id: c48ea20973fa35938a7d33a0e20d2900df48755f
