From: Joel Stanley <joel@jms.id.au>
Date: Wed, 25 Aug 2021 00:07:55 +0000
Subject: [PATCH -next v2] soc: aspeed-lpc-ctrl: Fix missing
 clk_disable_unprepare() on error in aspeed_lpc_ctrl_probe()
In-Reply-To: <20210824085522.1849410-1-yangyingliang@huawei.com>
References: <20210824085522.1849410-1-yangyingliang@huawei.com>
Message-ID: <CACPK8Xc9kfB1wYPOsitP1PAoF9dZtB-N1c=XTaaS2zPNONnv5w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 24 Aug 2021 at 08:49, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Move syscon_regmap_lookup_by_compatible() above the
> devm_clk_get() to avoid missing clk_disable_unprepare().
>
> Fixes: 2f9b25fa6682 ("soc: aspeed: Re-enable FWH2AHB on AST2600")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks for the patch. I will send it to the soc maintainers for merging.

> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index 6893c5ec3259..72771e018c42 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -295,6 +295,16 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> +       if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-lpc-ctrl")) {
> +               lpc_ctrl->fwh2ahb = true;
> +
> +               lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
> +               if (IS_ERR(lpc_ctrl->scu)) {
> +                       dev_err(dev, "couldn't find scu\n");
> +                       return PTR_ERR(lpc_ctrl->scu);
> +               }
> +       }
> +
>         lpc_ctrl->clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(lpc_ctrl->clk)) {
>                 dev_err(dev, "couldn't get clock\n");
> @@ -306,16 +316,6 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>                 return rc;
>         }
>
> -       if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-lpc-ctrl")) {
> -               lpc_ctrl->fwh2ahb = true;
> -
> -               lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
> -               if (IS_ERR(lpc_ctrl->scu)) {
> -                       dev_err(dev, "couldn't find scu\n");
> -                       return PTR_ERR(lpc_ctrl->scu);
> -               }
> -       }
> -
>         lpc_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
>         lpc_ctrl->miscdev.name = DEVICE_NAME;
>         lpc_ctrl->miscdev.fops = &aspeed_lpc_ctrl_fops;
> --
> 2.25.1
>
