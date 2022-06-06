From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 6 Jun 2022 07:56:51 -0700
Subject: [PATCH v2 5/5] crypto: aspeed: add HACE crypto driver
In-Reply-To: <20220606064935.1458903-6-neal_liu@aspeedtech.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-6-neal_liu@aspeedtech.com>
Message-ID: <8f4176e7-87b0-1cf9-bcef-6a423d17fd6a@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi--

On 6/5/22 23:49, Neal Liu wrote:
> diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
> index 17b800286a51..5e4d18288bf1 100644
> --- a/drivers/crypto/aspeed/Kconfig
> +++ b/drivers/crypto/aspeed/Kconfig
> @@ -20,3 +20,19 @@ config CRYPTO_DEV_ASPEED_HACE_HASH
>  	  hash driver.
>  	  Supports multiple message digest standards, including
>  	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.
> +
> +config CRYPTO_DEV_ASPEED_HACE_CRYPTO
> +        bool "Enable ASPEED Hash & Crypto Engine (HACE) crypto"
> +        depends on CRYPTO_DEV_ASPEED

The 2 lines above should be indented with one tab instead of multiple spaces.

> +	select CRYPTO_AES
> +	select CRYPTO_DES
> +	select CRYPTO_ECB
> +	select CRYPTO_CBC
> +	select CRYPTO_CFB
> +	select CRYPTO_OFB
> +	select CRYPTO_CTR
> +	help
> +	  Select here to enable ASPEED Hash & Crypto Engine (HACE)
> +	  crypto driver.
> +	  Supports AES/DES symmetric-key encryption and decryption
> +	  with ECB/CBC/CFB/OFB/CTR options.

-- 
~Randy
