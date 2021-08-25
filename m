From: Lei Yu <yulei.sh@bytedance.com>
Date: Wed, 25 Aug 2021 10:14:16 +0800
Subject: [Phishing Risk] [External] [PATCH v3] media: aspeed-video: ignore
 interrupts that aren't enabled
In-Reply-To: <20210617220229.7352-1-zev@bewilderbeest.net>
References: <20210617220229.7352-1-zev@bewilderbeest.net>
Message-ID: <CAGm54UEvQG9_AiL_o9R3ZVpF4oT0Te7DC+oHLWsNGrwVuCfJJw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Jun 18, 2021 at 6:02 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> As partially addressed in commit 65d270acb2d6 ("media: aspeed: clear
> garbage interrupts"), the ASpeed video engine sometimes asserts
> interrupts that the driver hasn't enabled.  In addition to the
> CAPTURE_COMPLETE and FRAME_COMPLETE interrupts dealt with in that
> patch, COMP_READY has also been observed.  Instead of playing
> whack-a-mole with each one individually, we can instead just blanket
> ignore everything we haven't explicitly enabled.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>
> Changes since v2 [1]:
>  - minor commit message improvements
>
> Changes since v1 [0]:
>  - dropped error message
>  - switched to a blanket-ignore approach as suggested by Ryan
>
> [0] https://lore.kernel.org/linux-arm-kernel/20201215024542.18888-1-zev at bewilderbeest.net/
> [1] https://lore.kernel.org/openbmc/20210506234048.3214-1-zev at bewilderbeest.net/
>
>  drivers/media/platform/aspeed-video.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 7bb6babdcade..77611c296a25 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -563,6 +563,12 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>         struct aspeed_video *video = arg;
>         u32 sts = aspeed_video_read(video, VE_INTERRUPT_STATUS);
>
> +       /*
> +        * Hardware sometimes asserts interrupts that we haven't actually
> +        * enabled; ignore them if so.
> +        */
> +       sts &= aspeed_video_read(video, VE_INTERRUPT_CTRL);
> +

Without the patch, the driver gets an unhandled IRQ in a few hours
after the KVM page is opened.
This patch is tested on Bytedance's OpenBMC system and the issue has
not been reproduced anymore.

Tested-by: Lei YU <yulei.sh@bytedance.com>

-- 
BRs,
Lei YU
