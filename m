From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Tue, 26 Jul 2022 13:41:09 -0700
Subject: [PATCH v8 5/5] crypto: aspeed: add HACE crypto driver
In-Reply-To: <20220726113448.2964968-6-neal_liu@aspeedtech.com>
References: <20220726113448.2964968-1-neal_liu@aspeedtech.com>
 <20220726113448.2964968-6-neal_liu@aspeedtech.com>
Message-ID: <9d6beefe-9974-22f8-750c-68c9acb707ab@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Neal,

Thanks for addressing v7 review comments, few more below.

On 7/26/2022 4:34 AM, Neal Liu wrote:
> Add HACE crypto driver to support symmetric-key
> encryption and decryption with multiple modes of
> operation.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> ---
>   drivers/crypto/aspeed/Kconfig              |   26 +
>   drivers/crypto/aspeed/Makefile             |    7 +-
>   drivers/crypto/aspeed/aspeed-hace-crypto.c | 1121 ++++++++++++++++++++
>   drivers/crypto/aspeed/aspeed-hace.c        |   91 +-
>   drivers/crypto/aspeed/aspeed-hace.h        |  112 ++
>   5 files changed, 1354 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/crypto/aspeed/aspeed-hace-crypto.c
> 
> diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
> index 059e627efef8..f19994915a5e 100644
> --- a/drivers/crypto/aspeed/Kconfig
> +++ b/drivers/crypto/aspeed/Kconfig
> @@ -30,3 +30,29 @@ config CRYPTO_DEV_ASPEED_HACE_HASH_DEBUG
>   	  to ask for those messages.
>   	  Avoid enabling this option for production build to
>   	  minimize driver timing.
> +
> +config CRYPTO_DEV_ASPEED_HACE_CRYPTO
> +	bool "Enable Aspeed Hash & Crypto Engine (HACE) crypto"
> +	depends on CRYPTO_DEV_ASPEED
> +	select CRYPTO_ENGINE
> +	select CRYPTO_AES
> +	select CRYPTO_DES
> +	select CRYPTO_ECB
> +	select CRYPTO_CBC
> +	select CRYPTO_CFB
> +	select CRYPTO_OFB
> +	select CRYPTO_CTR
> +	help
> +	  Select here to enable Aspeed Hash & Crypto Engine (HACE)
> +	  crypto driver.
> +	  Supports AES/DES symmetric-key encryption and decryption
> +	  with ECB/CBC/CFB/OFB/CTR options.
> +
> +config CRYPTO_DEV_ASPEED_HACE_CRYPTO_DEBUG
> +	bool "Enable HACE crypto debug messages"
> +	depends on CRYPTO_DEV_ASPEED_HACE_CRYPTO
> +	help
> +	  Print HACE crypto debugging messages if you use this option
> +	  to ask for those messages.
> +	  Avoid enabling this option for production build to
> +	  minimize driver timing.

Why are separate options required for hash and crypto algorithms, if
hace is only hw crypto on the SoCs?

Looks like that's requiring unnecessary __weak register / unregister
functions [see below].

Couldn't just two options CONFIG_CRYPTO_DEV_ASPEED and 
CONFIG_CRYPTO_DEV_ASPEED_DEBUG be simpler to set for downstream defconfigs?

> diff --git a/drivers/crypto/aspeed/Makefile b/drivers/crypto/aspeed/Makefile
> index 8bc8d4fed5a9..421e2ca9c53e 100644
> --- a/drivers/crypto/aspeed/Makefile
> +++ b/drivers/crypto/aspeed/Makefile
> @@ -1,6 +1,9 @@
>   obj-$(CONFIG_CRYPTO_DEV_ASPEED) += aspeed_crypto.o
> -aspeed_crypto-objs := aspeed-hace.o \
> -		      $(hace-hash-y)
> +aspeed_crypto-objs := aspeed-hace.o	\
> +		      $(hace-hash-y)	\
> +		      $(hace-crypto-y)
>   
>   obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) += aspeed-hace-hash.o
>   hace-hash-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH) := aspeed-hace-hash.o
> +obj-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) += aspeed-hace-crypto.o
> +hace-crypto-$(CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO) := aspeed-hace-crypto.o
> diff --git a/drivers/crypto/aspeed/aspeed-hace-crypto.c b/drivers/crypto/aspeed/aspeed-hace-crypto.c
> new file mode 100644

[...]

