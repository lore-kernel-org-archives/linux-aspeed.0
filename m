From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Sat, 28 Dec 2019 09:58:38 -0800
Subject: [net-next PATCH] net/ncsi: Fix gma flag setting after response
In-Reply-To: <20191227224349.2182366-1-vijaykhemka@fb.com>
References: <20191227224349.2182366-1-vijaykhemka@fb.com>
Message-ID: <9d5d71d2cb6be3d98ccd85f971667c2e0ed32e06.camel@mendozajonas.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2019-12-27 at 14:43 -0800, Vijay Khemka wrote:
> gma_flag was set at the time of GMA command request but it should
> only be set after getting successful response. Movinng this flag
> setting in GMA response handler.
> 
> This flag is used mainly for not repeating GMA command once
> received MAC address.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Technically this means the driver will always send this command every
time it configures if the associated NIC doesn't respond to this
command, but that won't change the behaviour otherwise.

Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

> ---
>  net/ncsi/ncsi-manage.c | 3 ---
>  net/ncsi/ncsi-rsp.c    | 6 ++++++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 70fe02697544..e20b81514029 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -764,9 +764,6 @@ static int ncsi_gma_handler(struct ncsi_cmd_arg
> *nca, unsigned int mf_id)
>  		return -1;
>  	}
>  
> -	/* Set the flag for GMA command which should only be called
> once */
> -	nca->ndp->gma_flag = 1;
> -
>  	/* Get Mac address from NCSI device */
>  	return nch->handler(nca);
>  }
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index d5611f04926d..a94bb59793f0 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -627,6 +627,9 @@ static int ncsi_rsp_handler_oem_mlx_gma(struct
> ncsi_request *nr)
>  	saddr.sa_family = ndev->type;
>  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
>  	memcpy(saddr.sa_data, &rsp->data[MLX_MAC_ADDR_OFFSET],
> ETH_ALEN);
> +	/* Set the flag for GMA command which should only be called
> once */
> +	ndp->gma_flag = 1;
> +
>  	ret = ops->ndo_set_mac_address(ndev, &saddr);
>  	if (ret < 0)
>  		netdev_warn(ndev, "NCSI: 'Writing mac address to device
> failed\n");
> @@ -671,6 +674,9 @@ static int ncsi_rsp_handler_oem_bcm_gma(struct
> ncsi_request *nr)
>  	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
>  		return -ENXIO;
>  
> +	/* Set the flag for GMA command which should only be called
> once */
> +	ndp->gma_flag = 1;
> +
>  	ret = ops->ndo_set_mac_address(ndev, &saddr);
>  	if (ret < 0)
>  		netdev_warn(ndev, "NCSI: 'Writing mac address to device
> failed\n");

