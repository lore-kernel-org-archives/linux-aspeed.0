From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Wed, 29 Jun 2022 14:36:20 +0200
Subject: [PATCH v6 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <20220629094426.1930589-2-neal_liu@aspeedtech.com>
References: <20220629094426.1930589-1-neal_liu@aspeedtech.com>
 <20220629094426.1930589-2-neal_liu@aspeedtech.com>
Message-ID: <YrxHRMoMYW+QDSnd@Red>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le Wed, Jun 29, 2022 at 05:44:22PM +0800, Neal Liu a ?crit :
> Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption, and decryption.
> 
> Basically, HACE can be divided into two independently engines
> - Hash Engine and Crypto Engine. This patch aims to add HACE
> hash engine driver for hash accelerator.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> ---

Hello

I have some minor comments below.

> +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> @@ -0,0 +1,1428 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2021 Aspeed Technology Inc.
> + */
> +
> +#include "aspeed-hace.h"
> +
> +#ifdef ASPEED_AHASH_DEBUG
> +#define AHASH_DBG(h, fmt, ...)	\
> +	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> +#else
> +#define AHASH_DBG(h, fmt, ...)	\
> +	((void)(h))
> +#endif

Hello why not direclty use dev_dbg ?
You will still need something to do to enable dev_dbg, so why force to add the need to re-compile it with ASPEED_AHASH_DEBUG ?


[...]

> +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> +		return -ENOMEM;
> +	}

An error displayed as warning.

[...]
> +	if (!sg_len) {
> +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");

Same here. In fact you have lot of error displayed as warning in the driver.

[...]
> +/* Weak function for HACE hash */
> +void __weak aspeed_register_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	pr_warn("%s: Not supported yet\n", __func__);
> +}
> +
> +void __weak aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	pr_warn("%s: Not supported yet\n", __func__);
> +}

Why not use dev_warn ?


[...]

> +struct aspeed_sg_list {
> +	u32 len;
> +	u32 phy_addr;
> +};

Since it is a descriptor where all member are written with cpu_to_le32(), it should be __le32.

Regards
