From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Tue, 12 Apr 2022 21:12:36 +0000
Subject: [PATCH] peci: fix error check return value of platform_get_irq()
In-Reply-To: <20220412090148.2533219-1-lv.ruyi@zte.com.cn>
References: <20220412090148.2533219-1-lv.ruyi@zte.com.cn>
Message-ID: <d09484f7cda13de3f156bd1bcba8c2671495dcd1.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2022-04-12 at 09:01 +0000, cgel.zte at gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>

Thanks for the fix. Can we prefix the subject with "peci: aspeed:"? Just to
distinguish changes related to specific controller from the ones touching peci-
core.

> 
> platform_get_irq() return negative value on failure, so null check of
> priv->irq is incorrect. Fix it by comparing whether it is less than zero.
> 
> Fixes: a85e4c52086c ("peci: Add peci-aspeed controller driver")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Iwona Winiarska <iwona.winiarska@intel.com>

-Iwona

> ---
> ?drivers/peci/controller/peci-aspeed.c | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/peci/controller/peci-aspeed.c
> b/drivers/peci/controller/peci-aspeed.c
> index 1925ddc13f00..731c5d8f75c6 100644
> --- a/drivers/peci/controller/peci-aspeed.c
> +++ b/drivers/peci/controller/peci-aspeed.c
> @@ -523,7 +523,7 @@ static int aspeed_peci_probe(struct platform_device *pdev)
> ????????????????return PTR_ERR(priv->base);
> ?
> ????????priv->irq = platform_get_irq(pdev, 0);
> -???????if (!priv->irq)
> +???????if (priv->irq < 0)
> ????????????????return priv->irq;
> ?
> ????????ret = devm_request_irq(&pdev->dev, priv->irq, aspeed_peci_irq_handler,
