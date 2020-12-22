From: Joel Stanley <joel@jms.id.au>
Date: Tue, 22 Dec 2020 04:49:00 +0000
Subject: [PATCH 3/3] aspeed-video: add COMP_READY to VE_SPURIOUS_IRQS
In-Reply-To: <20201215024542.18888-4-zev@bewilderbeest.net>
References: <20201215024542.18888-1-zev@bewilderbeest.net>
 <20201215024542.18888-4-zev@bewilderbeest.net>
Message-ID: <CACPK8XdAfYaAPeyDL4nsG+04xgr-u3+CQKNNdpHAQb4vG7=54g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 15 Dec 2020 at 02:46, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> This joins CAPTURE_COMPLETE and FRAME_COMPLETE in the set of interrupts
> that have been seen asserted by the hardware even when disabled, leading
> to the interrupt eventually getting disabled as described in commit
> 65d270acb2d662c3346793663ac3a759eb4491b8.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

I have less experience with this part of the chip, so I defer to Jae
or Ryan for an ack.

> ---
>  drivers/media/platform/aspeed-video.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 218aae3be809..48c52bf91a1b 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -564,7 +564,8 @@ static void aspeed_video_irq_res_change(struct aspeed_video *video, ulong delay)
>   * register.
>   */
>  #define VE_SPURIOUS_IRQS \
> -       (VE_INTERRUPT_CAPTURE_COMPLETE | VE_INTERRUPT_FRAME_COMPLETE)
> +       (VE_INTERRUPT_CAPTURE_COMPLETE | VE_INTERRUPT_FRAME_COMPLETE \
> +        | VE_INTERRUPT_COMP_READY)
>
>  static irqreturn_t aspeed_video_irq(int irq, void *arg)
>  {
> --
> 2.29.2
>
