From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 16 Sep 2019 19:20:02 +0000
Subject: [PATCH] net/ncsi: Disable global multicast filter
In-Reply-To: <eb370d3280327b512828adc62b64656e65b22745.camel@mendozajonas.com>
References: <20190912190451.2362220-1-vijaykhemka@fb.com>
 <eb370d3280327b512828adc62b64656e65b22745.camel@mendozajonas.com>
Message-ID: <C2D47466-A743-43A1-A624-4BA0609B9351@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 9/15/19, 7:39 PM, "Samuel Mendoza-Jonas" <sam@mendozajonas.com> wrote:

    On Thu, 2019-09-12 at 12:04 -0700, Vijay Khemka wrote:
    > Disabling multicast filtering from NCSI if it is supported. As it
    > should not filter any multicast packets. In current code, multicast
    > filter is enabled and with an exception of optional field supported
    > by device are disabled filtering.
    > 
    > Mainly I see if goal is to disable filtering for IPV6 packets then
    > let
    > it disabled for every other types as well. As we are seeing issues
    > with
    > LLDP not working with this enabled filtering. And there are other
    > issues
    > with IPV6.
    > 
    > By Disabling this multicast completely, it is working for both IPV6
    > as
    > well as LLDP.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    Hi Vijay,
    
    There are definitely some current issues with multicast filtering and
    IPv6 when behind NC-SI at the moment. It would be nice to make this
    configurable instead of disabling the component wholesale but I don't
    believe this actually *breaks* anyone's configuration. It would be nice
    to see some Tested-By's from the OpenBMC people though.
    
    I'll have a look at the multicast issues, CC'ing in Chris too who IIRC
    was looking at similar issues for u-bmc in case he got further.

