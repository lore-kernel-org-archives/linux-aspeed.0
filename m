From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Wed, 29 May 2019 09:03:06 -0500
Subject: [PATCH v2 10/11] media: aspeed: fix an incorrect timeout checking
 in mode detection
In-Reply-To: <20190524231725.12320-11-jae.hyun.yoo@linux.intel.com>
References: <20190524231725.12320-1-jae.hyun.yoo@linux.intel.com>
 <20190524231725.12320-11-jae.hyun.yoo@linux.intel.com>
Message-ID: <50abcb27-30af-9dfc-3a53-4261832f272d@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 5/24/19 6:17 PM, Jae Hyun Yoo wrote:
> There is an incorrect timeout checking in mode detection logic so
> it misses resolution detecting chances. This commit fixes the bug.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
> v1 -> v2:
>   New.
>
>   drivers/media/platform/aspeed-video.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 67f476bf0a03..b05b073b63bc 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -735,7 +735,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
>   	do {
>   		if (tries) {
>   			set_current_state(TASK_INTERRUPTIBLE);
> -			if (schedule_timeout(INVALID_RESOLUTION_DELAY))
> +			if (!schedule_timeout(INVALID_RESOLUTION_DELAY))
>   				return;


schedule_timeout returns 0 when the timer has expired otherwise the 
remaining time in  jiffies will be returned. So if it was interrupted (timer did not expire 
and it returns non-zero) then we should return, rather than keep trying. 
So I think it was correct before. Thanks, Eddie

>   		}
>   

