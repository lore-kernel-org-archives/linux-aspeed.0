From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 10 Mar 2023 19:30:02 +0800
Subject: [PATCH v2] crypto: aspeed: add error handling if
 dmam_alloc_coherent() failed
In-Reply-To: <20230224020521.3158285-1-neal_liu@aspeedtech.com>
References: <20230224020521.3158285-1-neal_liu@aspeedtech.com>
Message-ID: <ZAsUuq8TRO/xpcDy@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 24, 2023 at 10:05:21AM +0800, Neal Liu wrote:
> Since the acry_dev->buf_addr may be NULL, add error handling to
> prevent any additional access to avoid potential issues.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
> Change since v1: remove memzero_explicit() as dmam_alloc_coherent()
> returns memory that's already zeroed.
> 
>  drivers/crypto/aspeed/aspeed-acry.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
