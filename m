From: Tom Lendacky <thomas.lendacky@amd.com>
Date: Mon, 2 Oct 2023 08:25:56 -0500
Subject: [PATCH] crypto: Move akcipher_request_cast helper to crypto
 header
In-Reply-To: <20231001201357.2052949-1-clabbe@baylibre.com>
References: <20231001201357.2052949-1-clabbe@baylibre.com>
Message-ID: <ce28c892-adeb-96dc-bb3c-f1244ab1ea25@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/1/23 15:13, Corentin Labbe wrote:
> There is already 2 driver implementing their own akcipher_request_cast.
> In the future there will be also rockchip and allwinner driver that will
> need this.
> This is sufficient to move it in crypto headers.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

Minor style question below...

> ---
>   drivers/crypto/aspeed/aspeed-acry.c | 6 ------
>   drivers/crypto/ccp/ccp-crypto-rsa.c | 6 ------
>   include/crypto/akcipher.h           | 7 +++++++
>   3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
> index 247c568aa8df..ecb6e984367b 100644
> --- a/drivers/crypto/aspeed/aspeed-acry.c
> +++ b/drivers/crypto/aspeed/aspeed-acry.c
> @@ -137,12 +137,6 @@ enum aspeed_rsa_key_mode {
>   	ASPEED_RSA_DATA_MODE,
>   };
>   
> -static inline struct akcipher_request *
> -	akcipher_request_cast(struct crypto_async_request *req)
> -{
> -	return container_of(req, struct akcipher_request, base);
> -}
> -
>   static int aspeed_acry_do_fallback(struct akcipher_request *req)
>   {
>   	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
> diff --git a/drivers/crypto/ccp/ccp-crypto-rsa.c b/drivers/crypto/ccp/ccp-crypto-rsa.c
> index a14f85512cf4..32c9f524f3d5 100644
> --- a/drivers/crypto/ccp/ccp-crypto-rsa.c
> +++ b/drivers/crypto/ccp/ccp-crypto-rsa.c
> @@ -19,12 +19,6 @@
>   
>   #include "ccp-crypto.h"
>   
> -static inline struct akcipher_request *akcipher_request_cast(
> -	struct crypto_async_request *req)
> -{
> -	return container_of(req, struct akcipher_request, base);
> -}
> -
>   static inline int ccp_copy_and_save_keypart(u8 **kpbuf, unsigned int *kplen,
>   					    const u8 *buf, size_t sz)
>   {
> diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
> index 670508f1dca1..4b6e610db18d 100644
> --- a/include/crypto/akcipher.h
> +++ b/include/crypto/akcipher.h
> @@ -498,4 +498,11 @@ static inline int crypto_akcipher_set_priv_key(struct crypto_akcipher *tfm,
>   
>   	return alg->set_priv_key(tfm, key, keylen);
>   }
> +
> +static inline struct akcipher_request *
> +	akcipher_request_cast(struct crypto_async_request *req)

Should this really be indented since it is the function name? I would 
think it should look like:

static inline struct akcipher_request *
akcipher_request_cast(struct crypto_async_request *req)
{

Thanks,
Tom

> +{
> +	return container_of(req, struct akcipher_request, base);
> +}
> +
>   #endif
