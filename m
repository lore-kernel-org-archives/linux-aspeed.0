From: Joel Stanley <joel@jms.id.au>
Date: Tue, 24 Aug 2021 04:52:13 +0000
Subject: [PATCH -next] soc: aspeed-lpc-ctrl: Fix missing
 clk_disable_unprepare() on error in aspeed_lpc_ctrl_probe()
In-Reply-To: <20210823130043.1087204-1-yangyingliang@huawei.com>
References: <20210823130043.1087204-1-yangyingliang@huawei.com>
Message-ID: <CACPK8XeUJV2cCaCu+xnX-pGkHVxV9vp3LPj8dJbJbi8SC4Bazw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 23 Aug 2021 at 12:55, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Fix the missing clk_disable_unprepare() before return
> from aspeed_lpc_ctrl_probe() in the error handling case.
>
> Fixes: 2f9b25fa6682 ("soc: aspeed: Re-enable FWH2AHB on AST2600")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/soc/aspeed/aspeed-lpc-ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> index 6893c5ec3259..f4c989584d6b 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> @@ -312,7 +312,8 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>                 lpc_ctrl->scu = syscon_regmap_lookup_by_compatible("aspeed,ast2600-scu");
>                 if (IS_ERR(lpc_ctrl->scu)) {
>                         dev_err(dev, "couldn't find scu\n");
> -                       return PTR_ERR(lpc_ctrl->scu);
> +                       rc = PTR_ERR(lpc_ctrl->scu);
> +                       goto err;

Thanks for the patch. Alternatively, we could move this code above the
devm_clk_get/clk_prepare_enable. I would prefer that option, if you
want to send a v2.

Cheers,

Joel
