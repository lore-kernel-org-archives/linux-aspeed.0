From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Wed, 1 Jun 2022 09:41:34 +0200
Subject: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <20220601054204.1522976-2-neal_liu@aspeedtech.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-2-neal_liu@aspeedtech.com>
Message-ID: <YpcYLiJfC6tgP2Nj@Red>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le Wed, Jun 01, 2022 at 01:42:00PM +0800, Neal Liu a ?crit :
> Hash and Crypto Engine (HACE) is designed to accelerate the
> throughput of hash data digest, encryption, and decryption.
> 
> Basically, HACE can be divided into two independently engines
> - Hash Engine and Crypto Engine. This patch aims to add HACE
> hash engine driver for hash accelerator.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>

Hello

Did you test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y (you should said it in cover letter).
There are several easy style fixes to do (please run checkpatch --strict)
Did you test your driver with both little and big endian mode ?

Also please see my comment below.

[...]
> +/* Initialization Vectors for SHA-family */
> +static const u32 sha1_iv[8] = {
> +	0x01234567UL, 0x89abcdefUL, 0xfedcba98UL, 0x76543210UL,
> +	0xf0e1d2c3UL, 0, 0, 0
> +};
> +
> +static const u32 sha224_iv[8] = {
> +	0xd89e05c1UL, 0x07d57c36UL, 0x17dd7030UL, 0x39590ef7UL,
> +	0x310bc0ffUL, 0x11155868UL, 0xa78ff964UL, 0xa44ffabeUL
> +};
> +
> +static const u32 sha256_iv[8] = {
> +	0x67e6096aUL, 0x85ae67bbUL, 0x72f36e3cUL, 0x3af54fa5UL,
> +	0x7f520e51UL, 0x8c68059bUL, 0xabd9831fUL, 0x19cde05bUL
> +};
> +
> +static const u32 sha384_iv[16] = {
> +	0x5d9dbbcbUL, 0xd89e05c1UL, 0x2a299a62UL, 0x07d57c36UL,
> +	0x5a015991UL, 0x17dd7030UL, 0xd8ec2f15UL, 0x39590ef7UL,
> +	0x67263367UL, 0x310bc0ffUL, 0x874ab48eUL, 0x11155868UL,
> +	0x0d2e0cdbUL, 0xa78ff964UL, 0x1d48b547UL, 0xa44ffabeUL
> +};
> +
> +static const u32 sha512_iv[16] = {
> +	0x67e6096aUL, 0x08c9bcf3UL, 0x85ae67bbUL, 0x3ba7ca84UL,
> +	0x72f36e3cUL, 0x2bf894feUL, 0x3af54fa5UL, 0xf1361d5fUL,
> +	0x7f520e51UL, 0xd182e6adUL, 0x8c68059bUL, 0x1f6c3e2bUL,
> +	0xabd9831fUL, 0x6bbd41fbUL, 0x19cde05bUL, 0x79217e13UL
> +};
> +
> +static const u32 sha512_224_iv[16] = {
> +	0xC8373D8CUL, 0xA24D5419UL, 0x6699E173UL, 0xD6D4DC89UL,
> +	0xAEB7FA1DUL, 0x829CFF32UL, 0x14D59D67UL, 0xCF9F2F58UL,
> +	0x692B6D0FUL, 0xA84DD47BUL, 0x736FE377UL, 0x4289C404UL,
> +	0xA8859D3FUL, 0xC8361D6AUL, 0xADE61211UL, 0xA192D691UL
> +};
> +
> +static const u32 sha512_256_iv[16] = {
> +	0x94213122UL, 0x2CF72BFCUL, 0xA35F559FUL, 0xC2644CC8UL,
> +	0x6BB89323UL, 0x51B1536FUL, 0x19773896UL, 0xBDEA4059UL,
> +	0xE23E2896UL, 0xE3FF8EA8UL, 0x251E5EBEUL, 0x92398653UL,
> +	0xFC99012BUL, 0xAAB8852CUL, 0xDC2DB70EUL, 0xA22CC581UL
> +};

