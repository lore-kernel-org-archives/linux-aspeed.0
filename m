From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 7 Jun 2022 03:05:59 +0000
Subject: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <349c0714-5ec8-4233-0f0d-669e4ad3bf59@wanadoo.fr>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-2-neal_liu@aspeedtech.com>
 <349c0714-5ec8-4233-0f0d-669e4ad3bf59@wanadoo.fr>
Message-ID: <HK0PR06MB3202D3E4A6B48BCA5C4417D880A59@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Le 06/06/2022 ? 08:49, Neal Liu a ?crit?:
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
> [...]
> 
> > +static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
> > +{
> > +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> > +	struct ahash_request *req = hash_engine->ahash_req;
> > +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> > +	struct device *dev = hace_dev->dev;
> > +	int length, remain;
> > +	int rc = 0;
> > +
> > +	length = rctx->total + rctx->bufcnt;
> > +	remain = length % rctx->block_size;
> > +
> > +	AHASH_DBG(hace_dev, "length:0x%x, remain:0x%x\n", length, remain);
> > +
> > +	if (rctx->bufcnt)
> > +		memcpy(hash_engine->ahash_src_addr, rctx->buffer, rctx->bufcnt);
> > +
> > +	if (rctx->total + rctx->bufcnt < ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
> > +		scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
> > +					 rctx->bufcnt, rctx->src_sg,
> > +					 rctx->offset, rctx->total - remain, 0);
> > +		rctx->offset += rctx->total - remain;
> > +
> > +	} else {
> > +		dev_warn(dev, "Hash data length is too large\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
> > +				 rctx->offset, remain, 0);
> > +
> > +	rctx->bufcnt = remain;
> > +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
> > +					       SHA512_DIGEST_SIZE,
> > +					       DMA_BIDIRECTIONAL);
> > +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> > +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> > +		rc = -ENOMEM;
> > +		goto free;
> > +	}
> > +
> > +	hash_engine->src_length = length - remain;
> > +	hash_engine->src_dma = hash_engine->ahash_src_dma_addr;
> > +	hash_engine->digest_dma = rctx->digest_dma_addr;
> > +
> > +	return 0;
> > +
> > +free:
> > +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> > +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> 
> Here, dma_map_single() has failed. Do we need to unmap? (other calls below
> don't)
> 

Correct. I miss this part. I'll revise it in next patch, thanks.

> > +	return rc;
> > +}
> > +
> > +/*
> > + * Prepare DMA buffer as SG list buffer before
> > + * hardware engine processing.
> > + */
> > +static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev
> > +*hace_dev) {
> > +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> > +	struct ahash_request *req = hash_engine->ahash_req;
> > +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> > +	struct aspeed_sg_list *src_list;
> > +	struct scatterlist *s;
> > +	int length, remain, sg_len, i;
> > +	int rc = 0;
> > +
> > +	remain = (rctx->total + rctx->bufcnt) % rctx->block_size;
> > +	length = rctx->total + rctx->bufcnt - remain;
> > +
> > +	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> > +		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
> > +		  "length", length, "remain", remain);
> > +
> > +	sg_len = dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> > +			    DMA_TO_DEVICE);
> > +	if (!sg_len) {
> > +		dev_warn(hace_dev->dev, "dma_map_sg() src error\n");
> > +		rc = -ENOMEM;
> 
> Direct return, as done in v1, looks fine to me. But it is mostly a matter of test, I
> guess.
> 
> > +		goto end;
> > +	}
> > +
> > +	src_list = (struct aspeed_sg_list *)hash_engine->ahash_src_addr;
> > +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
> > +					       SHA512_DIGEST_SIZE,
> > +					       DMA_BIDIRECTIONAL);
> > +	if (dma_mapping_error(hace_dev->dev, rctx->digest_dma_addr)) {
> > +		dev_warn(hace_dev->dev, "dma_map() rctx digest error\n");
> > +		rc = -ENOMEM;
> > +		goto free_src_sg;
> > +	}
> > +
> > +	if (rctx->bufcnt != 0) {
> > +		rctx->buffer_dma_addr = dma_map_single(hace_dev->dev,
> > +						       rctx->buffer,
> > +						       rctx->block_size * 2,
> > +						       DMA_TO_DEVICE);
> > +		if (dma_mapping_error(hace_dev->dev, rctx->buffer_dma_addr)) {
> > +			dev_warn(hace_dev->dev, "dma_map() rctx buffer error\n");
> > +			rc = -ENOMEM;
> > +			goto free_rctx_digest;
> > +		}
> > +
> > +		src_list[0].phy_addr = rctx->buffer_dma_addr;
> > +		src_list[0].len = rctx->bufcnt;
> > +		length -= src_list[0].len;
> > +
> > +		/* Last sg list */
> > +		if (length == 0)
> > +			src_list[0].len |= HASH_SG_LAST_LIST;
> > +		src_list++;
> > +	}
> > +
> > +	if (length != 0) {
> > +		for_each_sg(rctx->src_sg, s, sg_len, i) {
> > +			src_list[i].phy_addr = sg_dma_address(s);
> > +
> > +			if (length > sg_dma_len(s)) {
> > +				src_list[i].len = sg_dma_len(s);
> > +				length -= sg_dma_len(s);
> > +
> > +			} else {
> > +				/* Last sg list */
> > +				src_list[i].len = length;
> > +				src_list[i].len |= HASH_SG_LAST_LIST;
> > +				length = 0;
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (length != 0) {
> > +		rc = -EINVAL;
> > +		goto free_rctx_buffer;
> > +	}
> > +
> > +	rctx->offset = rctx->total - remain;
> > +	hash_engine->src_length = rctx->total + rctx->bufcnt - remain;
> > +	hash_engine->src_dma = hash_engine->ahash_src_dma_addr;
> > +	hash_engine->digest_dma = rctx->digest_dma_addr;
> > +
> > +	goto end;
> > +
> > +free_rctx_buffer:
> > +	dma_unmap_single(hace_dev->dev, rctx->buffer_dma_addr,
> > +			 rctx->block_size * 2, DMA_TO_DEVICE);
> 
> If "rctx->bufcnt == 0" the correspondning dma_map_single() has not been
> called. Is it an issue? (the test exists in aspeed_ahash_update_resume_sg(), so
> I guess it is needed)
> 
> > +free_rctx_digest:
> > +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> > +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> > +free_src_sg:
> > +	dma_unmap_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> > +		     DMA_TO_DEVICE);
> > +end:
> > +	return rc;
> > +}
> > +
> 
> [...]
> 
> > +
> > +#define HASH_SG_LAST_LIST               BIT(31)
> 
> Tab as done in the other #define?

Sure !

[...]
