From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 10 Mar 2023 19:32:38 +0800
Subject: [PATCH] crypto: aspeed: fix uninitialized symbol 'idx' warning
In-Reply-To: <20230301033205.2137450-1-neal_liu@aspeedtech.com>
References: <20230301033205.2137450-1-neal_liu@aspeedtech.com>
Message-ID: <ZAsVVp+sWeOlBdmF@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 01, 2023 at 11:32:05AM +0800, Neal Liu wrote:
> 'idx' is not initialized if it's not EXP_MODE nor MOD_MODE.
> Use "else" instead to fix it.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302261052.CVFRyq6F-lkp at intel.com/
> 
> ---
>  drivers/crypto/aspeed/aspeed-acry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
