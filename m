From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 5 Sep 2022 02:39:58 +0000
Subject: [PATCH] crypto: aspeed: fix build module error
In-Reply-To: <YxHa+g256XL/vz8q@gondor.apana.org.au>
References: <20220829072035.1539399-1-neal_liu@aspeedtech.com>
 <YxHa+g256XL/vz8q@gondor.apana.org.au>
Message-ID: <HK0PR06MB3202D1EED4767DFFF085C849807F9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, September 2, 2022 6:29 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: David S . Miller <davem@davemloft.net>; Joel Stanley <joel@jms.id.au>;
> Andrew Jeffery <andrew@aj.id.au>; linux-aspeed at lists.ozlabs.org;
> linux-crypto at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>; kernel
> test robot <lkp@intel.com>
> Subject: Re: [PATCH] crypto: aspeed: fix build module error
> 
> On Mon, Aug 29, 2022 at 03:20:35PM +0800, Neal Liu wrote:
> >
> >  obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
> >  hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=
> aspeed-hace-hash.o
> >  obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) +=
> aspeed-hace-crypto.o
> >  hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) :=
> > aspeed-hace-crypto.o
> 
> Why are these two files being included twice? I think the obj- lines should be
> deleted.
> 
> Thanks,

I'll send new patch within removing the redundant obj- lines.
Thanks.

> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
