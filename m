From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 7 Sep 2022 14:12:37 +0800
Subject: [PATCH v3] crypto: aspeed: fix format unexpected build warning
In-Reply-To: <20220907033431.402208-1-neal_liu@aspeedtech.com>
References: <20220907033431.402208-1-neal_liu@aspeedtech.com>
Message-ID: <Yxg2VSC2ud/lgjik@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 07, 2022 at 11:34:31AM +0800, Neal Liu wrote:
> This fixes the following similar build warning when
> enabling compile test:
> 
> aspeed-hace-hash.c:188:9: warning: format '%x' expects argument of type
> 'unsigned int', but argument 7 has type 'size_t' {aka 'long unsigned int'}
> [-Wformat=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v3: Use "%pad" to print dma_addr_t type.
> v2: Use "%zu" format to print size_t.
> 
>  drivers/crypto/aspeed/aspeed-hace-hash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
