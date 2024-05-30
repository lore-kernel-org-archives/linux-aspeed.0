From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 30 May 2024 08:42:19 -0000
Subject: [PATCH v2 04/20] pinctrl: starfive: Use scope based of_node_put()
 cleanups
In-Reply-To: <96beb071-ec2c-475f-8fa2-d519a1b1dc28@web.de>
References: <20240504-pinctrl-cleanup-v2-4-26c5f2dc1181@nxp.com>
 <96beb071-ec2c-475f-8fa2-d519a1b1dc28@web.de>
Message-ID: <DU0PR04MB9417AEB942C1EDC053B3894288F32@DU0PR04MB9417.eurprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Markus

> Subject: Re: [PATCH v2 04/20] pinctrl: starfive: Use scope based of_node_put()
> cleanups
>
> > Use scope based of_node_put() cleanup to simplify code.
>
> I see opportunities to improve affected function implementations another bit.
>
>
> ...
> > +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c
> ...
> > @@ -543,18 +540,18 @@ static int starfive_dt_node_to_map(struct
> pinctrl_dev *pctldev,
> >                     pins = devm_kcalloc(dev, npins, sizeof(*pins),
> GFP_KERNEL);
> >                     if (!pins) {
> >                             ret = -ENOMEM;
> > -                           goto put_child;
> > +                           goto free_map;
> >                     }
> >
> >                     pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux),
> GFP_KERNEL);
> >                     if (!pinmux) {
> >                             ret = -ENOMEM;
> > -                           goto put_child;
> > +                           goto free_map;
> >                     }
> ...
> > @@ -623,8 +620,6 @@ static int starfive_dt_node_to_map(struct
> pinctrl_dev *pctldev,
> >     mutex_unlock(&sfp->mutex);
> >     return 0;
> >
> > -put_child:
> > -   of_node_put(child);
> >  free_map:
> >     pinctrl_utils_free_map(pctldev, map, nmaps);
> >     mutex_unlock(&sfp->mutex);
> ...
> > +++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
> ...
> > @@ -175,18 +175,18 @@ static int jh7110_dt_node_to_map(struct
> pinctrl_dev *pctldev,
> >             pins = devm_kcalloc(dev, npins, sizeof(*pins), GFP_KERNEL);
> >             if (!pins) {
> >                     ret = -ENOMEM;
> > -                   goto put_child;
> > +                   goto free_map;
> >             }
> >
> >             pinmux = devm_kcalloc(dev, npins, sizeof(*pinmux),
> GFP_KERNEL);
> >             if (!pinmux) {
> >                     ret = -ENOMEM;
> > -                   goto put_child;
> > +                   goto free_map;
> >             }
> ...
> > @@ -233,8 +233,6 @@ static int jh7110_dt_node_to_map(struct
> pinctrl_dev *pctldev,
> >     *num_maps = nmaps;
> >     return 0;
> >
> > -put_child:
> > -   of_node_put(child);
> >  free_map:
> >     pinctrl_utils_free_map(pctldev, map, nmaps);
> >     mutex_unlock(&sfp->mutex);
>
>
> 1. Exception handling is repeated a few times also according to memory
> allocation failures.
>    How do you think about to use a corresponding label like "e_nomem"
>    so that another bit of duplicate source code can be avoided?

I have no plan to rework this series for non-accepted patches. If you have
interest and time, feel free to take it.
>
> https://wiki.se/
> i.cmu.edu%2Fconfluence%2Fdisplay%2Fc%2FMEM12-
> C.%2BConsider%2Busing%2Ba%2Bgoto%2Bchain%2Bwhen%2Bleaving%2Ba%
> 2Bfunction%2Bon%2Berror%2Bwhen%2Busing%2Band%2Breleasing%2Bresou
> rces&data=05%7C02%7Cpeng.fan%40nxp.com%7C293bafdf40524fa4655b08
> dc7e58f6b2%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63852
> 4167804502915%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata
> =Kb5cz6sVxW1TNfQ8MM2F6YLIIztyjvW4wULEJLYKRM8%3D&reserved=0
>
> 2. Will development interests grow for the usage of a statement like
> "guard(mutex)(&sfp->mutex);"?

I have no plan on this.

Thanks,
Peng.
>
>
> Regards,
> Markus
