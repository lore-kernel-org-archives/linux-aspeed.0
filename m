From: Winiarska, Iwona <iwona.winiarska@intel.com>
Date: Mon, 15 Aug 2022 19:19:04 +0000
Subject: [PATCH] peci: Fix platform_get_irq() error checking
In-Reply-To: <YvTettdmRKZw46mb@kili>
References: <YvTettdmRKZw46mb@kili>
Message-ID: <3012726d084c09d7f5754419774cb1fea73a9874.camel@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2022-08-11 at 13:49 +0300, Dan Carpenter wrote:
> The platform_get_irq() function returns success or negative error codes
> on failure.

Hi,

The patch that fixes this problem was already picked up:
https://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git/commit/?h=peci-next&id=e79b548b7202bb3accdfe64f113129a4340bc2f9

Thanks
-Iwona

> 
> Fixes: a85e4c52086c ("peci: Add peci-aspeed controller driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
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

