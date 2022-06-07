From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 7 Jun 2022 03:43:34 +0000
Subject: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <Yp5Y3WKhGklwgMTp@Red>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-2-neal_liu@aspeedtech.com> <Yp5Y3WKhGklwgMTp@Red>
Message-ID: <HK0PR06MB3202FEC488851225569DD0AE80A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Le Mon, Jun 06, 2022 at 02:49:31PM +0800, Neal Liu a ?crit :
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
> >  MAINTAINERS                              |    7 +
> >  drivers/crypto/Kconfig                   |    1 +
> >  drivers/crypto/Makefile                  |    1 +
> >  drivers/crypto/aspeed/Kconfig            |   22 +
> >  drivers/crypto/aspeed/Makefile           |    6 +
> >  drivers/crypto/aspeed/aspeed-hace-hash.c | 1409
> ++++++++++++++++++++++
> >  drivers/crypto/aspeed/aspeed-hace.c      |  221 ++++
> >  drivers/crypto/aspeed/aspeed-hace.h      |  182 +++
> >  8 files changed, 1849 insertions(+)
> >  create mode 100644 drivers/crypto/aspeed/Kconfig  create mode 100644
> > drivers/crypto/aspeed/Makefile  create mode 100644
> > drivers/crypto/aspeed/aspeed-hace-hash.c
> >  create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
> >  create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
> 
> Hello please see my comments below.
> 
> [...]
> 
> > diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c
> > b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > new file mode 100644
> > index 000000000000..9b003e12b2c8
> > --- /dev/null
> > +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > @@ -0,0 +1,1409 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2021 Aspeed Technology Inc.
> > + */
> > +
> > +#include "aspeed-hace.h"
> > +
> > +//#define ASPEED_AHASH_DEBUG
> 
> Please remove this

Sure !

> 
> [...]
> 
> > +
> > +#ifdef ASPEED_AHASH_DEBUG
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__) #else
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	((void)(h))
> > +#endif
> 
> Why not using dev_dbg() ?

dev_dbg() would be nice. I'll revise it.

> 
> [...]
> > +	sg_len = dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> > +			    DMA_TO_DEVICE);
> > +	if (!sg_len) {
> > +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> > +		rc = -ENOMEM;
> > +		goto end;
> > +	}
> 
> This test does handle the possible negative return of dma_map_sg()

Zero is returned for any error of dma_map_sg().

