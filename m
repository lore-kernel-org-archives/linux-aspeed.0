From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 6 Jun 2022 07:58:27 -0700
Subject: [PATCH v2 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <20220606064935.1458903-2-neal_liu@aspeedtech.com>
References: <20220606064935.1458903-1-neal_liu@aspeedtech.com>
 <20220606064935.1458903-2-neal_liu@aspeedtech.com>
Message-ID: <d0366136-428f-3af2-996e-a3d168b570e3@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On 6/5/22 23:49, Neal Liu wrote:
> diff --git a/drivers/crypto/aspeed/Kconfig b/drivers/crypto/aspeed/Kconfig
> new file mode 100644
> index 000000000000..17b800286a51
> --- /dev/null
> +++ b/drivers/crypto/aspeed/Kconfig
> @@ -0,0 +1,22 @@
> +config CRYPTO_DEV_ASPEED
> +	tristate "Support for Aspeed cryptographic engine driver"
> +	depends on ARCH_ASPEED
> +	help
> +	Hash and Crypto Engine (HACE) is designed to accelerate the
> +	throughput of hash data digest, encryption and decryption.
> +
> +	Select y here to have support for the cryptographic driver
> +	available on Aspeed SoC.

All of the help text above (following the 'help' line) should be indented
with one tab + 2 spaces, as is done in the help text below here.

> +
> +config CRYPTO_DEV_ASPEED_HACE_HASH
> +        bool "Enable ASPEED Hash & Crypto Engine (HACE) hash"
> +        depends on CRYPTO_DEV_ASPEED

The 2 lines above should be indented with one tab instead of multiple spaces.

> +	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
> +	select CRYPTO_HMAC
> +	help
> +	  Select here to enable ASPEED Hash & Crypto Engine (HACE)
> +	  hash driver.
> +	  Supports multiple message digest standards, including
> +	  SHA-1, SHA-224, SHA-256, SHA-384, SHA-512, and so on.

-- 
~Randy
