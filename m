From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Wed, 19 Jul 2023 08:18:39 +0200
Subject: [PATCH v2] media: aspeed: Fix memory overwrite if timing is
 1600x900
In-Reply-To: <20230717095111.1957-1-jammy_huang@aspeedtech.com>
References: <20230717095111.1957-1-jammy_huang@aspeedtech.com>
Message-ID: <21e13f35-5caf-6d60-c388-3386e3540834@xs4all.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jammy,

On 17/07/2023 11:51, Jammy Huang wrote:
> When capturing 1600x900, system could crash when system memory usage is
> tight.
> 
> The way to reproduce this issue:
> 1. Use 1600x900 to display on host
> 2. Mount ISO through 'Virtual media' on OpenBMC's web
> 3. Run script as below on host to do sha continuously
>   #!/bin/bash
>   while [ [1] ];
>   do
> 	find /media -type f -printf '"%h/%f"\n' | xargs sha256sum
>   done
> 4. Open KVM on OpenBMC's web
> 
> The size of macro block captured is 8x8. Therefore, we should make sure
> the height of src-buf is 8 aligned to fix this issue.
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

Your email address you sent this from differs from your SoB. Can you post
again from the correct email address? Checkpatch complains about this.

Regards,

	Hans

> ---
>  v2 changes
>   - Add how to reproduce this issue.
> ---
>  drivers/media/platform/aspeed/aspeed-video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
> index 374eb7781936..14594f55a77f 100644
> --- a/drivers/media/platform/aspeed/aspeed-video.c
> +++ b/drivers/media/platform/aspeed/aspeed-video.c
> @@ -1130,7 +1130,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>  static void aspeed_video_set_resolution(struct aspeed_video *video)
>  {
>  	struct v4l2_bt_timings *act = &video->active_timings;
> -	unsigned int size = act->width * act->height;
> +	unsigned int size = act->width * ALIGN(act->height, 8);
>  
>  	/* Set capture/compression frame sizes */
>  	aspeed_video_calc_compressed_size(video, size);
> @@ -1147,7 +1147,7 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>  		u32 width = ALIGN(act->width, 64);
>  
>  		aspeed_video_write(video, VE_CAP_WINDOW, width << 16 | act->height);
> -		size = width * act->height;
> +		size = width * ALIGN(act->height, 8);
>  	} else {
>  		aspeed_video_write(video, VE_CAP_WINDOW,
>  				   act->width << 16 | act->height);
> 
> base-commit: 2605e80d3438c77190f55b821c6575048c68268e

