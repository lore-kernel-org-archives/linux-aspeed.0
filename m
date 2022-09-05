From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 4 Sep 2022 20:36:24 -0700
Subject: [PATCH] crypto: aspeed: fix format unexpected build warning
In-Reply-To: <20220905032838.1663510-1-neal_liu@aspeedtech.com>
References: <20220905032838.1663510-1-neal_liu@aspeedtech.com>
Message-ID: <64caed2a-fafe-040d-c967-5eebaf6b144d@infradead.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 9/4/22 20:28, Neal Liu wrote:
> This fixes the following similar build warning when
> enabling compile test:
> 
> aspeed-hace-hash.c:188:9: warning: format '%x' expects argument of type
> 'unsigned int', but argument 7 has type 'size_t' {aka 'long unsigned int'}
> [-Wformat=]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/crypto/aspeed/aspeed-hace-hash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
> index 0a44ffc0e13b..d0f61149fe24 100644
> --- a/drivers/crypto/aspeed/aspeed-hace-hash.c
> +++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
> @@ -186,7 +186,7 @@ static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev *hace_dev)
>  	length = rctx->total + rctx->bufcnt - remain;
>  
>  	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
> -		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
> +		  "rctx total", rctx->total, "bufcnt", (u32)rctx->bufcnt,
>  		  "length", length, "remain", remain);
>  
>  	sg_len = dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
> @@ -325,8 +325,8 @@ static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
>  	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>  
>  	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
> -		  hash_engine->src_dma, hash_engine->digest_dma,
> -		  hash_engine->src_length);
> +		  (u32)hash_engine->src_dma, (u32)hash_engine->digest_dma,
> +		  (u32)hash_engine->src_length);
>  
>  	rctx->cmd |= HASH_CMD_INT_ENABLE;
>  	hash_engine->resume = resume;

No, size_t values should be printed with %zu.
No cast needed.

-- 
~Randy
