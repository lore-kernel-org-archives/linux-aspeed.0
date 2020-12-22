From: Joel Stanley <joel@jms.id.au>
Date: Tue, 22 Dec 2020 04:34:26 +0000
Subject: [PATCH 1/3] aspeed-video: add error message for unhandled
 interrupts
In-Reply-To: <20201215024542.18888-2-zev@bewilderbeest.net>
References: <20201215024542.18888-1-zev@bewilderbeest.net>
 <20201215024542.18888-2-zev@bewilderbeest.net>
Message-ID: <CACPK8XfPCjBbjM2V1oiD=di6MD6ewJs0NFewA0=kZfx_eL29gQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 15 Dec 2020 at 02:46, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This device seems to have a propensity for asserting interrupts that
> aren't enabled -- in addition to the CAPTURE_COMPLETE and FRAME_COMPLETE
> interrupts squashed in commit 65d270acb2d662c3346793663ac3a759eb4491b8,
> COMP_READY has also been observed.  Adding a message diagnosing what
> happened in the event of unhandled interrupt status bits should
> hopefully make the debugging process simpler for any others that pop up
> in the future.

Ryan, is this a known issue with the video engine hardware?

>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  drivers/media/platform/aspeed-video.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 7d98db1d9b52..eb02043532e3 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -562,6 +562,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>  {
>         struct aspeed_video *video = arg;
>         u32 sts = aspeed_video_read(video, VE_INTERRUPT_STATUS);
> +       u32 orig_sts = sts;
>
>         /*
>          * Resolution changed or signal was lost; reset the engine and
> @@ -639,6 +640,10 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>         if (sts & VE_INTERRUPT_FRAME_COMPLETE)
>                 sts &= ~VE_INTERRUPT_FRAME_COMPLETE;
>
> +       if (sts)
> +               dev_err_ratelimited(video->dev, "unexpected interrupt asserted:"
> +                                   " sts=%08x, orig_sts=%08x", sts, orig_sts);

Do you want to do this before clearing the FRAME and CAPTURE bits?

> +
>         return sts ? IRQ_NONE : IRQ_HANDLED;
>  }
>
> --
> 2.29.2
>
