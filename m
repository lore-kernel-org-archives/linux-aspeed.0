From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 3 Jan 2023 03:37:48 +0000
Subject: [PATCH v4 1/4] crypto: aspeed: Add ACRY RSA driver
In-Reply-To: <Y66hXZHl+kqIivOl@gondor.apana.org.au>
References: <20221214070114.3966155-1-neal_liu@aspeedtech.com>
 <20221214070114.3966155-2-neal_liu@aspeedtech.com>
 <Y66hXZHl+kqIivOl@gondor.apana.org.au>
Message-ID: <TY2PR06MB321306D17A97FBEBFE969A8B80F49@TY2PR06MB3213.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, December 30, 2022 4:29 PM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
> Jeffery <andrew@aj.id.au>; David S . Miller <davem@davemloft.net>;
> ChiaWei Wang <chiawei_wang@aspeedtech.com>;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> linux-crypto at vger.kernel.org; Christoph Hellwig <hch@infradead.org>
> Subject: Re: [PATCH v4 1/4] crypto: aspeed: Add ACRY RSA driver
> 
> On Wed, Dec 14, 2022 at 03:01:11PM +0800, Neal Liu wrote:
> >
> > +static u8 *aspeed_rsa_key_copy(u8 *src, size_t len) {
> > +	return kmemdup(src, len, GFP_DMA | GFP_KERNEL);
> 
> Please explain why you are using GFP_DMA.

Looks like it's unnecessary. I'll remove it.
Thanks.

> Thanks,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
> http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