Thoses IV already exists as define in linux headers (SHA1_H0 for example)
But I am puzzled on why you invert them.

> +
> +static void aspeed_ahash_iV(struct aspeed_sham_reqctx *rctx)
> +{
> +	if (rctx->flags & SHA_FLAGS_SHA1)
> +		memcpy(rctx->digest, sha1_iv, 32);
> +	else if (rctx->flags & SHA_FLAGS_SHA224)
> +		memcpy(rctx->digest, sha224_iv, 32);
> +	else if (rctx->flags & SHA_FLAGS_SHA256)
> +		memcpy(rctx->digest, sha256_iv, 32);
> +	else if (rctx->flags & SHA_FLAGS_SHA384)
> +		memcpy(rctx->digest, sha384_iv, 64);
> +	else if (rctx->flags & SHA_FLAGS_SHA512)
> +		memcpy(rctx->digest, sha512_iv, 64);
> +	else if (rctx->flags & SHA_FLAGS_SHA512_224)
> +		memcpy(rctx->digest, sha512_224_iv, 64);
> +	else if (rctx->flags & SHA_FLAGS_SHA512_256)
> +		memcpy(rctx->digest, sha512_256_iv, 64);
> +}
> +
> +/* The purpose of this padding is to ensure that the padded message is a
> + * multiple of 512 bits (SHA1/SHA224/SHA256) or 1024 bits (SHA384/SHA512).
> + * The bit "1" is appended at the end of the message followed by
> + * "padlen-1" zero bits. Then a 64 bits block (SHA1/SHA224/SHA256) or
> + * 128 bits block (SHA384/SHA512) equals to the message length in bits
> + * is appended.
> + *
> + * For SHA1/SHA224/SHA256, padlen is calculated as followed:
> + *  - if message length < 56 bytes then padlen = 56 - message length
> + *  - else padlen = 64 + 56 - message length
> + *
> + * For SHA384/SHA512, padlen is calculated as followed:
> + *  - if message length < 112 bytes then padlen = 112 - message length
> + *  - else padlen = 128 + 112 - message length
> + */
> +static void aspeed_ahash_fill_padding(struct aspeed_hace_dev *hace_dev,
> +				      struct aspeed_sham_reqctx *rctx)
> +{
> +	unsigned int index, padlen;
> +	u64 bits[2];
> +
> +	AHASH_DBG(hace_dev, "rctx flags:0x%x\n", rctx->flags);
> +
> +	switch (rctx->flags & SHA_FLAGS_MASK) {
> +	case SHA_FLAGS_SHA1:
> +	case SHA_FLAGS_SHA224:
> +	case SHA_FLAGS_SHA256:
> +		bits[0] = cpu_to_be64(rctx->digcnt[0] << 3);
> +		index = rctx->bufcnt & 0x3f;
> +		padlen = (index < 56) ? (56 - index) : ((64 + 56) - index);
> +		*(rctx->buffer + rctx->bufcnt) = 0x80;
> +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
> +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 8);
> +		rctx->bufcnt += padlen + 8;
> +		break;
> +	default:
> +		bits[1] = cpu_to_be64(rctx->digcnt[0] << 3);
> +		bits[0] = cpu_to_be64(rctx->digcnt[1] << 3 |
> +				      rctx->digcnt[0] >> 61);
> +		index = rctx->bufcnt & 0x7f;
> +		padlen = (index < 112) ? (112 - index) : ((128 + 112) - index);
> +		*(rctx->buffer + rctx->bufcnt) = 0x80;
> +		memset(rctx->buffer + rctx->bufcnt + 1, 0, padlen - 1);
> +		memcpy(rctx->buffer + rctx->bufcnt + padlen, bits, 16);
> +		rctx->bufcnt += padlen + 16;
> +		break;
> +	}
> +}

bits should be __be64

