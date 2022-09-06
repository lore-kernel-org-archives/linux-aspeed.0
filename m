From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Tue, 6 Sep 2022 12:53:19 +0800
Subject: [PATCH v2] crypto: aspeed: fix build module error
In-Reply-To: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
References: <20220905025433.1610696-1-neal_liu@aspeedtech.com>
Message-ID: <YxbSPxlOFX3RMLXY@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 05, 2022 at 10:54:33AM +0800, Neal Liu wrote:
> If CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_ASPEED=m,
> build modpost would be failed.
> 
> Error messages:
>   ERROR: modpost: "aspeed_register_hace_hash_algs"
>   [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
>   ERROR: modpost: "aspeed_unregister_hace_hash_algs"
>   [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> 
> Change build sequence to fix this.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> v2: Remove redundant obj- lines.
> 
>  drivers/crypto/aspeed/Makefile | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
