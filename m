From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 30 Dec 2022 16:29:17 +0800
Subject: [PATCH v4 1/4] crypto: aspeed: Add ACRY RSA driver
In-Reply-To: <20221214070114.3966155-2-neal_liu@aspeedtech.com>
References: <20221214070114.3966155-1-neal_liu@aspeedtech.com>
 <20221214070114.3966155-2-neal_liu@aspeedtech.com>
Message-ID: <Y66hXZHl+kqIivOl@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 14, 2022 at 03:01:11PM +0800, Neal Liu wrote:
>
> +static u8 *aspeed_rsa_key_copy(u8 *src, size_t len)
> +{
> +	return kmemdup(src, len, GFP_DMA | GFP_KERNEL);

Please explain why you are using GFP_DMA.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
