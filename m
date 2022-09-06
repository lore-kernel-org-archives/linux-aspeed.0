From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 6 Sep 2022 02:21:20 +0000
Subject: [PATCH v2] crypto: aspeed: fix build module error
In-Reply-To: <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
References: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
 <YxXXuyNrQIcMZBLI@gondor.apana.org.au>
Message-ID: <HK0PR06MB3202F47019416BA40859C7D4807E9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Monday, September 5, 2022 7:04 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: David S . Miller <davem@davemloft.net>; Joel Stanley <joel@jms.id.au>;
> Andrew Jeffery <andrew@aj.id.au>; linux-aspeed at lists.ozlabs.org;
> linux-crypto at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>; kernel
> test robot <lkp@intel.com>; Sudip Mukherjee
> <sudipm.mukherjee@gmail.com>
> Subject: Re: [PATCH v2] crypto: aspeed: fix build module error
> 
> On Mon, Sep 05, 2022 at 10:54:33AM +0800, Neal Liu wrote:
> >
> > diff --git a/drivers/crypto/aspeed/Makefile
> > b/drivers/crypto/aspeed/Makefile index 421e2ca9c53e..3be78cec0ecb
> > 100644
> > --- a/drivers/crypto/aspeed/Makefile
> > +++ b/drivers/crypto/aspeed/Makefile
> > @@ -1,9 +1,6 @@
> > +hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace.o
> > +aspeed-hace-hash.o
> > +hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=
> aspeed-hace.o
> > +aspeed-hace-crypto.o
> > +
> >  obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
> > -aspeed_crypto-objs := aspeed-hace.o	\
> > -		      $(hace-hash-y)	\
> > +aspeed_crypto-objs := $(hace-hash-y)	\
> >  		      $(hace-crypto-y)
> 
> Does this still build if both HASH and CRYPTO are off?
> 
> I think this it's best if you do:
> 
> hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=
> aspeed-hace-hash.o
> hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=
> aspeed-hace-crypto.o
> 
> obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
> aspeed_crypto-objs := aspeed-hace.o	\
> 		      $(hace-hash-y)	\
> 		      $(hace-crypto-y)
> 

aspeed-hace.o effects only if either hace-hash-y or hace-crypto-y.
If we put aspeed-hace.o in aspeed_crypto-objs, but hace-hash-y and hace-crypto-y are empty, apseed-hace.o is just an useless driver which might still occupy system resources.

For this patch, you're right it would still build if both HASH & CRYPTO are off. But no driver would be run up.
That's why I revise it from your suggestion to this patch.
Thanks.

> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
