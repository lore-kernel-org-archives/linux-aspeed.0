From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 30 Sep 2022 13:56:20 +0800
Subject: [PATCH -next] crypto: aspeed - Remove redundant dev_err call
In-Reply-To: <afde3f5c-32e4-6b89-8d6b-1f4f5a7744c4@huawei.com>
References: <20220923100159.15705-1-shangxiaojing@huawei.com>
 <HK0PR06MB320294D6E2A61F85F4276EE780519@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <afde3f5c-32e4-6b89-8d6b-1f4f5a7744c4@huawei.com>
Message-ID: <YzaFBPVtJT4hMCvw@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 23, 2022 at 08:26:21PM +0800, shangxiaojing wrote:
> 
> On 2022/9/23 18:15, Neal Liu wrote:
> > > devm_ioremap_resource() prints error message in itself. Remove the dev_err
> > > call to avoid redundant error message.
> > > 
> > > Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> > > ---
> > >   drivers/crypto/aspeed/aspeed-hace.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/crypto/aspeed/aspeed-hace.c
> > > b/drivers/crypto/aspeed/aspeed-hace.c
> > > index 3f880aafb6a2..e05c32c31842 100644
> > > --- a/drivers/crypto/aspeed/aspeed-hace.c
> > > +++ b/drivers/crypto/aspeed/aspeed-hace.c
> > > @@ -123,10 +123,8 @@ static int aspeed_hace_probe(struct platform_device
> > > *pdev)
> > >   	platform_set_drvdata(pdev, hace_dev);
> > > 
> > >   	hace_dev->regs = devm_ioremap_resource(&pdev->dev, res);
> > > -	if (IS_ERR(hace_dev->regs)) {
> > > -		dev_err(&pdev->dev, "Failed to map resources\n");
> > > +	if (IS_ERR(hace_dev->regs))
> > >   		return PTR_ERR(hace_dev->regs);
> > > -	}
> > > 
> > >   	/* Get irq number and register it */
> > >   	hace_dev->irq = platform_get_irq(pdev, 0);
> > > --
> > > 2.17.1
> > Similar patch just be proposed few days ago.
> > https://patchwork.kernel.org/project/linux-crypto/patch/20220920032118.6440-1-yuehaibing at huawei.com/
> 
> sorry, pls ignore mine.

Actually I think these two patches are different and both can be
applied.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
