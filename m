From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 10 Mar 2023 19:28:05 +0800
Subject: [PATCH -next] crypto: Use devm_platform_ioremap_resource()
In-Reply-To: <20230220123921.7191-1-yang.lee@linux.alibaba.com>
References: <20230220123921.7191-1-yang.lee@linux.alibaba.com>
Message-ID: <ZAsURY/nI6LywTuh@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 20, 2023 at 08:39:21PM +0800, Yang Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to Use devm_platform_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/crypto/aspeed/aspeed-acry.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
