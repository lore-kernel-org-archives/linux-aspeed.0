From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 10 Feb 2023 17:48:42 +0800
Subject: [RESENT PATCH v3 -next] crypto: aspeed: fix type warnings
In-Reply-To: <20230203033512.980497-1-neal_liu@aspeedtech.com>
References: <20230203033512.980497-1-neal_liu@aspeedtech.com>
Message-ID: <Y+YS+jnOZuK9yAmI@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 03, 2023 at 11:35:12AM +0800, Neal Liu wrote:
> This patch fixes following warnings:
> 
> 1. sparse: incorrect type in assignment (different base types)
> Fix: change to __le32 type.
> 2. sparse: cast removes address space '__iomem' of expression
> Fix: use readb to avoid dereferencing the memory.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
> Change since v2: remove unnecessary cast.
> Change since v1: keep iomem marker to remain its purpose.
> 
>  drivers/crypto/aspeed/aspeed-acry.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