> +
> +/*
> + * Prepare DMA buffer before hardware engine
> + * processing.
> + */
> +static int aspeed_ahash_dma_prepare(struct aspeed_hace_dev *hace_dev)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->ahash_req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +	struct device *dev = hace_dev->dev;
> +	int length, remain;
> +
> +	length = rctx->total + rctx->bufcnt;
> +	remain = length % rctx->block_size;
> +
> +	AHASH_DBG(hace_dev, "length:0x%x, remain:0x%x\n", length, remain);
> +
> +	if (rctx->bufcnt)
> +		memcpy(hash_engine->ahash_src_addr, rctx->buffer, rctx->bufcnt);
> +
> +	if (rctx->total + rctx->bufcnt < ASPEED_CRYPTO_SRC_DMA_BUF_LEN) {
> +		scatterwalk_map_and_copy(hash_engine->ahash_src_addr +
> +					 rctx->bufcnt, rctx->src_sg,
> +					 rctx->offset, rctx->total - remain, 0);
> +		rctx->offset += rctx->total - remain;
> +
> +	} else {
> +		dev_warn(dev, "Hash data length is too large\n");

What user could do with such message ?
This seems like an unhandled error.

> +	}
> +
> +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg,
> +				 rctx->offset, remain, 0);
> +
> +	rctx->bufcnt = remain;
> +	rctx->digest_dma_addr = dma_map_single(hace_dev->dev, rctx->digest,
> +					       SHA512_DIGEST_SIZE,
> +					       DMA_BIDIRECTIONAL);
> +

All your dma_map_xx() are not checked for errors.
You should test your driver with CONFIG_DMA_API_DEBUG=y

[...]
> +		src_list[0].phy_addr = rctx->buffer_dma_addr;
> +		src_list[0].len = rctx->bufcnt;
> +		length -= src_list[0].len;
> +
> +		/* Last sg list */
> +		if (length == 0)
> +			src_list[0].len |= BIT(31);

The BIT(31) is used on lot of place, so you can use a define.

[...]
> +static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
> +				     aspeed_hace_fn_t resume)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct ahash_request *req = hash_engine->ahash_req;
> +	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> +
> +	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
> +		  hash_engine->src_dma, hash_engine->digest_dma,
> +		  hash_engine->src_length);
> +
> +	rctx->cmd |= HASH_CMD_INT_ENABLE;
> +	hash_engine->resume = resume;
> +
> +	ast_hace_write(hace_dev, hash_engine->src_dma, ASPEED_HACE_HASH_SRC);
> +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> +		       ASPEED_HACE_HASH_DIGEST_BUFF);
> +	ast_hace_write(hace_dev, hash_engine->digest_dma,
> +		       ASPEED_HACE_HASH_KEY_BUFF);
> +	ast_hace_write(hace_dev, hash_engine->src_length,
> +		       ASPEED_HACE_HASH_DATA_LEN);
> +
> +	/* Dummy read for barriers */
> +	readl(hash_engine->ahash_src_addr);

Probably a real barrier function will be better.

[...]
> +	dma_unmap_single(hace_dev->dev, rctx->digest_dma_addr,
> +			 SHA512_DIGEST_SIZE, DMA_BIDIRECTIONAL);
> +
> +	scatterwalk_map_and_copy(rctx->buffer, rctx->src_sg, rctx->offset,
> +				 rctx->total - rctx->offset, 0);
> +
> +	rctx->bufcnt = rctx->total - rctx->offset;
> +	rctx->cmd &= ~HASH_CMD_HASH_SRC_SG_CTRL;
> +
> +	// no need to call final()?
> +	if (rctx->flags & SHA_FLAGS_FINUP)
> +		return aspeed_ahash_req_final(hace_dev);

This seems like a forgotten todo.

[...]
> +int aspeed_hace_hash_handle_queue(struct aspeed_hace_dev *hace_dev,
> +				  struct crypto_async_request *new_areq)
> +{
> +	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
> +	struct crypto_async_request *areq, *backlog;
> +	struct aspeed_sham_reqctx *rctx;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&hash_engine->lock, flags);
> +
> +	if (new_areq)
> +		ret = crypto_enqueue_request(&hash_engine->queue, new_areq);

Why didnt you use the crypto_engine API instead of rewriting it.

Regards