Sam,
The current multicast issues for IPV6 are vendor's issues. And if some is 
not supporting IPV6 forwarding to management controller bit fields in 
EGMF then we are filtering it and by disabling filtering it works for Mellanox
And Broadcom cards. I have tested it. That's why I have disabled it to start with
And it can be enabled from netlink utility if required.
    
    Acked-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
    
    > ---
    >  net/ncsi/internal.h    |  7 +--
    >  net/ncsi/ncsi-manage.c | 98 +++++-----------------------------------
    > --
    >  2 files changed, 12 insertions(+), 93 deletions(-)
    > 
    > diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
    > index 0b3f0673e1a2..ad3fd7f1da75 100644
    > --- a/net/ncsi/internal.h
    > +++ b/net/ncsi/internal.h
    > @@ -264,9 +264,7 @@ enum {
    >  	ncsi_dev_state_config_ev,
    >  	ncsi_dev_state_config_sma,
    >  	ncsi_dev_state_config_ebf,
    > -#if IS_ENABLED(CONFIG_IPV6)
    > -	ncsi_dev_state_config_egmf,
    > -#endif
    > +	ncsi_dev_state_config_dgmf,
    >  	ncsi_dev_state_config_ecnt,
    >  	ncsi_dev_state_config_ec,
    >  	ncsi_dev_state_config_ae,
    > @@ -295,9 +293,6 @@ struct ncsi_dev_priv {
    >  #define NCSI_DEV_RESET		8            /* Reset state of
    > NC          */
    >  	unsigned int        gma_flag;        /* OEM GMA
    > flag               */
    >  	spinlock_t          lock;            /* Protect the NCSI
    > device    */
    > -#if IS_ENABLED(CONFIG_IPV6)
    > -	unsigned int        inet6_addr_num;  /* Number of IPv6
    > addresses   */
    > -#endif
    >  	unsigned int        package_probe_id;/* Current ID during
    > probe    */
    >  	unsigned int        package_num;     /* Number of
    > packages         */
    >  	struct list_head    packages;        /* List of
    > packages           */
    > diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
    > index 755aab66dcab..bce8b443289d 100644
    > --- a/net/ncsi/ncsi-manage.c
    > +++ b/net/ncsi/ncsi-manage.c
    > @@ -14,7 +14,6 @@
    >  #include <net/sock.h>
    >  #include <net/addrconf.h>
    >  #include <net/ipv6.h>
    > -#include <net/if_inet6.h>
    >  #include <net/genetlink.h>
    >  
    >  #include "internal.h"
    > @@ -978,9 +977,7 @@ static void ncsi_configure_channel(struct
    > ncsi_dev_priv *ndp)
    >  	case ncsi_dev_state_config_ev:
    >  	case ncsi_dev_state_config_sma:
    >  	case ncsi_dev_state_config_ebf:
    > -#if IS_ENABLED(CONFIG_IPV6)
    > -	case ncsi_dev_state_config_egmf:
    > -#endif
    > +	case ncsi_dev_state_config_dgmf:
    >  	case ncsi_dev_state_config_ecnt:
    >  	case ncsi_dev_state_config_ec:
    >  	case ncsi_dev_state_config_ae:
    > @@ -1033,23 +1030,23 @@ static void ncsi_configure_channel(struct
    > ncsi_dev_priv *ndp)
    >  		} else if (nd->state == ncsi_dev_state_config_ebf) {
    >  			nca.type = NCSI_PKT_CMD_EBF;
    >  			nca.dwords[0] = nc->caps[NCSI_CAP_BC].cap;
    > -			if (ncsi_channel_is_tx(ndp, nc))
    > +			/* if multicast global filtering is supported
    > then
    > +			 * disable it so that all multicast packet will
    > be
    > +			 * forwarded to management controller
    > +			 */
    > +			if (nc->caps[NCSI_CAP_GENERIC].cap &
    > +			     NCSI_CAP_GENERIC_MC)
    > +				nd->state = ncsi_dev_state_config_dgmf;
    > +			else if (ncsi_channel_is_tx(ndp, nc))
    >  				nd->state = ncsi_dev_state_config_ecnt;
    >  			else
    >  				nd->state = ncsi_dev_state_config_ec;
    > -#if IS_ENABLED(CONFIG_IPV6)
    > -			if (ndp->inet6_addr_num > 0 &&
    > -			    (nc->caps[NCSI_CAP_GENERIC].cap &
    > -			     NCSI_CAP_GENERIC_MC))
    > -				nd->state = ncsi_dev_state_config_egmf;
    > -		} else if (nd->state == ncsi_dev_state_config_egmf) {
    > -			nca.type = NCSI_PKT_CMD_EGMF;
    > -			nca.dwords[0] = nc->caps[NCSI_CAP_MC].cap;
    > +		} else if (nd->state == ncsi_dev_state_config_dgmf) {
    > +			nca.type = NCSI_PKT_CMD_DGMF;
    >  			if (ncsi_channel_is_tx(ndp, nc))
    >  				nd->state = ncsi_dev_state_config_ecnt;
    >  			else
    >  				nd->state = ncsi_dev_state_config_ec;
    > -#endif /* CONFIG_IPV6 */
    >  		} else if (nd->state == ncsi_dev_state_config_ecnt) {
    >  			if (np->preferred_channel &&
    >  			    nc != np->preferred_channel)
    > @@ -1483,70 +1480,6 @@ int ncsi_process_next_channel(struct
    > ncsi_dev_priv *ndp)
    >  	return -ENODEV;
    >  }
    >  
    > -#if IS_ENABLED(CONFIG_IPV6)
    > -static int ncsi_inet6addr_event(struct notifier_block *this,
    > -				unsigned long event, void *data)
    > -{
    > -	struct inet6_ifaddr *ifa = data;
    > -	struct net_device *dev = ifa->idev->dev;
    > -	struct ncsi_dev *nd = ncsi_find_dev(dev);
    > -	struct ncsi_dev_priv *ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;
    > -	struct ncsi_package *np;
    > -	struct ncsi_channel *nc;
    > -	struct ncsi_cmd_arg nca;
    > -	bool action;
    > -	int ret;
    > -
    > -	if (!ndp || (ipv6_addr_type(&ifa->addr) &
    > -	    (IPV6_ADDR_LINKLOCAL | IPV6_ADDR_LOOPBACK)))
    > -		return NOTIFY_OK;
    > -
    > -	switch (event) {
    > -	case NETDEV_UP:
    > -		action = (++ndp->inet6_addr_num) == 1;
    > -		nca.type = NCSI_PKT_CMD_EGMF;
    > -		break;
    > -	case NETDEV_DOWN:
    > -		action = (--ndp->inet6_addr_num == 0);
    > -		nca.type = NCSI_PKT_CMD_DGMF;
    > -		break;
    > -	default:
    > -		return NOTIFY_OK;
    > -	}
    > -
    > -	/* We might not have active channel or packages. The IPv6
    > -	 * required multicast will be enabled when active channel
    > -	 * or packages are chosen.
    > -	 */
    > -	np = ndp->active_package;
    > -	nc = ndp->active_channel;
    > -	if (!action || !np || !nc)
    > -		return NOTIFY_OK;
    > -
    > -	/* We needn't enable or disable it if the function isn't
    > supported */
    > -	if (!(nc->caps[NCSI_CAP_GENERIC].cap & NCSI_CAP_GENERIC_MC))
    > -		return NOTIFY_OK;
    > -
    > -	nca.ndp = ndp;
    > -	nca.req_flags = 0;
    > -	nca.package = np->id;
    > -	nca.channel = nc->id;
    > -	nca.dwords[0] = nc->caps[NCSI_CAP_MC].cap;
    > -	ret = ncsi_xmit_cmd(&nca);
    > -	if (ret) {
    > -		netdev_warn(dev, "Fail to %s global multicast filter
    > (%d)\n",
    > -			    (event == NETDEV_UP) ? "enable" :
    > "disable", ret);
    > -		return NOTIFY_DONE;
    > -	}
    > -
    > -	return NOTIFY_OK;
    > -}
    > -
    > -static struct notifier_block ncsi_inet6addr_notifier = {
    > -	.notifier_call = ncsi_inet6addr_event,
    > -};
    > -#endif /* CONFIG_IPV6 */
    > -
    >  static int ncsi_kick_channels(struct ncsi_dev_priv *ndp)
    >  {
    >  	struct ncsi_dev *nd = &ndp->ndev;
    > @@ -1725,11 +1658,6 @@ struct ncsi_dev *ncsi_register_dev(struct
    > net_device *dev,
    >  	}
    >  
    >  	spin_lock_irqsave(&ncsi_dev_lock, flags);
    > -#if IS_ENABLED(CONFIG_IPV6)
    > -	ndp->inet6_addr_num = 0;
    > -	if (list_empty(&ncsi_dev_list))
    > -		register_inet6addr_notifier(&ncsi_inet6addr_notifier);
    > -#endif
    >  	list_add_tail_rcu(&ndp->node, &ncsi_dev_list);
    >  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
    >  
    > @@ -1896,10 +1824,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
    >  
    >  	spin_lock_irqsave(&ncsi_dev_lock, flags);
    >  	list_del_rcu(&ndp->node);
    > -#if IS_ENABLED(CONFIG_IPV6)
    > -	if (list_empty(&ncsi_dev_list))
    > -		unregister_inet6addr_notifier(&ncsi_inet6addr_notifier)
    > ;
    > -#endif
    >  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
    >  
    >  	ncsi_unregister_netlink(nd->dev);
    
    

