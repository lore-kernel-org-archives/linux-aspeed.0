From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Fri, 20 Sep 2019 01:33:04 -0000
Subject: [PATCH] net/ncsi: Disable global multicast filter
In-Reply-To: <20190912190451.2362220-1-vijaykhemka@fb.com>
References: <20190912190451.2362220-1-vijaykhemka@fb.com>
Message-ID: <20190919183252.5cb041b2@cakuba.netronome.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2019 12:04:50 -0700, Vijay Khemka wrote:
> Disabling multicast filtering from NCSI if it is supported. As it
> should not filter any multicast packets. In current code, multicast
> filter is enabled and with an exception of optional field supported
> by device are disabled filtering.
> 
> Mainly I see if goal is to disable filtering for IPV6 packets then let
> it disabled for every other types as well. As we are seeing issues with
> LLDP not working with this enabled filtering. And there are other issues
> with IPV6.
> 
> By Disabling this multicast completely, it is working for both IPV6 as
> well as LLDP.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

> @@ -1033,23 +1030,23 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  		} else if (nd->state == ncsi_dev_state_config_ebf) {
>  			nca.type = NCSI_PKT_CMD_EBF;
>  			nca.dwords[0] = nc->caps[NCSI_CAP_BC].cap;
> -			if (ncsi_channel_is_tx(ndp, nc))
> +			/* if multicast global filtering is supported then
> +			 * disable it so that all multicast packet will be
> +			 * forwarded to management controller
> +			 */
> +			if (nc->caps[NCSI_CAP_GENERIC].cap &
> +			     NCSI_CAP_GENERIC_MC)

Applied, looks like an unnecessary space sneaked in here, I removed it.
