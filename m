From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 27 Jan 2023 19:07:46 +0800
Subject: [PATCH -next] crypto: aspeed: change aspeed_acry_akcipher_algs
 to static
In-Reply-To: <20230119014859.1900136-1-yangyingliang@huawei.com>
References: <20230119014859.1900136-1-yangyingliang@huawei.com>
Message-ID: <Y9OwgsHFhOTcqx3s@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 19, 2023 at 09:48:59AM +0800, Yang Yingliang wrote:
> aspeed_acry_akcipher_algs is only used in aspeed-acry.c now,
> change it to static.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/crypto/aspeed/aspeed-acry.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
