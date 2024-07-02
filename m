From: Simon Horman <horms@kernel.org>
Date: Tue, 2 Jul 2024 14:00:24 +0100
Subject: [PATCH v1 1/1] net/ncsi: specify maximum package to probe
In-Reply-To: <20240701154336.3536924-1-peteryin.openbmc@gmail.com>
References: <20240701154336.3536924-1-peteryin.openbmc@gmail.com>
Message-ID: <20240702130024.GJ598357@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ As this seems to relate to: DT, ASPEED and ARM, CC:
  Rob Herring, Krzysztof Kozlowski, Conor Dooley, Joel Stanley, Andrew Jeffery,
  devicetree, linux-arm-kernel, linux-aspeed. ]

On Mon, Jul 01, 2024 at 11:43:36PM +0800, Peter Yin wrote:
> Most NICs have a single package. For OCP3.0 NICs, the package ID is
> determined by the slot ID. Probing all 8 package IDs is usually
> unnecessary. To reduce probe time, add properties to specify the
> maximum number of packages.
> 
> Signed-off-by: Cosmo Chou <cosmo.chou@quantatw.com>
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  net/ncsi/internal.h    |  1 +
>  net/ncsi/ncsi-manage.c | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index ef0f8f73826f..bd7ad0bf803f 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -341,6 +341,7 @@ struct ncsi_dev_priv {
>  #define NCSI_MAX_VLAN_VIDS	15
>  	struct list_head    vlan_vids;       /* List of active VLAN IDs */
>  
> +	unsigned int        max_package;     /* Num of packages to probe   */
>  	bool                multi_package;   /* Enable multiple packages   */
>  	bool                mlx_multi_host;  /* Enable multi host Mellanox */
>  	u32                 package_whitelist; /* Packages to configure    */
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 5ecf611c8820..159943ee1317 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -1358,12 +1358,12 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
>  		nd->state = ncsi_dev_state_probe_deselect;
>  		fallthrough;
>  	case ncsi_dev_state_probe_deselect:
> -		ndp->pending_req_num = 8;
> +		ndp->pending_req_num = ndp->max_package;
>  
>  		/* Deselect all possible packages */
>  		nca.type = NCSI_PKT_CMD_DP;
>  		nca.channel = NCSI_RESERVED_CHANNEL;
> -		for (index = 0; index < 8; index++) {
> +		for (index = 0; index < ndp->max_package; index++) {
>  			nca.package = index;
>  			ret = ncsi_xmit_cmd(&nca);
>  			if (ret)
> @@ -1491,7 +1491,7 @@ static void ncsi_probe_channel(struct ncsi_dev_priv *ndp)
>  
>  		/* Probe next package */
>  		ndp->package_probe_id++;
> -		if (ndp->package_probe_id >= 8) {
> +		if (ndp->package_probe_id >= ndp->max_package) {
>  			/* Probe finished */
>  			ndp->flags |= NCSI_DEV_PROBED;
>  			break;
> @@ -1746,7 +1746,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
>  	struct platform_device *pdev;
>  	struct device_node *np;
>  	unsigned long flags;
> -	int i;
> +	int i, ret;
>  
>  	/* Check if the device has been registered or not */
>  	nd = ncsi_find_dev(dev);
> @@ -1795,6 +1795,14 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
>  		if (np && (of_property_read_bool(np, "mellanox,multi-host") ||
>  			   of_property_read_bool(np, "mlx,multi-host")))
>  			ndp->mlx_multi_host = true;
> +

Should the "ncsi-package" (and above multi-host properties) be
documented in DT bindings somewhere? I was unable to locate such
documentation.

> +		if (np) {
> +			ret = of_property_read_u32(np, "ncsi-package",
> +						   &ndp->max_package);
> +			if (ret || !ndp->max_package ||
> +			    ndp->max_package > NCSI_MAX_PACKAGE)
> +				ndp->max_package = NCSI_MAX_PACKAGE;
> +		}
>  	}

It seems that ndp->max_package will be 0 unless pdev != NULL and np != NULL.
Would it be better set to NCSI_MAX_PACKAGE in such cases?

>  
>  	return nd;
> -- 
> 2.25.1
> 
> 
