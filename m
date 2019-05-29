From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 29 May 2019 11:07:31 -0500
Subject: [PATCH v2 09/11] media: aspeed: use different delays for
 triggering VE H/W reset
In-Reply-To: <20190524231725.12320-10-jae.hyun.yoo@linux.intel.com>
References: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
 <20190524231725.12320-10-jae.hyun.yoo@linux.intel.com>
Message-ID: <707fc473-0d99-018f-87b7-3f889851863c@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/24/19 6:17 PM, Jae Hyun Yoo wrote:
> In case of watchdog timeout detected while doing mode detection,
> it's better triggering video engine hardware reset immediately so
> this commit fixes code for the case. Other than the case, it will
> trigger video engine hardware reset after RESOLUTION_CHANGE_DELAY.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
> v1 -> v2:
>   New.
>
>   drivers/media/platform/aspeed-video.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 4647ed2e9e63..67f476bf0a03 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -522,7 +522,7 @@ static void aspeed_video_bufs_done(struct aspeed_video *video,
>   	spin_unlock_irqrestore(&video->lock, flags);
>   }
>   
> -static void aspeed_video_irq_res_change(struct aspeed_video *video)
> +static void aspeed_video_irq_res_change(struct aspeed_video *video, ulong delay)
>   {
>   	dev_dbg(video->dev, "Resolution changed; resetting\n");
>   
> @@ -532,7 +532,7 @@ static void aspeed_video_irq_res_change(struct aspeed_video *video)
>   	aspeed_video_off(video);
>   	aspeed_video_bufs_done(video, VB2_BUF_STATE_ERROR);
>   
> -	schedule_delayed_work(&video->res_work, RESOLUTION_CHANGE_DELAY);
> +	schedule_delayed_work(&video->res_work, delay);
>   }
>   
>   static irqreturn_t aspeed_video_irq(int irq, void *arg)
> @@ -545,7 +545,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>   	 * re-initialize
>   	 */
>   	if (sts & VE_INTERRUPT_MODE_DETECT_WD) {
> -		aspeed_video_irq_res_change(video);
> +		aspeed_video_irq_res_change(video, 0);
>   		return IRQ_HANDLED;
>   	}
>   
> @@ -563,7 +563,8 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>   			 * Signal acquired while NOT doing resolution
>   			 * detection; reset the engine and re-initialize
>   			 */
> -			aspeed_video_irq_res_change(video);
> +			aspeed_video_irq_res_change(video,
> +						    RESOLUTION_CHANGE_DELAY);
>   			return IRQ_HANDLED;
>   		}
>   	}

