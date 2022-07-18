From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 18 Jul 2022 09:14:28 +0000
Subject: [PATCH v7 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <HK0PR06MB32027F003F07000E9F97A166808C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
 <20220705020936.1751771-2-neal_liu@aspeedtech.com>
 <45058512-0661-5d34-7faf-ddf3eb6142ec@linux.microsoft.com>
 <HK0PR06MB32027F003F07000E9F97A166808C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <HK0PR06MB32024393BC4D8B2D677056D0808C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > -----Original Message-----
> > From: Dhananjay Phadke <dphadke@linux.microsoft.com>
> > Sent: Wednesday, July 13, 2022 1:32 PM
> > To: Neal Liu <neal_liu@aspeedtech.com>; Corentin Labbe
> > <clabbe.montjoie@gmail.com>; Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr>; Randy Dunlap <rdunlap@infradead.org>;
> > Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> > <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley
> > <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
> > <dhphadke@microsoft.com>; Johnny Huang
> <johnny_huang@aspeedtech.com>
> > Cc: linux-aspeed at lists.ozlabs.org; linux-crypto at vger.kernel.org;
> > devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > linux-kernel at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> > Subject: Re: [PATCH v7 1/5] crypto: aspeed: Add HACE hash driver
> >
> [...]
> 
> > > +static int aspeed_sham_cra_init_alg(struct crypto_tfm *tfm,
> > > +				    const char *alg_base)
> > > +{
> > > +	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
> > > +	struct aspeed_sham_ctx *tctx = crypto_tfm_ctx(tfm);
> > > +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> > > +	struct aspeed_hace_alg *ast_alg;
> > > +
> > > +	ast_alg = container_of(alg, struct aspeed_hace_alg, alg.ahash);
> > > +	tctx->hace_dev = ast_alg->hace_dev;
> > > +	tctx->flags = 0;
> > > +
> > > +	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
> > > +				 sizeof(struct aspeed_sham_reqctx));
> > > +
> > > +	if (alg_base) {
> > > +		struct aspeed_sha_hmac_ctx *bctx = tctx->base;
> > > +
> > > +		tctx->flags |= SHA_FLAGS_HMAC;
> > > +		bctx->shash = crypto_alloc_shash(alg_base, 0,
> > > +						 CRYPTO_ALG_NEED_FALLBACK);
> > > +		if (IS_ERR(bctx->shash)) {
> > > +			dev_warn(hace_dev->dev,
> > > +				 "base driver '%s' could not be loaded.\n",
> > > +				 alg_base);
> > > +			return PTR_ERR(bctx->shash);
> > > +		}
> > > +	}
> > > +
> > > +	tctx->enginectx.op.do_one_request = aspeed_ahash_do_request;
> > > +	tctx->enginectx.op.prepare_request =
> aspeed_ahash_prepare_request;
> > > +	tctx->enginectx.op.unprepare_request = NULL;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int aspeed_sham_cra_init(struct crypto_tfm *tfm) {
> > > +	return aspeed_sham_cra_init_alg(tfm, NULL); }
> > > +
> > > +static int aspeed_sham_cra_sha1_init(struct crypto_tfm *tfm) {
> > > +	return aspeed_sham_cra_init_alg(tfm, "sha1"); }
> > > +
> > > +static int aspeed_sham_cra_sha224_init(struct crypto_tfm *tfm) {
> > > +	return aspeed_sham_cra_init_alg(tfm, "sha224"); }
> > > +
> > > +static int aspeed_sham_cra_sha256_init(struct crypto_tfm *tfm) {
> > > +	return aspeed_sham_cra_init_alg(tfm, "sha256"); }
> > > +
> > > +static int aspeed_sham_cra_sha384_init(struct crypto_tfm *tfm) {
> > > +	return aspeed_sham_cra_init_alg(tfm, "sha384"); }
> > > +
> > > +static int aspeed_sham_cra_sha512_init(struct crypto_tfm *tfm) {
> > > +	return aspeed_sham_cra_init_alg(tfm, "sha512"); }
> > > +
> > > +static int aspeed_sham_cra_sha512_224_init(struct crypto_tfm *tfm)
> > > +{
> > > +	return aspeed_sham_cra_init_alg(tfm, "sha512_224"); }
> > > +
> > > +static int aspeed_sham_cra_sha512_256_init(struct crypto_tfm *tfm)
> > > +{
> > > +	return aspeed_sham_cra_init_alg(tfm, "sha512_256"); }
> >
> > Looks like most of these cra_init callback functions are trying to
> > distinguish hmac from sha algs by passing "alg_base" arg. Can collapse
> > the logic in aspeed_sham_cra_init_alg() itself and storing alg_base in
> > instances of aspeed_hace_alg.
> >
> > 	if (ast_alg->ahash.setkey()) {
> > 		/* hmac related logic */
> > 		bctx->shash = crypto_alloc_shash(ast_alg->alg_base, 0,
> > 			CRYPTO_ALG_NEED_FALLBACK);
> > 		...
> 
> Thanks for your suggestion! It will simplify these cra_init() functions.
> I'll revise it for next patch.

Sorry, I was misunderstanding. The reason by passing "alg_base" is because HMAC key is defined as the following statement.
-> K' is a block-sized key derived from the secret key, K; either by padding to the right with 0s up to the block size, or by hashing down to less than or equal to the block size first and then padding to the right with zeros

So basically, allocate a generic shash algo to do hash one time if input key size is larger than the block size.
Here we prefer to use the generic name instead of Aspeed registered algo since input key size is usually small.
Thanks

-Neal
