From: Stefan Schaeckeler (sschaeck) <sschaeck@cisco.com>
Date: Wed, 29 May 2019 03:10:54 +0000
Subject: [PATCH -next] EDAC: aspeed: Remove set but not used variable 'np'
In-Reply-To: <04f103fb-54b1-4911-8164-44b20bfd1e72@www.fastmail.com>
References: <20190525144153.2028-1-yuehaibing@huawei.com>
 <04f103fb-54b1-4911-8164-44b20bfd1e72@www.fastmail.com>
Message-ID: <960D5667-41E7-47F3-9C0A-726CA919B82D@cisco.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On  Tuesday, May 28, 2019 at 6:27 PM, Andrew Jeffery wrote:
> On Sun, 26 May 2019, at 00:12, YueHaibing wrote:
> > Fixes gcc '-Wunused-but-set-variable' warning:
> >
> > drivers/edac/aspeed_edac.c: In function aspeed_probe:
> > drivers/edac/aspeed_edac.c:284:22: warning: variable np set but not
> > used [-Wunused-but-set-variable]
> >
> > It is never used and can be removed.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Stefan Schaeckeler <sschaeck@cisco.com>

> > ---
> >  drivers/edac/aspeed_edac.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> > index 11833c0a5d07..5634437bb39d 100644
> > --- a/drivers/edac/aspeed_edac.c
> > +++ b/drivers/edac/aspeed_edac.c
> > @@ -281,15 +281,11 @@ static int aspeed_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct edac_mc_layer layers[2];
> >  	struct mem_ctl_info *mci;
> > -	struct device_node *np;
> >  	struct resource *res;
> >  	void __iomem *regs;
> >  	u32 reg04;
> > 	int rc;
> >
> > -	/* setup regmap */
> > -	np = dev->of_node;
> > -
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!res)
> >  		return -ENOENT;
> > --
> > 2.17.1

