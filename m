From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 27 Jan 2023 19:07:56 +0800
Subject: [PATCH linux-next] crypto: aspeed - Use
 devm_platform_get_and_ioremap_resource()
In-Reply-To: <202301191536493046780@zte.com.cn>
References: <202301191536493046780@zte.com.cn>
Message-ID: <Y9OwjGKizQpgAIlu@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 19, 2023 at 03:36:49PM +0800, ye.xingchen at zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/crypto/aspeed/aspeed-hace.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
