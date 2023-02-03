From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 3 Feb 2023 09:52:01 +0800
Subject: [PATCH v2 -next] crypto: aspeed: fix type warnings
In-Reply-To: <e2dd4a02-12cb-de5e-4b64-9d6a4a1ad316@linux.microsoft.com>
References: <20230202070345.191514-1-neal_liu@aspeedtech.com>
 <e2dd4a02-12cb-de5e-4b64-9d6a4a1ad316@linux.microsoft.com>
Message-ID: <Y9xowUpO+Y7M0hho@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 02, 2023 at 05:36:05PM -0800, Dhananjay Phadke wrote:
>
> > diff --git a/drivers/crypto/aspeed/aspeed-acry.c b/drivers/crypto/aspeed/aspeed-acry.c
> > index 164c524015f0..f2429e699d14 100644
> > --- a/drivers/crypto/aspeed/aspeed-acry.c
> > +++ b/drivers/crypto/aspeed/aspeed-acry.c
> > @@ -252,7 +252,7 @@ static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
> >   				    enum aspeed_rsa_key_mode mode)
> >   {
> >   	const u8 *src = xbuf;
> > -	u32 *dw_buf = (u32 *)buf;
> > +	__le32 *dw_buf = (__le32 *)buf;
> 
> All callers are passing acry_dev->buf_addr as buf, can just change that type
> to __le32 * and deref here directly?

As buf is already void *, the cast can simply be removed.
> 
> >   	int nbits, ndw;
> >   	int i, j, idx;
> >   	u32 data = 0;
> > @@ -302,7 +302,7 @@ static int aspeed_acry_rsa_ctx_copy(struct aspeed_acry_dev *acry_dev, void *buf,
> >   static int aspeed_acry_rsa_transfer(struct aspeed_acry_dev *acry_dev)
> >   {
> >   	struct akcipher_request *req = acry_dev->req;
> > -	u8 *sram_buffer = (u8 *)acry_dev->acry_sram;
> > +	u8 __iomem *sram_buffer = (u8 __iomem *)acry_dev->acry_sram;
> 
> u8 cast seems unnecessary, readb takes (void *) and using "+ data_idx"
> offset below anyway.

Either way a cast is unnecessary as (void __iomem *) converts to
(u8 __iomem *) just fine.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
