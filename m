From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Mon, 5 Sep 2022 19:04:27 +0800
Subject: [PATCH v2] crypto: aspeed: fix build module error
In-Reply-To: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
References: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
Message-ID: <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 05, 2022 at 10:54:33AM +0800, Neal Liu wrote:
>
> diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
> index 421e2ca9c53e..3be78cec0ecb 100644
> --- a/drivers/crypto/aspeed/Makefile
> +++ b/drivers/crypto/aspeed/Makefile
> @@ -1,9 +1,6 @@
> +hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace.o aspeed-hace-hash.o
> +hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace.o aspeed-hace-crypto.o
> +
>  obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
> -aspeed_crypto-objs := aspeed-hace.o	\
> -		      $(hace-hash-y)	\
> +aspeed_crypto-objs := $(hace-hash-y)	\
>  		      $(hace-crypto-y)

Does this still build if both HASH and CRYPTO are off?

I think this it's best if you do:

hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace-crypto.o

obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
aspeed_crypto-objs := aspeed-hace.o	\
		      $(hace-hash-y)	\
		      $(hace-crypto-y)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
