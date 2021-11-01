From: Joel Stanley <joel@jms.id.au>
Date: Mon, 1 Nov 2021 23:33:08 +0000
Subject: [PATCH -next 4/4] ipmi: kcs_bmc_aspeed: add clock control logic
In-Reply-To: <20211101233751.49222-5-jae.hyun.yoo@intel.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <20211101233751.49222-5-jae.hyun.yoo@intel.com>
Message-ID: <CACPK8Xc-NVyZ31+_L8oL3aaGHX9TLRxJy9666570ZOuirUYw_w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 1 Nov 2021 at 23:18, <jae.hyun.yoo@intel.com> wrote:
>
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>
> If LPC KCS driver is registered ahead of lpc-ctrl module, LPC
> KCS block will be enabled without heart beating of LCLK until
> lpc-ctrl enables the LCLK. This issue causes improper handling on
> host interrupts when the host sends interrupts in that time frame.
> Then kernel eventually forcibly disables the interrupt with
> dumping stack and printing a 'nobody cared this irq' message out.
>
> To prevent this issue, all LPC sub drivers should enable LCLK
> individually so this patch adds clock control logic into the LPC
> KCS driver.
>
> Fixes: be2ed207e374 ("ipmi: add an Aspeed KCS IPMI BMC driver")
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/char/ipmi/kcs_bmc_aspeed.c | 31 ++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
> index 92a37b33494c..00706472cc4d 100644
> --- a/drivers/char/ipmi/kcs_bmc_aspeed.c
> +++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
> @@ -6,6 +6,7 @@
>  #define pr_fmt(fmt) "aspeed-kcs-bmc: " fmt
>
>  #include <linux/atomic.h>
> +#include <linux/clk.h>
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -126,6 +127,8 @@ struct aspeed_kcs_bmc {
>                 bool remove;
>                 struct timer_list timer;
>         } obe;
> +
> +       struct clk *clk;
>  };
>
>  struct aspeed_kcs_of_ops {
> @@ -620,24 +623,37 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> +       priv->clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(priv->clk)) {
> +               rc = PTR_ERR(priv->clk);
> +               if (rc != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "Couldn't get clock\n");
> +               return rc;
> +       }
> +       rc = clk_prepare_enable(priv->clk);
> +       if (rc) {
> +               dev_err(&pdev->dev, "Couldn't enable clock\n");
> +               return rc;
> +       }
> +
>         spin_lock_init(&priv->obe.lock);
>         priv->obe.remove = false;
>         timer_setup(&priv->obe.timer, aspeed_kcs_check_obe, 0);
>
>         rc = aspeed_kcs_set_address(kcs_bmc, addrs, nr_addrs);
>         if (rc)
> -               return rc;
> +               goto err;
>
>         /* Host to BMC IRQ */
>         rc = aspeed_kcs_config_downstream_irq(kcs_bmc, pdev);
>         if (rc)
> -               return rc;
> +               goto err;
>
>         /* BMC to Host IRQ */
>         if (have_upstream_irq) {
>                 rc = aspeed_kcs_config_upstream_irq(priv, upstream_irq[0], upstream_irq[1]);
>                 if (rc < 0)
> -                       return rc;
> +                       goto err;
>         } else {
>                 priv->upstream_irq.mode = aspeed_kcs_irq_none;
>         }
> @@ -650,13 +666,19 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
>         rc = kcs_bmc_add_device(&priv->kcs_bmc);
>         if (rc) {
>                 dev_warn(&pdev->dev, "Failed to register channel %d: %d\n", kcs_bmc->channel, rc);
> -               return rc;
> +               goto err;
>         }
>
>         dev_info(&pdev->dev, "Initialised channel %d at 0x%x\n",
>                         kcs_bmc->channel, addrs[0]);
>
>         return 0;
> +
> +err:
> +       aspeed_kcs_enable_channel(kcs_bmc, false);
> +       clk_disable_unprepare(priv->clk);
> +
> +       return rc;
>  }
>
>  static int aspeed_kcs_remove(struct platform_device *pdev)
> @@ -664,6 +686,7 @@ static int aspeed_kcs_remove(struct platform_device *pdev)
>         struct aspeed_kcs_bmc *priv = platform_get_drvdata(pdev);
>         struct kcs_bmc_device *kcs_bmc = &priv->kcs_bmc;
>
> +       clk_disable_unprepare(priv->clk);
>         kcs_bmc_remove_device(kcs_bmc);
>
>         aspeed_kcs_enable_channel(kcs_bmc, false);
> --
> 2.25.1
>
