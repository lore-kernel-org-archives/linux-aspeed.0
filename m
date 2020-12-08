From: Joel Stanley <joel@jms.id.au>
Date: Tue, 8 Dec 2020 02:39:55 +0000
Subject: [PATCH 2/2] media: aspeed: fix clock handling logic
In-Reply-To: <20201207164240.15436-3-jae.hyun.yoo@linux.intel.com>
References: <20201207164240.15436-1-jae.hyun.yoo@linux.intel.com>
 <20201207164240.15436-3-jae.hyun.yoo@linux.intel.com>
Message-ID: <CACPK8Xd3dz1WLGNGqMiAZxhMEeGHbkPtvO2rYQ36Kbj=Uvy-jA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 7 Dec 2020 at 16:33, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>
> Video engine uses eclk and vclk for its clock sources and its reset
> control is coupled with eclk so the current clock enabling sequence works
> like below.
>
>  Enable eclk
>  De-assert Video Engine reset
>  10ms delay
>  Enable vclk

This is the case after " clk: ast2600: fix reset settings for eclk and
vclk" is applied, correct? Without that patch applied the reset
sequence is correct by accident for the 2600, but it will be wrong for
the 2500?

> It introduces improper reset on the Video Engine hardware and eventually
> the hardware generates unexpected DMA memory transfers that can corrupt
> memory region in random and sporadic patterns. This issue is observed
> very rarely on some specific AST2500 SoCs but it causes a critical
> kernel panic with making a various shape of signature so it's extremely
> hard to debug.

I wasn't sure what you meant by "various shape of signature". Can you
elaborate, and/or share with us some examples of the signature?

> Moreover, the issue is observed even when the video
> engine is not actively used because udevd turns on the video engine
> hardware for a short time to make a query in every boot.
>
> To fix this issue, this commit changes the clock handling logic to make
> the reset de-assertion triggered after enabling both eclk and vclk. Also,
> it adds clk_unprepare call for a case when probe fails.
>
> Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

The code change looks correct and should be applied to stable.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/media/platform/aspeed-video.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index c46a79eace98..db072ff2df70 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -514,8 +514,8 @@ static void aspeed_video_off(struct aspeed_video *video)
>         aspeed_video_write(video, VE_INTERRUPT_STATUS, 0xffffffff);
>
>         /* Turn off the relevant clocks */
> -       clk_disable(video->vclk);
>         clk_disable(video->eclk);
> +       clk_disable(video->vclk);
>
>         clear_bit(VIDEO_CLOCKS_ON, &video->flags);
>  }
> @@ -526,8 +526,8 @@ static void aspeed_video_on(struct aspeed_video *video)
>                 return;
>
>         /* Turn on the relevant clocks */
> -       clk_enable(video->eclk);
>         clk_enable(video->vclk);
> +       clk_enable(video->eclk);
>
>         set_bit(VIDEO_CLOCKS_ON, &video->flags);
>  }
> @@ -1719,8 +1719,11 @@ static int aspeed_video_probe(struct platform_device *pdev)
>                 return rc;
>
>         rc = aspeed_video_setup_video(video);
> -       if (rc)
> +       if (rc) {
> +               clk_unprepare(video->vclk);
> +               clk_unprepare(video->eclk);
>                 return rc;
> +       }
>
>         return 0;
>  }
> --
> 2.17.1
>
