From: Neal Liu <neal_liu@aspeedtech.com>
Date: Thu, 2 Feb 2023 03:23:29 +0000
Subject: [PATCH-next] crypto: aspeed: fix type warnings
In-Reply-To: <Y9spg/66x/wQ3x+g@gondor.apana.org.au>
References: <20230202025600.2598548-1-neal_liu@aspeedtech.com>
 <Y9spg/66x/wQ3x+g@gondor.apana.org.au>
Message-ID: <TY2PR06MB321395387369059BC9F9722E80D69@TY2PR06MB3213.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Thursday, February 2, 2023 11:10 AM
> To: Neal Liu <neal_liu@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; David
> S . Miller <davem@davemloft.net>; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> linux-crypto at vger.kernel.org
> Subject: Re: [PATCH-next] crypto: aspeed: fix type warnings
> 
> On Thu, Feb 02, 2023 at 10:56:00AM +0800, Neal Liu wrote:
> >
> > @@ -302,7 +302,7 @@ static int aspeed_acry_rsa_ctx_copy(struct
> > aspeed_acry_dev *acry_dev, void *buf,  static int
> > aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)  {
> >  	struct akcipher_request *req = acry_dev->req;
> > -	u8 *sram_buffer = (u8 *)acry_dev->acry_sram;
> > +	u8 *sram_buffer = (u8 __force *)acry_dev->acry_sram;
> 
> Wouldn't it be better to keep the iomem marker and then use readb on
> sram_buffer?
> 
This way works too.
I cannot tell which way is better. Do you prefer to keep the iomem marker?
Thanks

-Neal
