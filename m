From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 2 Feb 2023 11:09:55 +0800
Subject: [PATCH-next] crypto: aspeed: fix type warnings
In-Reply-To: <20230202025600.2598548-1-neal_liu@aspeedtech.com>
References: <20230202025600.2598548-1-neal_liu@aspeedtech.com>
Message-ID: <Y9spg/66x/wQ3x+g@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 02, 2023 at 10:56:00AM +0800, Neal Liu wrote:
>
> @@ -302,7 +302,7 @@ static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
>  static int aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)
>  {
>  	struct akcipher_request *req = acry_dev->req;
> -	u8 *sram_buffer = (u8 *)acry_dev->acry_sram;
> +	u8 *sram_buffer = (u8 __force *)acry_dev->acry_sram;

Wouldn't it be better to keep the iomem marker and then use readb
on sram_buffer?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
