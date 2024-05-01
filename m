From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 01 May 2024 23:25:51 -0000
Subject: [PATCH 08/21] pinctrl: samsung: Use scope based of_node_put()
 cleanups
In-Reply-To: <34193501-5b7b-4ffd-8549-a04c6930d02d@kernel.org>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
 <20240501-pinctrl-cleanup-v1-8-797ceca46e5c@nxp.com>
 <34193501-5b7b-4ffd-8549-a04c6930d02d@kernel.org>
Message-ID: <DU0PR04MB941755376CA87C2EC70FDF7088192@DU0PR04MB9417.eurprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH 08/21] pinctrl: samsung: Use scope based of_node_put()
> cleanups
> 
> On 01/05/2024 14:56, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Use scope based of_node_put() cleanup to simplify code.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/pinctrl/samsung/pinctrl-exynos-arm.c |  3 +--
> >  drivers/pinctrl/samsung/pinctrl-exynos.c     | 16 ++++------------
> >  drivers/pinctrl/samsung/pinctrl-s3c64xx.c    |  8 ++------
> >  drivers/pinctrl/samsung/pinctrl-samsung.c    | 26 +++++++-------------------
> >  4 files changed, 14 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
> > b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
> > index 85ddf49a5188..9a57b3ceb536 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
> > @@ -56,7 +56,7 @@ s5pv210_retention_init(struct
> samsung_pinctrl_drv_data *drvdata,
> >  		       const struct samsung_retention_data *data)  {
> >  	struct samsung_retention_ctrl *ctrl;
> > -	struct device_node *np;
> > +	struct device_node *np __free(device_node) = NULL;
> >  	void __iomem *clk_base;
> >
> >  	ctrl = devm_kzalloc(drvdata->dev, sizeof(*ctrl), GFP_KERNEL); @@
> > -71,7 +71,6 @@ s5pv210_retention_init(struct samsung_pinctrl_drv_data
> *drvdata,
> >  	}
> >
> >  	clk_base = of_iomap(np, 0);
> > -	of_node_put(np);
> 
> I don't think the code as simpler. Previous was very easy to read, obvious, no
> error paths.
> 
> To me any conversion of such of_node_get immediately followed by
> of_node_put is unwelcomed. Easy code is being  converted to complicated
> one.

ok. I will drop the changes to code pieces as you commented.

Thanks,
Peng.
> 
> 
> Best regards,
> Krzysztof

