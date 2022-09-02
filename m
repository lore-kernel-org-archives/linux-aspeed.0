From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 2 Sep 2022 18:29:14 +0800
Subject: [PATCH] crypto: aspeed: fix build module error
In-Reply-To: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
References: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
Message-ID: <YxHa+g256XL/vz8q@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 29, 2022 at 03:20:35PM +0800, Neal Liu wrote:
>
>  obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
>  hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
>  obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) += aspeed-hace-crypto.o
>  hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace-crypto.o

Why are these two files being included twice? I think the obj-
lines should be deleted.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
