From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 7 Sep 2022 10:13:47 +0800
Subject: [PATCH v2] crypto: aspeed: fix format unexpected build warning
In-Reply-To: <20220905052449.1830669-1-neal_liu@aspeedtech.com>
References: <20220905052449.1830669-1-neal_liu@aspeedtech.com>
Message-ID: <Yxf+W/mJvnSKzQgM@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 05, 2022 at 01:24:49PM +0800, Neal Liu wrote:
>
> @@ -324,7 +324,7 @@ static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
>  	struct ahash_request *req = hash_engine->req;
>  	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
>  
> -	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
> +	AHASH_DBG(hace_dev, "src_dma:%zu, digest_dma:%zu, length:%zu\n",
>  		  hash_engine->src_dma, hash_engine->digest_dma,
>  		  hash_engine->src_length);

Shouldn't we use %pad instead of %zu for dma_addr_t (you'll also
need to pass in a dma_addr_t pointer instead of the value)?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
