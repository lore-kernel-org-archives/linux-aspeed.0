From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 13 Feb 2023 01:48:40 +0000
Subject: [PATCH] crypto: aspeed - Fix modular aspeed-acry
In-Reply-To: <Y+YRKdWUA4jjoUZ2@gondor.apana.org.au>
References: <Y+YRKdWUA4jjoUZ2@gondor.apana.org.au>
Message-ID: <TY2PR06MB3213FAE443DC7F66CC3438CB80DD9@TY2PR06MB3213.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> When aspeed-acry is enabled as a module it doesn't get built at all.  Fix this
> by adding it to obj-m.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>
 
> diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
> index 24284d812b79..15862752c053 100644
> --- a/drivers/crypto/aspeed/Makefile
> +++ b/drivers/crypto/aspeed/Makefile
> @@ -6,4 +6,6 @@ aspeed_crypto-objs := aspeed-hace.o	\
>  		      $(hace-hash-y)	\
>  		      $(hace-crypto-y)
> 
> -obj-$(CONFIG_CRYPTO_DEV_ASPEED_ACRY) += aspeed-acry.o
> +aspeed_acry-$(CONFIG_CRYPTO_DEV_ASPEED_ACRY) += aspeed-acry.o
> +
> +obj-$(CONFIG_CRYPTO_DEV_ASPEED) += $(aspeed_acry-y)
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
