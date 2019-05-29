From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 29 May 2019 09:07:17 -0500
Subject: [PATCH v2 11/11] media: aspeed: add a workaround to fix a silicon
 bug
In-Reply-To: <20190524231725.12320-12-jae.hyun.yoo@linux.intel.com>
References: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
 <20190524231725.12320-12-jae.hyun.yoo@linux.intel.com>
Message-ID: <03a3cf74-3fd3-982e-ec37-014ed4a13b47@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/24/19 6:17 PM, Jae Hyun Yoo wrote:
> AST2500 silicon revision A1 and A2 have a silicon bug which causes
> extremly long capturing time on specific resolutions (1680 width).
> To fix the bug, this commit adjusts the capturing window register
> setting to 1728 if detected width is 1680. The compression window
> register setting will be kept as the original width so output
> result will be the same.


This is a bit curious, why 1728 in particular? And what is the behavior 
of the VE when the capture window is larger than the actual source 
resolution?

Thanks,

Eddie


>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
> v1 -> v2:
>   New.
>
>   drivers/media/platform/aspeed-video.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index b05b073b63bc..f93989f532d6 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -824,8 +824,27 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>   	struct v4l2_bt_timings *act = &video->active_timings;
>   	unsigned int size = act->width * act->height;
>   
> +	/* Set capture/compression frame sizes */
>   	aspeed_video_calc_compressed_size(video, size);
>   
> +	if (video->active_timings.width == 1680) {
> +		/*
> +		 * This is a workaround to fix a silicon bug on A1 and A2
> +		 * revisions. Since it doesn't break capturing operation on A0
> +		 * revision, use it for all revisions without checking the
> +		 * revision ID.
> +		 */
> +		aspeed_video_write(video, VE_CAP_WINDOW,
> +				   1728 << 16 | act->height);
> +		size += (1728 - 1680) * video->active_timings.height;
> +	} else {
> +		aspeed_video_write(video, VE_CAP_WINDOW,
> +				   act->width << 16 | act->height);
> +	}
> +	aspeed_video_write(video, VE_COMP_WINDOW,
> +			   act->width << 16 | act->height);
> +	aspeed_video_write(video, VE_SRC_SCANLINE_OFFSET, act->width * 4);
> +
>   	/* Don't use direct mode below 1024 x 768 (irqs don't fire) */
>   	if (size < DIRECT_FETCH_THRESHOLD) {
>   		aspeed_video_write(video, VE_TGS_0,
> @@ -842,13 +861,6 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>   		aspeed_video_update(video, VE_CTRL, 0, VE_CTRL_DIRECT_FETCH);
>   	}
>   
> -	/* Set capture/compression frame sizes */
> -	aspeed_video_write(video, VE_CAP_WINDOW,
> -			   act->width << 16 | act->height);
> -	aspeed_video_write(video, VE_COMP_WINDOW,
> -			   act->width << 16 | act->height);
> -	aspeed_video_write(video, VE_SRC_SCANLINE_OFFSET, act->width * 4);
> -
>   	size *= 4;
>   
>   	if (size == video->srcs[0].size / 2) {

