From: Joel Stanley <joel@jms.id.au>
Date: Wed, 5 Oct 2022 23:50:23 +0000
Subject: [PATCH] ipmi: kcs: Poll OBF briefly to reduce OBE latency
In-Reply-To: <20220812144741.240315-1-andrew@aj.id.au>
References: <20220812144741.240315-1-andrew@aj.id.au>
Message-ID: <CACPK8XdnFPXZuzAaSMOUnV6ng9y2_ZMcAff12q8Zxvr2HJZy-w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 12 Aug 2022 at 14:48, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The ASPEED KCS devices don't provide a BMC-side interrupt for the host
> reading the output data register (ODR). The act of the host reading ODR
> clears the output buffer full (OBF) flag in the status register (STR),
> informing the BMC it can transmit a subsequent byte.
>
> On the BMC side the KCS client must enable the OBE event *and* perform a
> subsequent read of STR anyway to avoid races - the polling provides a
> window for the host to read ODR if data was freshly written while
> minimising BMC-side latency.
>

Fixes...?

> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/char/ipmi/kcs_bmc_aspeed.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index cdc88cde1e9a..417e5a3ccfae 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -399,13 +399,31 @@ static void aspeed_kcs_check_obe(struct timer_list *timer)
>  static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 state)
>  {
>         struct aspeed_kcs_bmc *priv = to_aspeed_kcs_bmc(kcs_bmc);
> +       int rc;
> +       u8 str;

str is status, it would be good to spell that out in full.

>
>         /* We don't have an OBE IRQ, emulate it */
>         if (mask & KCS_BMC_EVENT_TYPE_OBE) {
> -               if (KCS_BMC_EVENT_TYPE_OBE & state)
> -                       mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
> -               else
> +               if (KCS_BMC_EVENT_TYPE_OBE & state) {
> +                       /*
> +                        * Given we don't have an OBE IRQ, delay by polling briefly to see if we can
> +                        * observe such an event before returning to the caller. This is not
> +                        * incorrect because OBF may have already become clear before enabling the
> +                        * IRQ if we had one, under which circumstance no event will be propagated
> +                        * anyway.
> +                        *
> +                        * The onus is on the client to perform a race-free check that it hasn't
> +                        * missed the event.
> +                        */
> +                       rc = read_poll_timeout_atomic(aspeed_kcs_inb, str,
> +                                                     !(str & KCS_BMC_STR_OBF), 1, 100, false,
> +                                                     &priv->kcs_bmc, priv->kcs_bmc.ioreg.str);
> +                       /* Time for the slow path? */

The mod_timer is the slow path? The question mark threw me.

> +                       if (rc == -ETIMEDOUT)
> +                               mod_timer(&priv->obe.timer, jiffies + OBE_POLL_PERIOD);
> +               } else {
>                         del_timer(&priv->obe.timer);
> +               }
>         }
>
>         if (mask & KCS_BMC_EVENT_TYPE_IBF) {
> --
> 2.34.1
>
