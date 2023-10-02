From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 2 Oct 2023 03:21:56 +0000
Subject: [PATCH] crypto: Move akcipher_request_cast helper to crypto
 header
In-Reply-To: <20231001201357.2052949-1-clabbe@baylibre.com>
References: <20231001201357.2052949-1-clabbe@baylibre.com>
Message-ID: <TYZPR06MB6770E43899C7AB66FF55FAC280C5A@TYZPR06MB6770.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Corentin Labbe <clabbe@baylibre.com>
> Sent: Monday, October 2, 2023 4:14 AM
> To: andrew at aj.id.au; davem at davemloft.net; herbert at gondor.apana.org.au;
> joel at jms.id.au; john.allen at amd.com; Neal Liu <neal_liu@aspeedtech.com>;
> thomas.lendacky at amd.com
> Cc: linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-crypto at vger.kernel.org; linux-kernel at vger.kernel.org; Corentin Labbe
> <clabbe@baylibre.com>
> Subject: [PATCH] crypto: Move akcipher_request_cast helper to crypto header
> 
> There is already 2 driver implementing their own akcipher_request_cast.
> In the future there will be also rockchip and allwinner driver that will need
> this.
> This is sufficient to move it in crypto headers.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>
Thanks.

> ---
>  drivers/crypto/aspeed/aspeed-acry.c | 6 ------
> drivers/crypto/ccp/ccp-crypto-rsa.c | 6 ------
>  include/crypto/akcipher.h           | 7 +++++++
>  3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/crypto/aspeed/aspeed-acry.c
> b/drivers/crypto/aspeed/aspeed-acry.c
> index 247c568aa8df..ecb6e984367b 100644
> --- a/drivers/crypto/aspeed/aspeed-acry.c
> +++ b/drivers/crypto/aspeed/aspeed-acry.c
> @@ -137,12 +137,6 @@ enum aspeed_rsa_key_mode {
>  	ASPEED_RSA_DATA_MODE,
>  };
> 
> -static inline struct akcipher_request *
> -	akcipher_request_cast(struct crypto_async_request *req)
> -{
> -	return container_of(req, struct akcipher_request, base);
> -}
> -
>  static int aspeed_acry_do_fallback(struct akcipher_request *req)  {
>  	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req); diff --git
> a/drivers/crypto/ccp/ccp-crypto-rsa.c b/drivers/crypto/ccp/ccp-crypto-rsa.c
> index a14f85512cf4..32c9f524f3d5 100644
> --- a/drivers/crypto/ccp/ccp-crypto-rsa.c
> +++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
> @@ -19,12 +19,6 @@
> 
>  #include "ccp-crypto.h"
> 
> -static inline struct akcipher_request *akcipher_request_cast(
> -	struct crypto_async_request *req)
> -{
> -	return container_of(req, struct akcipher_request, base);
> -}
> -
>  static inline int ccp_copy_and_save_keypart(u8 **kpbuf, unsigned int *kplen,
>  					    const u8 *buf, size_t sz)
>  {
> diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h index
> 670508f1dca1..4b6e610db18d 100644
> --- a/include/crypto/akcipher.h
> +++ b/include/crypto/akcipher.h
> @@ -498,4 +498,11 @@ static inline int crypto_akcipher_set_priv_key(struct
> crypto_akcipher *tfm,
> 
>  	return alg->set_priv_key(tfm, key, keylen);  }
> +
> +static inline struct akcipher_request *
> +	akcipher_request_cast(struct crypto_async_request *req) {
> +	return container_of(req, struct akcipher_request, base); }
> +
>  #endif
> --
> 2.41.0

