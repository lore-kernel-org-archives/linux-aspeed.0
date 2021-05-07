From: Steven Lee <steven_lee@aspeedtech.com>
Date: Fri, 7 May 2021 14:02:29 +0800
Subject: [PATCH v3 5/5] mmc: sdhci-of-aspeed: Assert/Deassert reset
 signal before probing eMMC
In-Reply-To: <20210506102458.GA20777@pengutronix.de>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-6-steven_lee@aspeedtech.com>
 <20210506102458.GA20777@pengutronix.de>
Message-ID: <20210507060228.GC23749@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 05/06/2021 18:24, Philipp Zabel wrote:
> Hi Steven,
> 
> On Thu, May 06, 2021 at 06:03:12PM +0800, Steven Lee wrote:
> > For cleaning up the AST2600 eMMC controller, the reset signal should be
> > asserted and deasserted before it is probed.
> > 
> > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > ---
> >  drivers/mmc/host/sdhci-of-aspeed.c | 49 ++++++++++++++++++++++++------
> >  1 file changed, 40 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > index 4979f98ffb52..8ef06f32abff 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> [...]
> > @@ -533,11 +545,22 @@ static struct platform_driver aspeed_sdhci_driver = {
> >  	.remove		= aspeed_sdhci_remove,
> >  };
> >  
> > +static const struct of_device_id aspeed_sdc_of_match[] = {
> > +	{ .compatible = "aspeed,ast2400-sd-controller", },
> > +	{ .compatible = "aspeed,ast2500-sd-controller", },
> > +	{ .compatible = "aspeed,ast2600-sd-controller", .data = &ast2600_sdc_info},
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
> > +
> >  static int aspeed_sdc_probe(struct platform_device *pdev)
> >  
> >  {
> >  	struct device_node *parent, *child;
> >  	struct aspeed_sdc *sdc;
> > +	const struct of_device_id *match = NULL;
> > +	const struct aspeed_sdc_info *info = NULL;
> 
> There is no need to initialize these variables to NULL, see below:
> 

Will modify it.

> >  	int ret;
> >  
> >  	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
> > @@ -546,6 +569,23 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
> >  
> >  	spin_lock_init(&sdc->lock);
> >  
> > +	match = of_match_device(aspeed_sdc_of_match, &pdev->dev);
> 
> match is set unconditionally before it is used,
> 
> > +	if (!match)
> > +		return -ENODEV;
> > +
> > +	if (match->data)
> > +		info = match->data;
> 
> and info could be set unconditionally as well:
> 
> 	info = match->data;
> 
> > +	if (info) {
> > +		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
> > +			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);
> 
> Please use devm_reset_control_get_exclusive() or
> devm_reset_control_get_optional_exclusive().
> 

Will modify as you suggest.

> > +			if (!IS_ERR(sdc->rst)) {
> 
> Please just return errors here instead of ignoring them.
> The reset_control_get_optional variants return NULL in case the
> device node doesn't contain a resets phandle, in case you really
> consider this reset to be optional even though the flag is set?
> 

Will return error here.

> > +				reset_control_assert(sdc->rst);
> > +				reset_control_deassert(sdc->rst);
> 
> Is there no need for delays between assertion and deassertion or after
> the reset is deasserted?
> 

Per the internal discussion, I Will add udelay(1).

> > +			}
> > +		}
> > +	}
> > +
> >  	sdc->clk = devm_clk_get(&pdev->dev, NULL);
> >  	if (IS_ERR(sdc->clk))
> >  		return PTR_ERR(sdc->clk);
> 
> In general, I would assert/deassert the reset only after all resources
> are successfully acquired. This might avoid unnecessary resets in case
> of probe deferrals.
> 

Thanks for the suggestion. I will try to move the implementation of
reset after devm_ioremap_resource().

> regards
> Philipp
