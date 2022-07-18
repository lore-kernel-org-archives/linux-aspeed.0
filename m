From: Neal Liu <neal_liu@aspeedtech.com>
Date: Mon, 18 Jul 2022 06:05:45 +0000
Subject: [PATCH v7 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <45058512-0661-5d34-7faf-ddf3eb6142ec@linux.microsoft.com>
References: <20220705020936.1751771-1-neal_liu@aspeedtech.com>
 <20220705020936.1751771-2-neal_liu@aspeedtech.com>
 <45058512-0661-5d34-7faf-ddf3eb6142ec@linux.microsoft.com>
Message-ID: <HK0PR06MB32027F003F07000E9F97A166808C9@HK0PR06MB3202.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Dhananjay Phadke <dphadke@linux.microsoft.com>
> Sent: Wednesday, July 13, 2022 1:32 PM
> To: Neal Liu <neal_liu@aspeedtech.com>; Corentin Labbe
> <clabbe.montjoie@gmail.com>; Christophe JAILLET
> <christophe.jaillet@wanadoo.fr>; Randy Dunlap <rdunlap@infradead.org>;
> Herbert Xu <herbert@gondor.apana.org.au>; David S . Miller
> <davem@davemloft.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
> Andrew Jeffery <andrew@aj.id.au>; Dhananjay Phadke
> <dhphadke@microsoft.com>; Johnny Huang
> <johnny_huang@aspeedtech.com>
> Cc: linux-aspeed at lists.ozlabs.org; linux-crypto at vger.kernel.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [PATCH v7 1/5] crypto: aspeed: Add HACE hash driver
> 
> Minor comments inline.
> 
> On 7/4/2022 7:09 PM, Neal Liu wrote:
> > Hash and Crypto Engine (HACE) is designed to accelerate the
> > throughput of hash data digest, encryption, and decryption.
> >
> > Basically, HACE can be divided into two independently engines
> > - Hash Engine and Crypto Engine. This patch aims to add HACE
> > hash engine driver for hash accelerator.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > ---
> >   MAINTAINERS                              |    7 +
> >   drivers/crypto/Kconfig                   |    1 +
> >   drivers/crypto/Makefile                  |    1 +
> >   drivers/crypto/aspeed/Kconfig            |   23 +
> >   drivers/crypto/aspeed/Makefile           |    6 +
> >   drivers/crypto/aspeed/aspeed-hace-hash.c | 1428
> ++++++++++++++++++++++
> >   drivers/crypto/aspeed/aspeed-hace.c      |  213 ++++
> >   drivers/crypto/aspeed/aspeed-hace.h      |  181 +++
> >   8 files changed, 1860 insertions(+)
> >   create mode 100644 drivers/crypto/aspeed/Kconfig
> >   create mode 100644 drivers/crypto/aspeed/Makefile
> >   create mode 100644 drivers/crypto/aspeed/aspeed-hace-hash.c
> >   create mode 100644 drivers/crypto/aspeed/aspeed-hace.c
> >   create mode 100644 drivers/crypto/aspeed/aspeed-hace.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3cf9842d9233..63276700ee26 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3136,6 +3136,13 @@ S:	Maintained
> >   F:	Documentation/devicetree/bindings/media/aspeed-video.txt
> >   F:	drivers/media/platform/aspeed/
> >
> > +ASPEED CRYPTO DRIVER
> > +M:	Neal Liu <neal_liu@aspeedtech.com>
> > +L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
> > +S:	Maintained
> > +F:
> 	Documentation/devicetree/bindings/crypto/aspeed,ast2500-hace.yaml
> > +F:	drivers/crypto/aspeed/
> > +
> >   ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> >   M:	Corentin Chary <corentin.chary@gmail.com>
> >   L:	acpi4asus-user at lists.sourceforge.net
> > diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> > index ee99c02c84e8..b9f5ee126881 100644
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -933,5 +933,6 @@ config CRYPTO_DEV_SA2UL
> >   	  acceleration for cryptographic algorithms on these devices.
> >
> >   source "drivers/crypto/keembay/Kconfig"
> > +source "drivers/crypto/aspeed/Kconfig"
> >
> >   endif # CRYPTO_HW
> > diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
> > index f81703a86b98..116de173a66c 100644
> > --- a/drivers/crypto/Makefile
> > +++ b/drivers/crypto/Makefile
> > @@ -1,5 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   obj-$(CONFIG_CRYPTO_DEV_ALLWINNER) += allwinner/
> > +obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed/
> >   obj-$(CONFIG_CRYPTO_DEV_ATMEL_AES) += atmel-aes.o
> >   obj-$(CONFIG_CRYPTO_DEV_ATMEL_SHA) += atmel-sha.o
> >   obj-$(CONFIG_CRYPTO_DEV_ATMEL_TDES) += atmel-tdes.o
> > diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
> > new file mode 100644
> > index 000000000000..7c741695e9b1
> > --- /dev/null
> > +++ b/drivers/crypto/aspeed/Kconfig
> > @@ -0,0 +1,23 @@
> > +config CRYPTO_DEV_ASPEED
> > +	tristate "Support for Aspeed cryptographic engine driver"
> > +	depends on ARCH_ASPEED
> > +	help
> > +	  Hash and Crypto Engine (HACE) is designed to accelerate the
> > +	  throughput of hash data digest, encryption and decryption.
> > +
> > +	  Select y here to have support for the cryptographic driver
> > +	  available on Aspeed SoC.
> > +
> > +config CRYPTO_DEV_ASPEED_HACE_HASH
> > +	bool "Enable Aspeed Hash & Crypto Engine (HACE) hash"
> > +	depends on CRYPTO_DEV_ASPEED
> > +	select CRYPTO_ENGINE
> > +	select CRYPTO_SHA1
> > +	select CRYPTO_SHA256
> > +	select CRYPTO_SHA512
> > +	select CRYPTO_HMAC
> > +	help
> > +	  Select here to enable Aspeed Hash & Crypto Engine (HACE)
> > +	  hash driver.
> > +	  Supports multiple message digest standards, including
> > +	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
> > diff --git a/drivers/crypto/aspeed/Makefile
> b/drivers/crypto/aspeed/Makefile
> > new file mode 100644
> > index 000000000000..8bc8d4fed5a9
> > --- /dev/null
> > +++ b/drivers/crypto/aspeed/Makefile
> > @@ -0,0 +1,6 @@
> > +obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
> > +aspeed_crypto-objs := aspeed-hace.o \
> > +		      $(hace-hash-y)
> > +
> > +obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
> > +hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) :=
> aspeed-hace-hash.o
> > diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c
> b/drivers/crypto/aspeed/aspeed-hace-hash.c
> > new file mode 100644
> > index 000000000000..32631cf03244
> > --- /dev/null
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
> > +	dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> > +#else
> > +#define AHASH_DBG(h, fmt, ...)	\
> > +	dev_dbg((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
> > +#endif
> 
> Can this be defined in Kconfig (CONFIG_ASPEED_AHASH_DEBUG) like some
> other drivers?

Sure, I'll revise it in next patch.

> > +
> > +/* Initialization Vectors for SHA-family */
> > +static const u32 sha1_iv[8] = {
> > +	cpu_to_be32(SHA1_H0), cpu_to_be32(SHA1_H1),
> > +	cpu_to_be32(SHA1_H2), cpu_to_be32(SHA1_H3),
> > +	cpu_to_be32(SHA1_H4), 0, 0, 0
> > +};
> > +
> > +static const u32 sha224_iv[8] = {
> > +	cpu_to_be32(SHA224_H0), cpu_to_be32(SHA224_H1),
> > +	cpu_to_be32(SHA224_H2), cpu_to_be32(SHA224_H3),
> > +	cpu_to_be32(SHA224_H4), cpu_to_be32(SHA224_H5),
> > +	cpu_to_be32(SHA224_H6), cpu_to_be32(SHA224_H7),
> > +};
> > +
> > +static const u32 sha256_iv[8] = {
> > +	cpu_to_be32(SHA256_H0), cpu_to_be32(SHA256_H1),
> > +	cpu_to_be32(SHA256_H2), cpu_to_be32(SHA256_H3),
> > +	cpu_to_be32(SHA256_H4), cpu_to_be32(SHA256_H5),
> > +	cpu_to_be32(SHA256_H6), cpu_to_be32(SHA256_H7),
> > +};
> 
> static const __be32 since using cpu_to_be32()?

Okay, I'll revise it in next patch.

> > +
> > +static const u64 sha384_iv[8] = {
> > +	cpu_to_be64(SHA384_H0), cpu_to_be64(SHA384_H1),
> > +	cpu_to_be64(SHA384_H2), cpu_to_be64(SHA384_H3),
> > +	cpu_to_be64(SHA384_H4), cpu_to_be64(SHA384_H5),
> > +	cpu_to_be64(SHA384_H6), cpu_to_be64(SHA384_H7)
> > +};
> > +
> > +static const u64 sha512_iv[8] = {
> > +	cpu_to_be64(SHA512_H0), cpu_to_be64(SHA512_H1),
> > +	cpu_to_be64(SHA512_H2), cpu_to_be64(SHA512_H3),
> > +	cpu_to_be64(SHA512_H4), cpu_to_be64(SHA512_H5),
> > +	cpu_to_be64(SHA512_H6), cpu_to_be64(SHA512_H7)
> > +};
> 
> same as above, static const __be64 since using cpu_to_be64()?

Same.

> > +
> > +static const u32 sha512_224_iv[16] = {
> > +	cpu_to_be32(0xC8373D8CUL), cpu_to_be32(0xA24D5419UL),
> > +	cpu_to_be32(0x6699E173UL), cpu_to_be32(0xD6D4DC89UL),
> > +	cpu_to_be32(0xAEB7FA1DUL), cpu_to_be32(0x829CFF32UL),
> > +	cpu_to_be32(0x14D59D67UL), cpu_to_be32(0xCF9F2F58UL),
> > +	cpu_to_be32(0x692B6D0FUL), cpu_to_be32(0xA84DD47BUL),
> > +	cpu_to_be32(0x736FE377UL), cpu_to_be32(0x4289C404UL),
> > +	cpu_to_be32(0xA8859D3FUL), cpu_to_be32(0xC8361D6AUL),
> > +	cpu_to_be32(0xADE61211UL), cpu_to_be32(0xA192D691UL)
> > +};
> > +
> > +static const u32 sha512_256_iv[16] = {
> > +	cpu_to_be32(0x94213122UL), cpu_to_be32(0x2CF72BFCUL),
> > +	cpu_to_be32(0xA35F559FUL), cpu_to_be32(0xC2644CC8UL),
> > +	cpu_to_be32(0x6BB89323UL), cpu_to_be32(0x51B1536FUL),
> > +	cpu_to_be32(0x19773896UL), cpu_to_be32(0xBDEA4059UL),
> > +	cpu_to_be32(0xE23E2896UL), cpu_to_be32(0xE3FF8EA8UL),
> > +	cpu_to_be32(0x251E5EBEUL), cpu_to_be32(0x92398653UL),
> > +	cpu_to_be32(0xFC99012BUL), cpu_to_be32(0xAAB8852CUL),
> > +	cpu_to_be32(0xDC2DB70EUL), cpu_to_be32(0xA22CC581UL)
> > +};
> > +
> > +static void aspeed_ahash_iV(struct aspeed_sham_reqctx *rctx)
> > +{
> > +	if (rctx->flags & SHA_FLAGS_SHA1)
> > +		memcpy(rctx->digest, sha1_iv, 32);
> > +	else if (rctx->flags & SHA_FLAGS_SHA224)
> > +		memcpy(rctx->digest, sha224_iv, 32);
> > +	else if (rctx->flags & SHA_FLAGS_SHA256)
> > +		memcpy(rctx->digest, sha256_iv, 32);
> > +	else if (rctx->flags & SHA_FLAGS_SHA384)
> > +		memcpy(rctx->digest, sha384_iv, 64);
> > +	else if (rctx->flags & SHA_FLAGS_SHA512)
> > +		memcpy(rctx->digest, sha512_iv, 64);
> > +	else if (rctx->flags & SHA_FLAGS_SHA512_224)
> > +		memcpy(rctx->digest, sha512_224_iv, 64);
> > +	else if (rctx->flags & SHA_FLAGS_SHA512_256)
> > +		memcpy(rctx->digest, sha512_256_iv, 64);
> > +}
> 
> Can use the "digsize" from reqctx to memcpy() instead lots of if..else
> conditionals for every request?

> (Copy from another mail thread)
> Sorry, meant pre-initialized ivsize not digsize, which could be in alg wrapper structure (aspeed_hace_alg).

Are you suggesting adding a member named "ivsize" in structure aspeed_hace_alg, and pre-initialized?
Example:
struct aspeed_hace_alg aspeed_ahash_algs[] = {
	{
		.ivsize = 32;
		.alg.ahash = {...};	// aspeed-sha1
	};
	{
		.ivsize = 32;
		.alg.ahash = {...};	// aspeed-sha224
	};
	...
};

[...]

> > +static int aspeed_sham_cra_init_alg(struct crypto_tfm *tfm,
> > +				    const char *alg_base)
> > +{
> > +	struct ahash_alg *alg = __crypto_ahash_alg(tfm->__crt_alg);
> > +	struct aspeed_sham_ctx *tctx = crypto_tfm_ctx(tfm);
> > +	struct aspeed_hace_dev *hace_dev = tctx->hace_dev;
> > +	struct aspeed_hace_alg *ast_alg;
> > +
> > +	ast_alg = container_of(alg, struct aspeed_hace_alg, alg.ahash);
> > +	tctx->hace_dev = ast_alg->hace_dev;
> > +	tctx->flags = 0;
> > +
> > +	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
> > +				 sizeof(struct aspeed_sham_reqctx));
> > +
> > +	if (alg_base) {
> > +		struct aspeed_sha_hmac_ctx *bctx = tctx->base;
> > +
> > +		tctx->flags |= SHA_FLAGS_HMAC;
> > +		bctx->shash = crypto_alloc_shash(alg_base, 0,
> > +						 CRYPTO_ALG_NEED_FALLBACK);
> > +		if (IS_ERR(bctx->shash)) {
> > +			dev_warn(hace_dev->dev,
> > +				 "base driver '%s' could not be loaded.\n",
> > +				 alg_base);
> > +			return PTR_ERR(bctx->shash);
> > +		}
> > +	}
> > +
> > +	tctx->enginectx.op.do_one_request = aspeed_ahash_do_request;
> > +	tctx->enginectx.op.prepare_request = aspeed_ahash_prepare_request;
> > +	tctx->enginectx.op.unprepare_request = NULL;
> > +
> > +	return 0;
> > +}
> > +
> > +static int aspeed_sham_cra_init(struct crypto_tfm *tfm)
> > +{
> > +	return aspeed_sham_cra_init_alg(tfm, NULL);
> > +}
> > +
> > +static int aspeed_sham_cra_sha1_init(struct crypto_tfm *tfm)
> > +{
> > +	return aspeed_sham_cra_init_alg(tfm, "sha1");
> > +}
> > +
> > +static int aspeed_sham_cra_sha224_init(struct crypto_tfm *tfm)
> > +{
> > +	return aspeed_sham_cra_init_alg(tfm, "sha224");
> > +}
> > +
> > +static int aspeed_sham_cra_sha256_init(struct crypto_tfm *tfm)
> > +{
> > +	return aspeed_sham_cra_init_alg(tfm, "sha256");
> > +}
> > +
> > +static int aspeed_sham_cra_sha384_init(struct crypto_tfm *tfm)
> > +{
> > +	return aspeed_sham_cra_init_alg(tfm, "sha384");
> > +}
> > +
> > +static int aspeed_sham_cra_sha512_init(struct crypto_tfm *tfm)
> > +{
> > +	return aspeed_sham_cra_init_alg(tfm, "sha512");
> > +}
> > +
> > +static int aspeed_sham_cra_sha512_224_init(struct crypto_tfm *tfm)
> > +{
> > +	return aspeed_sham_cra_init_alg(tfm, "sha512_224");
> > +}
> > +
> > +static int aspeed_sham_cra_sha512_256_init(struct crypto_tfm *tfm)
> > +{
> > +	return aspeed_sham_cra_init_alg(tfm, "sha512_256");
> > +}
> 
> Looks like most of these cra_init callback functions are trying to
> distinguish hmac from sha algs by passing "alg_base" arg. Can collapse
> the logic in aspeed_sham_cra_init_alg() itself and storing alg_base in
> instances of aspeed_hace_alg.
> 
> 	if (ast_alg->ahash.setkey()) {
> 		/* hmac related logic */
> 		bctx->shash = crypto_alloc_shash(ast_alg->alg_base, 0,
> 			CRYPTO_ALG_NEED_FALLBACK);
> 		...

Thanks for your suggestion! It will simplify these cra_init() functions.
I'll revise it for next patch.

[...]
