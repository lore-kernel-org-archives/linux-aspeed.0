From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 9 Sep 2022 17:07:02 +0800
Subject: [PATCH] crypto: aspeed: fix return value check in
 aspeed_hace_probe()
In-Reply-To: <20220830031347.810217-1-sunke32@huawei.com>
References: <20220830031347.810217-1-sunke32@huawei.com>
Message-ID: <YxsCNv21af5ODo28@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 30, 2022 at 11:13:47AM +0800, Sun Ke wrote:
> In case of error, the function devm_ioremap_resource() returns
> ERR_PTR() not NULL. The NULL test in the return value check must be
> replaced with IS_ERR().
> 
> Fixes: 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  drivers/crypto/aspeed/aspeed-hace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
