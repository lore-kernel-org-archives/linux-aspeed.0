From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 30 Sep 2022 14:15:00 +0800
Subject: [PATCH -next] crypto: aspeed - Fix check for platform_get_irq()
 errors
In-Reply-To: <20220920032118.6440-1-yuehaibing@huawei.com>
References: <20220920032118.6440-1-yuehaibing@huawei.com>
Message-ID: <YzaJZBDyZioUf36l@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 20, 2022 at 11:21:18AM +0800, YueHaibing wrote:
> The platform_get_irq() function returns negative on error and
> positive non-zero values on success. It never returns zero, but if it
> did then treat that as a success.
> 
> Also remove redundant dev_err() print as platform_get_irq() already
> prints an error.
> 
> Fixes: 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/aspeed/aspeed-hace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
