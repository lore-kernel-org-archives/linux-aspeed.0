From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 30 May 2024 08:44:29 -0000
Subject: [PATCH v2 18/20] pinctrl: freescale: mxs: Fix refcount of child
In-Reply-To: <aa58efd3-b502-4bed-8c84-e5d78da23fbe@web.de>
References: <20240504-pinctrl-cleanup-v2-18-26c5f2dc1181@nxp.com>
 <aa58efd3-b502-4bed-8c84-e5d78da23fbe@web.de>
Message-ID: <DU0PR04MB941783DEB48C73844CD3FDBF88F32@DU0PR04MB9417.eurprd04.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v2 18/20] pinctrl: freescale: mxs: Fix refcount of child
> 
> How do you think about to use the summary phrase ?Fix reference counting
> for children in mxs_pinctrl_probe_dt()??

Thanks for reviewing. I have no plan to rework this series for non-accepted
patches. If you have interest and time, feel free to take it.

Thanks,
Peng.
> 
> 
> ?
> > of_get_next_child() will increase refcount ?
> 
>                                     the reference counter?
> 
> 
> > Per current implementation, 'child' will be override by
> 
>                                               overridden?
> 
> 
> > for_each_child_of_node(np, child), so use of_get_child_count to avoid
> > refcount leakage.
> 
> Another wording suggestion:
>   for_each_child_of_node(np, child). Thus use an of_get_child_count() call
>   to avoid reference counting leakage.
> 
> 
> Regards,
> Markus