> +
> +void aspeed_register_hace_crypto_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	int rc, i;
> +
> +	CIPHER_DBG(hace_dev, "\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_crypto_algs); i++) {
> +		aspeed_crypto_algs[i].hace_dev = hace_dev;
> +		rc = crypto_register_skcipher(&aspeed_crypto_algs[i].alg.skcipher);
> +		if (rc) {
> +			CIPHER_DBG(hace_dev, "Failed to register %s\n",
> +				   aspeed_crypto_algs[i].alg.skcipher.base.cra_name);
> +		}
> +	}
> +
> +	if (hace_dev->version != AST2600_VERSION)
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(aspeed_crypto_algs_g6); i++) {
> +		aspeed_crypto_algs_g6[i].hace_dev = hace_dev;
> +		rc = crypto_register_skcipher(&aspeed_crypto_algs_g6[i].alg.skcipher);
> +		if (rc) {
> +			CIPHER_DBG(hace_dev, "Failed to register %s\n",
> +				   aspeed_crypto_algs_g6[i].alg.skcipher.base.cra_name);
> +		}
> +	}
> +}
> diff --git a/drivers/crypto/aspeed/aspeed-hace.c b/drivers/crypto/aspeed/aspeed-hace.c
> index 89b1585d72e2..efc0725ebf98 100644
> --- a/drivers/crypto/aspeed/aspeed-hace.c
> +++ b/drivers/crypto/aspeed/aspeed-hace.c
> @@ -32,10 +32,22 @@ void __weak aspeed_unregister_hace_hash_algs(struct aspeed_hace_dev *hace_dev)
>   	dev_warn(hace_dev->dev, "%s: Not supported yet\n", __func__);
>   }
>   
> +/* Weak function for HACE crypto */
> +void __weak aspeed_register_hace_crypto_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	dev_warn(hace_dev->dev, "%s: Not supported yet\n", __func__);
> +}
> +
> +void __weak aspeed_unregister_hace_crypto_algs(struct aspeed_hace_dev *hace_dev)
> +{
> +	dev_warn(hace_dev->dev, "%s: Not supported yet\n", __func__);
> +}
> +

aspeed_unregister_hace_crypto_algs() is not implemented in 
aspeed-hace-crypto.c, so those algorithms are not unregistered during 
unload.

This was missed because of __weak function.

>   /* HACE interrupt service routine */
>   static irqreturn_t aspeed_hace_irq(int irq, void *dev)
>   {
>   	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)dev;
> +	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
>   	struct aspeed_engine_hash *hash_engine = &hace_dev->hash_engine;
>   	u32 sts;
>   
> @@ -51,9 +63,24 @@ static irqreturn_t aspeed_hace_irq(int irq, void *dev)
>   			dev_warn(hace_dev->dev, "HASH no active requests.\n");
>   	}
>   
> +	if (sts & HACE_CRYPTO_ISR) {
> +		if (crypto_engine->flags & CRYPTO_FLAGS_BUSY)
> +			tasklet_schedule(&crypto_engine->done_task);
> +		else
> +			dev_warn(hace_dev->dev, "CRYPTO no active requests.\n");
> +	}
> +
>   	return IRQ_HANDLED;
>   }
>   
> +static void aspeed_hace_crypto_done_task(unsigned long data)
> +{
> +	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
> +	struct aspeed_engine_crypto *crypto_engine = &hace_dev->crypto_engine;
> +
> +	crypto_engine->resume(hace_dev);
> +}
> +
>   static void aspeed_hace_hash_done_task(unsigned long data)
>   {
>   	struct aspeed_hace_dev *hace_dev = (struct aspeed_hace_dev *)data;
> @@ -65,11 +92,13 @@ static void aspeed_hace_hash_done_task(unsigned long data)
>   static void aspeed_hace_register(struct aspeed_hace_dev *hace_dev)
>   {
>   	aspeed_register_hace_hash_algs(hace_dev);
> +	aspeed_register_hace_crypto_algs(hace_dev);
>   }
>   
>   static void aspeed_hace_unregister(struct aspeed_hace_dev *hace_dev)
>   {
>   	aspeed_unregister_hace_hash_algs(hace_dev);
> +	aspeed_unregister_hace_crypto_algs(hace_dev);
>   }

Could just wrap these calls instead of weak functions.

static void aspeed_hace_unregister(struct aspeed_hace_dev *hace_dev)
{
#ifdef CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH
   	aspeed_unregister_hace_hash_algs(hace_dev);
#endif
#ifdef CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO
	aspeed_unregister_hace_crypto_algs(hace_dev);
#endif
}

>   
>   static const struct of_device_id aspeed_hace_of_matches[] = {
> @@ -80,6 +109,7 @@ static const struct of_device_id aspeed_hace_of_matches[] = {
>   
>   static int aspeed_hace_probe(struct platform_device *pdev)
>   {
> +	struct aspeed_engine_crypto *crypto_engine;
>   	const struct of_device_id *hace_dev_id;
>   	struct aspeed_engine_hash *hash_engine;
>   	struct aspeed_hace_dev *hace_dev;
> @@ -100,6 +130,7 @@ static int aspeed_hace_probe(struct platform_device *pdev)
>   	hace_dev->dev = &pdev->dev;
>   	hace_dev->version = (unsigned long)hace_dev_id->data;
>   	hash_engine = &hace_dev->hash_engine;
> +	crypto_engine = &hace_dev->crypto_engine;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

Thanks,
Dhananjay
