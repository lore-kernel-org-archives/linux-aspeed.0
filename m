From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 30 Sep 2022 14:13:53 +0800
Subject: [PATCH] crypto: aspeed: fix build error when only
 CRYPTO_DEV_ASPEED is enabled
In-Reply-To: <20220919063705.358225-1-neal_liu@aspeedtech.com>
References: <20220919063705.358225-1-neal_liu@aspeedtech.com>
Message-ID: <YzaJIYl9PW+d48/l@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 19, 2022 at 02:37:05PM +0800, Neal Liu wrote:
> Fix build error within the following configs setting:
> - CONFIG_CRYPTO_DEV_ASPEED=y
> - CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH is not set
> - CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO is not set
> 
> Error messages:
> make[4]: *** No rule to make target 'drivers/crypto/aspeed/aspeed_crypto.o'
> , needed by 'drivers/crypto/aspeed/built-in.a'.
> make[4]: Target '__build' not remade because of errors.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/crypto/aspeed/Kconfig  | 3 +--
>  drivers/crypto/aspeed/Makefile | 7 ++++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
