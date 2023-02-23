From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 23 Feb 2023 17:32:22 +0800
Subject: [PATCH] crypto: aspeed: add error handling if
 dmam_alloc_coherent() failed
In-Reply-To: <20230223085830.605202-1-neal_liu@aspeedtech.com>
References: <20230223085830.605202-1-neal_liu@aspeedtech.com>
Message-ID: <Y/cypg7zsGcs+szk@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 23, 2023 at 04:58:30PM +0800, Neal Liu wrote:
> Since the acry_dev->buf_addr may be NULL, add error handling to
> prevent any additional access to avoid potential issues.
> 
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/crypto/aspeed/aspeed-acry.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
> index 1f77ebd73489..85733e418c9e 100644
> --- a/drivers/crypto/aspeed/aspeed-acry.c
> +++ b/drivers/crypto/aspeed/aspeed-acry.c
> @@ -782,6 +782,11 @@ static int aspeed_acry_probe(struct platform_device *pdev)
>  	acry_dev->buf_addr = dmam_alloc_coherent(dev, ASPEED_ACRY_BUFF_SIZE,
>  						 &acry_dev->buf_dma_addr,
>  						 GFP_KERNEL);
> +	if (!acry_dev->buf_addr) {
> +		rc = -ENOMEM;
> +		goto err_engine_rsa_start;
> +	}
> +
>  	memzero_explicit(acry_dev->buf_addr, ASPEED_ACRY_BUFF_SIZE);

Please remove this memzero in a follow-up patch as
dmam_alloc_coherent returns memory that's already zeroed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
