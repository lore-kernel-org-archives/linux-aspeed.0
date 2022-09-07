From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 7 Sep 2022 03:09:32 +0000
Subject: [PATCH v2] crypto: aspeed: fix format unexpected build warning
In-Reply-To: <712da429-6d0d-325f-1c53-39326faa2d41@infradead.org>
References: <20220905052449.1830669-1-neal_liu@aspeedtech.com>
 <Yxf+W/mJvnSKzQgM@gondor.apana.org.au>
 <712da429-6d0d-325f-1c53-39326faa2d41@infradead.org>
Message-ID: <TY2PR06MB3213D3EB56E9B01521D86FC180419@TY2PR06MB3213.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> On 9/6/22 19:13, Herbert Xu wrote:
> > On Mon, Sep 05, 2022 at 01:24:49PM +0800, Neal Liu wrote:
> >>
> >> @@ -324,7 +324,7 @@ static int aspeed_hace_ahash_trigger(struct
> aspeed_hace_dev *hace_dev,
> >>  	struct ahash_request *req = hash_engine->req;
> >>  	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
> >>
> >> -	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x,
> length:0x%x\n",
> >> +	AHASH_DBG(hace_dev, "src_dma:%zu, digest_dma:%zu, length:%zu\n",
> >>  		  hash_engine->src_dma, hash_engine->digest_dma,
> >>  		  hash_engine->src_length);
> >
> > Shouldn't we use %pad instead of %zu for dma_addr_t (you'll also need
> > to pass in a dma_addr_t pointer instead of the value)?
> 
> That sounds correct.
> I only looked at the size_t parts...

True. I'll revise it and send next patch, thanks.

