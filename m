From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 6 Oct 2022 03:43:30 +0000
Subject: [PATCH v1 1/4] crypto: aspeed: Add ACRY RSA driver
In-Reply-To: <1fe9163d-69b5-6520-76d6-05ed0d4a100f@intel.com>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
 <20220902060012.3758637-2-neal_liu@aspeedtech.com>
 <1fe9163d-69b5-6520-76d6-05ed0d4a100f@intel.com>
Message-ID: <HK0PR06MB3202EA1D597ADC8002DC1B2C805C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > ACRY Engine is designed to accelerate the throughput of ECDSA/RSA
> > signature and verification.
> >
> > This patch aims to add ACRY RSA engine driver for hardware
> > acceleration.
> 
> > +static bool aspeed_acry_need_fallback(struct akcipher_request *req) {
> > +	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
> > +	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
> > +
> > +	if (ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN)
> > +		return true;
> > +
> > +	return false;
> 
> return ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN;

Thanks for the review.
I'll revise it as you suggested.

> 
> > +}
> > +
> > +static int aspeed_acry_handle_queue(struct aspeed_acry_dev *acry_dev,
> > +				    struct akcipher_request *req) {
> > +	if (aspeed_acry_need_fallback(req)) {
> > +		ACRY_DBG(acry_dev, "SW fallback\n");
> > +		return aspeed_acry_do_fallback(req);
> > +	}
> > +
> > +	return crypto_transfer_akcipher_request_to_engine(
> > +			acry_dev->crypt_engine_rsa, req);
> > +}
> > +
> > +static int aspeed_acry_do_request(struct crypto_engine *engine, void
> > +*areq) {
> > +	struct akcipher_request *req = akcipher_request_cast(areq);
> > +	struct crypto_akcipher *cipher = crypto_akcipher_reqtfm(req);
> > +	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(cipher);
> > +	struct aspeed_acry_dev *acry_dev = ctx->acry_dev;
> > +	int rc;
> > +
> > +	acry_dev->req = req;
> > +	acry_dev->flags |= CRYPTO_FLAGS_BUSY;
> > +	rc = ctx->trigger(acry_dev);
> > +
> > +	if (rc != -EINPROGRESS)
> > +		return -EIO;
> 
> So -EINPROGRESS return is converted to a 0 return, and all other error returns
> are converted to -EIO.
> 
> Why not have ctx->trigger() return 0 instead of -EINPROGRESS? Then the code
> here can just be:
> 
> return ctx->trigger(acry_dev);

Yes, why not. I'll revise it as you suggested.

> 
> > +
> > +	return 0;
> > +}
> > +
> 
> 
> > +
> > +static u8 *aspeed_rsa_key_copy(u8 *src, size_t len) {
> > +	u8 *dst;
> > +
> > +	dst = kmemdup(src, len, GFP_DMA | GFP_KERNEL);
> > +	return dst;
> 
> return kmemdup(src, len, GFP_DMA | GFP_KERNEL);

Same here.

> 
> > +}
> > +
> > +static int aspeed_rsa_set_n(struct aspeed_acry_ctx *ctx, u8 *value,
> > +			    size_t len)
> > +{
> > +	ctx->n_sz = len;
> > +	ctx->n = aspeed_rsa_key_copy(value, len);
> > +	if (!ctx->n)
> > +		return -EINVAL;
> 
> aspeed_rsa_key_copy() calls kmemdup(). Feel like -ENOMEM would be a
> better code to return here.

Same here.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int aspeed_rsa_set_e(struct aspeed_acry_ctx *ctx, u8 *value,
> > +			    size_t len)
> > +{
> > +	ctx->e_sz = len;
> > +	ctx->e = aspeed_rsa_key_copy(value, len);
> > +	if (!ctx->e)
> > +		return -EINVAL;
> 
> Here as well.

Same here.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int aspeed_rsa_set_d(struct aspeed_acry_ctx *ctx, u8 *value,
> > +			    size_t len)
> > +{
> > +	ctx->d_sz = len;
> > +	ctx->d = aspeed_rsa_key_copy(value, len);
> > +	if (!ctx->d)
> > +		return -EINVAL;
> .. and here.

Same here.

> 
> > +
> > +	return 0;
> > +}
> 
> 
> > +
> > +static int aspeed_acry_rsa_setkey(struct crypto_akcipher *tfm, const void
> *key,
> > +				  unsigned int keylen, int priv)
> > +{
> > +	struct aspeed_acry_ctx *ctx = akcipher_tfm_ctx(tfm);
> > +	struct aspeed_acry_dev *acry_dev = ctx->acry_dev;
> > +	int ret;
> > +
> > +	if (priv)
> > +		ret = rsa_parse_priv_key(&ctx->key, key, keylen);
> > +	else
> > +		ret = rsa_parse_pub_key(&ctx->key, key, keylen);
> > +
> > +	if (ret) {
> > +		dev_err(acry_dev->dev, "rsa parse key failed, ret:0x%x\n",
> > +			ret);
> > +		return ret;
> 
> Do you not have to free ctx in this case?

I don't think it needs.

> 
> > +	}
> > +
> > +	/* Aspeed engine supports up to 4096 bits,
> > +	 * Use software fallback instead.
> > +	 */
> > +	if (ctx->key.n_sz > ASPEED_ACRY_RSA_MAX_KEY_LEN)
> > +		return 0;
> > +
> > +	ret = aspeed_rsa_set_n(ctx, (u8 *)ctx->key.n, ctx->key.n_sz);
> > +	if (ret)
> > +		goto err;
> > +
> > +	ret = aspeed_rsa_set_e(ctx, (u8 *)ctx->key.e, ctx->key.e_sz);
> > +	if (ret)
> > +		goto err;
> > +
> > +	if (priv) {
> > +		ret = aspeed_rsa_set_d(ctx, (u8 *)ctx->key.d, ctx->key.d_sz);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +
> > +	return 0;
> > +
> > +err:
> > +	dev_err(acry_dev->dev, "rsa set key failed\n");
> > +	aspeed_rsa_key_free(ctx);
> > +
> > +	return ret;
> > +}
> 
> 
> > +
> > +/*
> > + * ACRY SRAM has its own memory layout.
> > + * Set the DRAM to SRAM indexing for future used.
> > + */
> > +static void aspeed_acry_sram_mapping(struct aspeed_acry_dev
> > +*acry_dev) {
> > +	int i, j = 0;
> > +
> > +	for (i = 0; i < (ASPEED_ACRY_SRAM_MAX_LEN / BYTES_PER_DWORD);
> i++) {
> > +		acry_dev->exp_dw_mapping[i] = j;
> > +		acry_dev->mod_dw_mapping[i] = j + 4;
> > +		acry_dev->data_byte_mapping[(i * 4)] = (j + 8) * 4;
> > +		acry_dev->data_byte_mapping[(i * 4) + 1] = (j + 8) * 4 + 1;
> > +		acry_dev->data_byte_mapping[(i * 4) + 2] = (j + 8) * 4 + 2;
> > +		acry_dev->data_byte_mapping[(i * 4) + 3] = (j + 8) * 4 + 3;
> > +		j++;
> > +		j = j % 4 ? j : j + 8;
> > +	}
> 
> Would help if you explained in some level of detail what you're doing here.

This is the index mapping of ACRY SRAM layout. And the exp/mod/data buffer location is mixed with some kinds of rule in ACRY SRAM.
The driver should deploy the same layout in DRAM before starting engine, so the engine can directly copy the DRAM data to its SRAM.
Here is the example of the SRAM mapping:
[exp 4 DW, mod 4 DW, data 4 DW,
exp 4 DW, mod 4 DW, data 4 DW, ...]

> 
> > +static int aspeed_acry_probe(struct platform_device *pdev) {
> > +	struct aspeed_acry_dev *acry_dev;
> > +	struct device *dev = &pdev->dev;
> > +	struct resource *res;
> > +	int rc;
> > +
> > +	acry_dev = devm_kzalloc(dev, sizeof(struct aspeed_acry_dev),
> > +				GFP_KERNEL);
> > +	if (!acry_dev)
> > +		return -ENOMEM;
> > +
> > +	acry_dev->dev = dev;
> > +
> > +	platform_set_drvdata(pdev, acry_dev);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	acry_dev->regs = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(acry_dev->regs))
> > +		return PTR_ERR(acry_dev->regs);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	acry_dev->acry_sram = devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(acry_dev->acry_sram))
> > +		return PTR_ERR(acry_dev->acry_sram);
> > +
> > +	/* Get irq number and register it */
> > +	acry_dev->irq = platform_get_irq(pdev, 0);
> > +	if (!acry_dev->irq) {
> > +		dev_err(dev, "Failed to get interrupt\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	rc = devm_request_irq(dev, acry_dev->irq, aspeed_acry_irq, 0,
> > +			      dev_name(dev), acry_dev);
> > +	if (rc) {
> > +		dev_err(dev, "Failed to request irq.\n");
> > +		return rc;
> > +	}
> > +
> > +	acry_dev->clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(acry_dev->clk)) {
> > +		dev_err(dev, "Failed to get clk\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	acry_dev->ahbc = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +							 "aspeed,ahbc");
> > +	if (IS_ERR(acry_dev->ahbc)) {
> > +		dev_err(dev, "Failed to get AHBC regmap\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	rc = clk_prepare_enable(acry_dev->clk);
> > +	if (rc) {
> > +		dev_err(dev, "Failed to enable clock 0x%x\n", rc);
> > +		return rc;
> > +	}
> 
> See if you can use devm_clk_get_enabled()? It combines devm_clk_get() and
> clk_prepare_enable().

Okay, I'll try it.

> 
> > +
> > +	/* Initialize crypto hardware engine structure for RSA */
> > +	acry_dev->crypt_engine_rsa = crypto_engine_alloc_init(dev, true);
> > +	if (!acry_dev->crypt_engine_rsa) {
> > +		rc = -ENOMEM;
> > +		goto clk_exit;
> > +	}
> > +
> > +	rc = crypto_engine_start(acry_dev->crypt_engine_rsa);
> > +	if (rc)
> > +		goto err_engine_rsa_start;
> > +
> > +	tasklet_init(&acry_dev->done_task, aspeed_acry_done_task,
> > +		     (unsigned long)acry_dev);
> > +
> > +	/* Set Data Memory to AHB(CPU) Access Mode */
> > +	ast_acry_write(acry_dev, ACRY_CMD_DMEM_AHB,
> ASPEED_ACRY_DMA_CMD);
> > +
> > +	/* Initialize ACRY SRAM index */
> > +	aspeed_acry_sram_mapping(acry_dev);
> > +
> > +	acry_dev->buf_addr = dmam_alloc_coherent(dev,
> ASPEED_ACRY_BUFF_SIZE,
> > +						 &acry_dev->buf_dma_addr,
> > +						 GFP_KERNEL);
> > +	memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);
> > +
> > +	aspeed_acry_register(acry_dev);
> > +
> > +	dev_info(dev, "Aspeed ACRY Accelerator successfully registered\n");
> > +
> > +	return 0;
> > +
> > +err_engine_rsa_start:
> > +	crypto_engine_exit(acry_dev->crypt_engine_rsa);
> > +clk_exit:
> > +	clk_disable_unprepare(acry_dev->clk);
> > +
> > +	return rc;
> > +}
> 
> Ani
