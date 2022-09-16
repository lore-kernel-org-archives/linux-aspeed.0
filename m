From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 16 Sep 2022 18:42:07 +0800
Subject: [PATCH v2] crypto: aspeed: fix build module error
In-Reply-To: <HK0PR06MB3202F47019416BA40859C7D4807E9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
 <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
 <HK0PR06MB3202F47019416BA40859C7D4807E9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <YyRS/71B4veWJgyl@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 06, 2022 at 02:21:20AM +0000, Neal Liu wrote:
>
> > Does this still build if both HASH and CRYPTO are off?
> > 
> > I think this it's best if you do:
> > 
> > hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=
> > aspeed-hace-hash.o
> > hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=
> > aspeed-hace-crypto.o
> > 
> > obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
> > aspeed_crypto-objs := aspeed-hace.o	\
> > 		      $(hace-hash-y)	\
> > 		      $(hace-crypto-y)
> > 
> 
> aspeed-hace.o effects only if either hace-hash-y or hace-crypto-y.
> If we put aspeed-hace.o in aspeed_crypto-objs, but hace-hash-y and hace-crypto-y are empty, apseed-hace.o is just an useless driver which might still occupy system resources.

Apparently it doesn't build after all, at least not on m68k.

So please either adopt my suggestion above, or come up with another
way of preventing the build failure on m68k with both HASH and CRYPTO
disabled.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
