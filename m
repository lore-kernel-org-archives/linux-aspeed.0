From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Mon, 26 Aug 2019 10:12:47 -0500
Subject: [PATCH 3/7] media: aspeed-video: address a protential usage of an
 unit var
In-Reply-To: <7c85f7dc159927a7316dc13f52697f157fb6e2bd.1566502743.git.mchehab+samsung@kernel.org>
References: <4a411ba155eb062b6575aba0824123c840806c0b.1566502743.git.mchehab+samsung@kernel.org>
 <7c85f7dc159927a7316dc13f52697f157fb6e2bd.1566502743.git.mchehab+samsung@kernel.org>
Message-ID: <64b90f55-2d8d-718d-0562-528063f3edab@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 8/22/19 2:39 PM, Mauro Carvalho Chehab wrote:
> While this might not occur in practice, if the device is doing
> the right thing, it would be teoretically be possible to have
> both hsync_counter and vsync_counter negatives.
>
> If this ever happen, ctrl will be undefined, but the driver
> will still call:
>
> 	aspeed_video_update(video, VE_CTRL, 0, ctrl);
>
> Change the code to prevent this to happen.
>
> This was warned by cppcheck:
>
> 	[drivers/media/platform/aspeed-video.c:653]: (error) Uninitialized variable: ctrl


Thanks Mauro.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>   drivers/media/platform/aspeed-video.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index f899ac3b4a61..4ef37cfc8446 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -630,7 +630,7 @@ static void aspeed_video_check_and_set_polarity(struct aspeed_video *video)
>   	}
>   
>   	if (hsync_counter < 0 || vsync_counter < 0) {
> -		u32 ctrl;
> +		u32 ctrl = 0;
>   
>   		if (hsync_counter < 0) {
>   			ctrl = VE_CTRL_HSYNC_POL;
> @@ -650,7 +650,8 @@ static void aspeed_video_check_and_set_polarity(struct aspeed_video *video)
>   				V4L2_DV_VSYNC_POS_POL;
>   		}
>   
> -		aspeed_video_update(video, VE_CTRL, 0, ctrl);
> +		if (ctrl)
> +			aspeed_video_update(video, VE_CTRL, 0, ctrl);
>   	}
>   }
>   
