From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 30 Sep 2022 14:17:00 +0800
Subject: [PATCH -next] crypto: aspeed - Remove redundant dev_err call
In-Reply-To: <20220923100159.15705-1-shangxiaojing@huawei.com>
References: <20220923100159.15705-1-shangxiaojing@huawei.com>
Message-ID: <YzaJ3H5xExfx9HFO@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 23, 2022 at 06:01:59PM +0800, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  drivers/crypto/aspeed/aspeed-hace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
