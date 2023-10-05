From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 5 Oct 2023 12:09:12 +0800
Subject: [PATCH] crypto: Move akcipher_request_cast helper to crypto
 header
In-Reply-To: <20231001201357.2052949-1-clabbe@baylibre.com>
References: <20231001201357.2052949-1-clabbe@baylibre.com>
Message-ID: <ZR426DOX/NPqp5WM@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Oct 01, 2023 at 08:13:57PM +0000, Corentin Labbe wrote:
>
> diff --git a/include/crypto/akcipher.h b/include/crypto/akcipher.h
> index 670508f1dca1..4b6e610db18d 100644
> --- a/include/crypto/akcipher.h
> +++ b/include/crypto/akcipher.h
> @@ -498,4 +498,11 @@ static inline int crypto_akcipher_set_priv_key(struct crypto_akcipher *tfm,
>  
>  	return alg->set_priv_key(tfm, key, keylen);
>  }
> +
> +static inline struct akcipher_request *
> +	akcipher_request_cast(struct crypto_async_request *req)
> +{
> +	return container_of(req, struct akcipher_request, base);
> +}

Please move this to include/crypto/internal/akcipher.h.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