> 
> [...]
> > +	memset(bctx->ipad + keylen, 0, bs - keylen);
> > +	memcpy(bctx->opad, bctx->ipad, bs);
> > +
> > +	for (i = 0; i < bs; i++) {
> > +		bctx->ipad[i] ^= 0x36;
> > +		bctx->opad[i] ^= 0x5c;
> 
> Please use HMAC_OPAD_VALUE and HMAC_IPAD_VALUE from
> include/crypto/hmac.h
> 

Thanks for the notice. I'll revise it in next patch, thanks.

> [...]
> > +int aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> > +{
> > +	int rc, i;
> > +
> > +	AHASH_DBG(hace_dev, "\n");
> > +
> > +	for (i = 0; i < ARRAY_SIZE(aspeed_ahash_algs); i++) {
> > +		aspeed_ahash_algs[i].hace_dev = hace_dev;
> > +		rc = crypto_register_ahash(&aspeed_ahash_algs[i].alg.ahash);
> > +		if (rc)
> > +			return rc;
> > +	}
> 
> If any hash fail to register, the function exits but you will still unregister all
> hashes (even ones not registered) on aspeed_unregister_hace_hash_algs().

Yes. crypto/algapi.c would handle this part even if algo is not registered.
But of course we could use a variable to store which algo is registered, which is not.

> 
> [...]
> > +static int aspeed_hace_probe(struct platform_device *pdev) {
> > +	const struct of_device_id *hace_dev_id;
> > +	struct aspeed_engine_hash *hash_engine;
> > +	struct aspeed_hace_dev *hace_dev;
> > +	struct resource *res;
> > +	int rc;
> > +
> > +	hace_dev = devm_kzalloc(&pdev->dev, sizeof(struct aspeed_hace_dev),
> > +				GFP_KERNEL);
> > +	if (!hace_dev)
> > +		return -ENOMEM;
> > +
> > +	hace_dev_id = of_match_device(aspeed_hace_of_matches, &pdev->dev);
> > +	if (!hace_dev_id) {
> > +		dev_err(&pdev->dev, "Failed to match hace dev id\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	hace_dev->dev = &pdev->dev;
> > +	hace_dev->version = (unsigned long)hace_dev_id->data;
> > +	hash_engine = &hace_dev->hash_engine;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +
> > +	platform_set_drvdata(pdev, hace_dev);
> > +
> > +	spin_lock_init(&hash_engine->lock);
> > +	tasklet_init(&hash_engine->done_task, aspeed_hace_hash_done_task,
> > +		     (unsigned long)hace_dev);
> > +	tasklet_init(&hash_engine->queue_task, aspeed_hace_hash_queue_task,
> > +		     (unsigned long)hace_dev);
> > +	crypto_init_queue(&hash_engine->queue,
> ASPEED_HASH_QUEUE_LENGTH);
> > +
> > +	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
> > +	if (!hace_dev->regs) {
> > +		dev_err(&pdev->dev, "Failed to map resources\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	hace_dev->irq = platform_get_irq(pdev, 0);
> > +	if (!hace_dev->irq) {
> > +		dev_err(&pdev->dev, "Failed to get interrupt\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	rc = devm_request_irq(&pdev->dev, hace_dev->irq, aspeed_hace_irq, 0,
> > +			      dev_name(&pdev->dev), hace_dev);
> > +	if (rc) {
> > +		dev_err(&pdev->dev, "Failed to request interrupt\n");
> > +		return rc;
> > +	}
> > +
> > +	hace_dev->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(hace_dev->clk)) {
> > +		dev_err(&pdev->dev, "Failed to get clk\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	rc = clk_prepare_enable(hace_dev->clk);
> > +	if (rc) {
> > +		dev_err(&pdev->dev, "Failed to enable clock 0x%x\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	hash_engine->ahash_src_addr =
> > +		dma_alloc_coherent(&pdev->dev,
> > +				   ASPEED_HASH_SRC_DMA_BUF_LEN,
> > +				   &hash_engine->ahash_src_dma_addr,
> > +				   GFP_KERNEL);
> > +	if (!hash_engine->ahash_src_addr) {
> > +		dev_err(&pdev->dev, "Failed to allocate dma buffer\n");
> > +		rc = -ENOMEM;
> > +		goto end;
> > +	}
> > +
> > +	rc = aspeed_hace_register(hace_dev);
> > +	if (rc) {
> > +		dev_err(&pdev->dev, "Failed to register algs, rc:0x%x\n", rc);
> > +		rc = 0;
> > +	}
> 
> So you print an error but you keep the driver loaded even if no hashes (or a
> limited number of them) are registered, for which interest ?
> 

Take PATCH 5/5 as consideration, aspeed_hace_register() would register both hashes & skciphers.
So even one of them failed, the driver still can be loaded.

> [...]
> > +struct aspeed_sham_ctx {
> > +	struct aspeed_hace_dev		*hace_dev;
> > +	unsigned long			flags;	/* hmac flag */
> > +
> > +	/* fallback stuff */
> > +	struct aspeed_sha_hmac_ctx	base[0];
> 
> I am not sure to understand the [0] purpose, and the comment said something
> about fallback, but your driver dont do any real fallback.

[0] is a convenience to reference it as a pointer.
The comment should be removed, thanks.

> 
> [...]
> > +struct aspeed_hace_dev {
> > +	void __iomem			*regs;
> > +	void __iomem			*sec_regs;
> 
> sec_regs is unused.

I miss this part, I'll revise it in next patch, thanks.

> 
> > +	struct device			*dev;
> > +	int				irq;
> > +	struct clk			*clk;
> > +	unsigned long			version;
> > +	struct aspeed_engine_hash	hash_engine;
> > +};
> > +
> > +struct aspeed_hace_alg {
> > +	struct aspeed_hace_dev		*hace_dev;
> > +	union {
> > +		struct skcipher_alg	skcipher;
> > +		struct aead_alg		aead;
> > +		struct ahash_alg	ahash;
> > +		struct kpp_alg		kpp;
> > +		struct akcipher_alg	akcipher;
> 
> Your patch dont do any kpp or akcipher (and aead/skcipher also).
> Please drop this.

I miss this part, I'll revise it in next patch, thanks.

> 
> Regards
