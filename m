From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 2 Nov 2021 09:07:51 +0100
Subject: [PATCH] media: aspeed: fix mode-detect always timeout at 2nd run
In-Reply-To: <20211102071337.5983-1-jammy_huang@aspeedtech.com>
References: <20211102071337.5983-1-jammy_huang@aspeedtech.com>
Message-ID: <15c44f9a-20af-8059-1694-601821e17413@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Jammy,


On 02.11.21 08:13, Jammy Huang wrote:
> aspeed_video_get_resolution() will try to do res-detect again if the
> timing got in last try is invalid. But it will always timeout because

The verb *time out* is spelled with a space.

> VE_SEQ_CTRL_TRIG_MODE_DET only cleared after 1st mode-detect.

is only cleared?

> 
> To fix the problem, just clear VE_SEQ_CTRL_TRIG_MODE_DET before set in

before setting it?

> aspeed_video_enable_mode_detect().
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>   drivers/media/platform/aspeed-video.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index cd2b71c81e31..b470f4b68aa0 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -611,6 +611,10 @@ static void aspeed_video_enable_mode_detect(struct aspeed_video *video)
>   	aspeed_video_update(video, VE_INTERRUPT_CTRL, 0,
>   			    VE_INTERRUPT_MODE_DETECT);
>   
> +	/* Disable mode detect in order to re-trigger */
> +	aspeed_video_update(video, VE_SEQ_CTRL,
> +			    VE_SEQ_CTRL_TRIG_MODE_DET, 0);
> +
>   	/* Trigger mode detect */
>   	aspeed_video_update(video, VE_SEQ_CTRL, 0, VE_SEQ_CTRL_TRIG_MODE_DET);
>   }
> @@ -930,10 +934,6 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   			return;
>   		}
>   
> -		/* Disable mode detect in order to re-trigger */
> -		aspeed_video_update(video, VE_SEQ_CTRL,
> -				    VE_SEQ_CTRL_TRIG_MODE_DET, 0);
> -
>   		aspeed_video_check_and_set_polarity(video);
>   
>   		aspeed_video_enable_mode_detect(video);
> 

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
