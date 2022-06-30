From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 30 Jun 2022 03:41:52 +0000
Subject: [PATCH v6 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <YrxHRMoMYW+QDSnd@Red>
References: <20220629094426.1930589-1-neal_liu@aspeedtech.com>
 <20220629094426.1930589-2-neal_liu@aspeedtech.com> <YrxHRMoMYW+QDSnd@Red>
Message-ID: <HK0PR06MB320233EB0554D930CBFED3CC80BA9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> Sent: Wednesday, June 29, 2022 8:36 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; Randy Dunlap
> <rdunlap@infradead.org>; Herbert Xu <herbert@gondor.apana.org.au>; David
> S . Miller <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley
> <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
> <dhphadke@microsoft.com>; Johnny Huang
> <johnny_huang@aspeedtech.com>; linux-aspeed at lists.ozlabs.org;
> linux-crypto at vger.kernel.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; BMC-SW
> <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v6 1/5] crypto: aspeed: Add HACE hash driver
> 
> Le Wed, Jun 29, 2022 at 05:44:22PM +0800, Neal Liu a ?crit :
> > Hash and Crypto Engine (HACE) is designed to accelerate the throughput
> > of hash data digest, encryption, and decryption.
> >
> > Basically, HACE can be divided into two independently engines
> > - Hash Engine and Crypto Engine. This patch aims to add HACE hash
> > engine driver for hash accelerator.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > ---
> 
> Hello
> 
> I have some minor comments below.
> 
> > +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > @@ -0,0 +1,1428 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2021 Aspeed Technology Inc.
> > + */
> > +
> > +#include "aspeed-hace.h"
> > +
> > +#ifdef ASPEED_AHASH_DEBUG
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__) #else
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	((void)(h))
> > +#endif
> 
> Hello why not direclty use dev_dbg ?
> You will still need something to do to enable dev_dbg, so why force to add the
> need to re-compile it with ASPEED_AHASH_DEBUG ?

My purpose is to control its own debug logs independently.
Maybe below define is more reasonable.

#ifdef ASPEED_AHASH_DEBUG
#define AHASH_DBG dev_info()...
#else
#define AHASH_DBG dev_dbg()...
#endif

Do you agree with this?

> 
> 
> [...]
> 
> > +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> > +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> > +		return -ENOMEM;
> > +	}
> 
> An error displayed as warning.
> 
> [...]
> > +	if (!sg_len) {
> > +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> 
> Same here. In fact you have lot of error displayed as warning in the driver.

I think both of them are fine. Would you prefer dev_err() instead?

> 
> [...]
> > +/* Weak function for HACE hash */
> > +void __weak aspeed_register_hace_hash_algs(struct aspeed_hace_dev
> > +*hace_dev) {
> > +	pr_warn("%s: Not supported yet\n", __func__); }
> > +
> > +void __weak aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev
> > +*hace_dev) {
> > +	pr_warn("%s: Not supported yet\n", __func__); }
> 
> Why not use dev_warn ?

dev_warn() is better, I'll revise it in next patch.

> 
> 
> [...]
> 
> > +struct aspeed_sg_list {
> > +	u32 len;
> > +	u32 phy_addr;
> > +};
> 
> Since it is a descriptor where all member are written with cpu_to_le32(), it
> should be __le32.

Sure! I'll revise it in next patch.
Thanks.

