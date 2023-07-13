From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 13 Jul 2023 11:13:58 +0200
Subject: [PATCH 34/58] mmc: sdhci-of-aspeed: Convert to platform remove
 callback returning void
In-Reply-To: <20230713080807.69999-34-frank.li@vivo.com>
References: <20230713080807.69999-1-frank.li@vivo.com>
 <20230713080807.69999-34-frank.li@vivo.com>
Message-ID: <20230713091358.p4r42rnhzje4avdj@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 13, 2023 at 04:07:43PM +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 25b4073f698b..42d54532cabe 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -450,22 +450,19 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int aspeed_sdhci_remove(struct platform_device *pdev)
> +static void aspeed_sdhci_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_host *host;
> -	int dead = 0;
>  
>  	host = platform_get_drvdata(pdev);
>  	pltfm_host = sdhci_priv(host);
>  
> -	sdhci_remove_host(host, dead);
> +	sdhci_remove_host(host, 0);

Please mention additional cleanups in the commit log (or split them into
separate patches).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230713/ff497f6c/attachment.sig>
