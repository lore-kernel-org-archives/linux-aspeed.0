From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Fri, 28 Sep 2018 11:26:53 +1000
Subject: [PATCH net] net/ncsi: Extend NC-SI Netlink interface to allow
 user space to send NC-SI command
In-Reply-To: <a2f68c5eb785436ea248cb46b73ea246@AUSX13MPS306.AMER.DELL.COM>
References: <a2f68c5eb785436ea248cb46b73ea246@AUSX13MPS306.AMER.DELL.COM>
Message-ID: <6e0a46384c10d380c16b07c0bed3a4f30f53f0cc.camel@mendozajonas.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2018-09-27 at 21:08 +0000, Justin.Lee1 at Dell.com wrote:
> The new command (NCSI_CMD_SEND_CMD) is added to allow user space application 
> to send NC-SI command to the network card.
> Also, add a new attribute (NCSI_ATTR_DATA) for transferring request and response.
> 
> The work flow is as below. 
> 
> Request:
> User space application -> Netlink interface (msg)
>                                               -> new Netlink handler - ncsi_send_cmd_nl()
>                                               -> ncsi_xmit_cmd()
> Response:
> Response received - ncsi_rcv_rsp() -> internal response handler - ncsi_rsp_handler_xxx()
>                                                                         -> ncsi_rsp_handler_netlink()
>                                                                         -> ncsi_send_netlink_rsp ()
>                                                                         -> Netlink interface (msg)
>                                                                         -> user space application
> Command timeout - ncsi_request_timeout() -> ncsi_send_netlink_timeout ()
>                                                                                             -> Netlink interface (msg with zero data length)
>                                                                                             -> user space application
> Error:
> Error detected -> ncsi_send_netlink_err () -> Netlink interface (err msg)
>                                                                                        -> user space application
> 
> 
> Signed-off-by: Justin Lee <justin.lee1@dell.com>
> 

Hi Justin,

Thanks for posting this on the list! The overall design looks good and so
far looks like it should fit relatively well with the other OEM command
patch. I'll try and run some OEM commands against my machine.
Some comments below:

> 
> ---
>  include/uapi/linux/ncsi.h |   3 +
>  net/ncsi/internal.h       |  12 ++-
>  net/ncsi/ncsi-aen.c       |  10 ++-
>  net/ncsi/ncsi-cmd.c       | 106 ++++++++++++++++--------
>  net/ncsi/ncsi-manage.c    |  74 ++++++++++++++---
>  net/ncsi/ncsi-netlink.c   | 199 +++++++++++++++++++++++++++++++++++++++++++++-
>  net/ncsi/ncsi-netlink.h   |   4 +
>  net/ncsi/ncsi-rsp.c       |  70 ++++++++++++++--
>  8 files changed, 420 insertions(+), 58 deletions(-)
> 
> diff --git a/include/uapi/linux/ncsi.h b/include/uapi/linux/ncsi.h
> index 4c292ec..4992bfc 100644
> --- a/include/uapi/linux/ncsi.h
> +++ b/include/uapi/linux/ncsi.h
> @@ -30,6 +30,7 @@ enum ncsi_nl_commands {
>  	NCSI_CMD_PKG_INFO,
>  	NCSI_CMD_SET_INTERFACE,
>  	NCSI_CMD_CLEAR_INTERFACE,
> +	NCSI_CMD_SEND_CMD,
>  
>  	__NCSI_CMD_AFTER_LAST,
>  	NCSI_CMD_MAX = __NCSI_CMD_AFTER_LAST - 1
> @@ -43,6 +44,7 @@ enum ncsi_nl_commands {
>   * @NCSI_ATTR_PACKAGE_LIST: nested array of NCSI_PKG_ATTR attributes
>   * @NCSI_ATTR_PACKAGE_ID: package ID
>   * @NCSI_ATTR_CHANNEL_ID: channel ID
> + * @NCSI_ATTR_DATA: command payload
>   * @NCSI_ATTR_MAX: highest attribute number
>   */
>  enum ncsi_nl_attrs {
> @@ -51,6 +53,7 @@ enum ncsi_nl_attrs {
>  	NCSI_ATTR_PACKAGE_LIST,
>  	NCSI_ATTR_PACKAGE_ID,
>  	NCSI_ATTR_CHANNEL_ID,
> +	NCSI_ATTR_DATA,
>  
>  	__NCSI_ATTR_AFTER_LAST,
>  	NCSI_ATTR_MAX = __NCSI_ATTR_AFTER_LAST - 1
> diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
> index 8055e39..20ce735 100644
> --- a/net/ncsi/internal.h
> +++ b/net/ncsi/internal.h
> @@ -215,12 +215,17 @@ struct ncsi_request {
>  	unsigned char        id;      /* Request ID - 0 to 255           */
>  	bool                 used;    /* Request that has been assigned  */
>  	unsigned int         flags;   /* NCSI request property           */
> -#define NCSI_REQ_FLAG_EVENT_DRIVEN	1
> +#define NCSI_REQ_FLAG_EVENT_DRIVEN		1
> +#define NCSI_REQ_FLAG_NETLINK_DRIVEN	2
>  	struct ncsi_dev_priv *ndp;    /* Associated NCSI device          */
>  	struct sk_buff       *cmd;    /* Associated NCSI command packet  */
>  	struct sk_buff       *rsp;    /* Associated NCSI response packet */
>  	struct timer_list    timer;   /* Timer on waiting for response   */
>  	bool                 enabled; /* Time has been enabled or not    */
> +
> +	u32                  snd_seq;     /* netlink sending sequence number */
> +	u32                  snd_portid;  /* netlink portid of sender        */
> +	struct nlmsghdr      nlhdr;       /* netlink message header          */
>  };
>  
>  enum {
> @@ -301,10 +306,13 @@ struct ncsi_cmd_arg {
>  	unsigned short       payload;     /* Command packet payload length */
>  	unsigned int         req_flags;   /* NCSI request properties       */
>  	union {
> -		unsigned char  bytes[16]; /* Command packet specific data  */
> +		unsigned char  bytes[16];     /* Command packet specific data  */
>  		unsigned short words[8];
>  		unsigned int   dwords[4];
>  	};
> +
> +	unsigned char        *data;       /* Netlink data                  */
> +	struct genl_info     *info;       /* Netlink information           */
>  };
>  
>  extern struct list_head ncsi_dev_list;
> diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
> index 25e483e..b5ec193 100644
> --- a/net/ncsi/ncsi-aen.c
> +++ b/net/ncsi/ncsi-aen.c
> @@ -16,6 +16,7 @@
>  #include <net/ncsi.h>
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
> +#include <net/genetlink.h>
>  
>  #include "internal.h"
>  #include "ncsi-pkt.h"
> @@ -73,8 +74,8 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
>  	ncm->data[2] = data;
>  	ncm->data[4] = ntohl(lsc->oem_status);
>  
> -	netdev_dbg(ndp->ndev.dev, "NCSI: LSC AEN - channel %u state %s\n",
> -		   nc->id, data & 0x1 ? "up" : "down");
> +	netdev_dbg(ndp->ndev.dev, "NCSI: LSC AEN - pkg %u ch %u state %s\n",
> +		   nc->package->id, nc->id, data & 0x1 ? "up" : "down");

There's a few places where you've changed or added some debug statements;
these are good but could probably be in a separate patch since not all of
them are related to the OEM command handling.

>  
>  	chained = !list_empty(&nc->link);
>  	state = nc->state;
> @@ -148,9 +149,10 @@ static int ncsi_aen_handler_hncdsc(struct ncsi_dev_priv *ndp,
>  	hncdsc = (struct ncsi_aen_hncdsc_pkt *)h;
>  	ncm->data[3] = ntohl(hncdsc->status);
>  	spin_unlock_irqrestore(&nc->lock, flags);
> +
>  	netdev_dbg(ndp->ndev.dev,
> -		   "NCSI: host driver %srunning on channel %u\n",
> -		   ncm->data[3] & 0x1 ? "" : "not ", nc->id);
> +		   "NCSI: host driver %srunning on pkg %u ch %u\n",
> +		   ncm->data[3] & 0x1 ? "" : "not ", nc->package->id, nc->id);
>  
>  	return 0;
>  }
> diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
> index 7567ca63..b291297 100644
> --- a/net/ncsi/ncsi-cmd.c
> +++ b/net/ncsi/ncsi-cmd.c
> @@ -17,6 +17,7 @@
>  #include <net/ncsi.h>
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
> +#include <net/genetlink.h>
>  
>  #include "internal.h"
>  #include "ncsi-pkt.h"
> @@ -211,42 +212,75 @@ static int ncsi_cmd_handler_snfc(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +static int ncsi_cmd_handler_oem(struct sk_buff *skb,
> +								struct ncsi_cmd_arg *nca)
> +{
> +	struct ncsi_cmd_pkt *cmd;
> +	unsigned char *dest, *source;
> +	unsigned short len;
> +
> +	/* struct ncsi_cmd_pkt = minimum length
> +	 *                       - frame checksum
> +	 *                       - Ethernet header
> +	 *                     = 64 - 4 - 14 = 46
> +	 * minimum payload = 46 - ncsi header - ncsi checksum
> +	 *                 = 46 - 16 - 4 = 26
> +	 */
> +	len = nca->payload;
> +
> +	/* minimum payload length is 26 bytes to meet minimum packet
> +	 * length 64
> +	 */
> +	if (len < 26)
> +		cmd = skb_put_zero(skb, sizeof(*cmd));
> +	else
> +		cmd = skb_put_zero(skb, len + sizeof(struct ncsi_pkt_hdr) + 4);
> +
> +	dest = (unsigned char *)cmd + sizeof(struct ncsi_pkt_hdr);
> +	source = (unsigned char *)nca->data + sizeof(struct ncsi_pkt_hdr);
> +	memcpy(dest, source, len);
> +
> +	ncsi_cmd_build_header(&cmd->cmd.common, nca);
> +
> +	return 0;
> +}

This is quite similar to the other patch which is good, they shouldn't
conflict much.

> +
>  static struct ncsi_cmd_handler {
>  	unsigned char type;
>  	int           payload;
>  	int           (*handler)(struct sk_buff *skb,
>  				 struct ncsi_cmd_arg *nca);
>  } ncsi_cmd_handlers[] = {
> -	{ NCSI_PKT_CMD_CIS,    0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_SP,     4, ncsi_cmd_handler_sp      },
> -	{ NCSI_PKT_CMD_DP,     0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_EC,     0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_DC,     4, ncsi_cmd_handler_dc      },
> -	{ NCSI_PKT_CMD_RC,     4, ncsi_cmd_handler_rc      },
> -	{ NCSI_PKT_CMD_ECNT,   0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_DCNT,   0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_AE,     8, ncsi_cmd_handler_ae      },
> -	{ NCSI_PKT_CMD_SL,     8, ncsi_cmd_handler_sl      },
> -	{ NCSI_PKT_CMD_GLS,    0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_SVF,    8, ncsi_cmd_handler_svf     },
> -	{ NCSI_PKT_CMD_EV,     4, ncsi_cmd_handler_ev      },
> -	{ NCSI_PKT_CMD_DV,     0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_SMA,    8, ncsi_cmd_handler_sma     },
> -	{ NCSI_PKT_CMD_EBF,    4, ncsi_cmd_handler_ebf     },
> -	{ NCSI_PKT_CMD_DBF,    0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_EGMF,   4, ncsi_cmd_handler_egmf    },
> -	{ NCSI_PKT_CMD_DGMF,   0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_SNFC,   4, ncsi_cmd_handler_snfc    },
> -	{ NCSI_PKT_CMD_GVI,    0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_GC,     0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_GP,     0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_GCPS,   0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_GNS,    0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_GNPTS,  0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_GPS,    0, ncsi_cmd_handler_default },
> -	{ NCSI_PKT_CMD_OEM,    0, NULL                     },
> -	{ NCSI_PKT_CMD_PLDM,   0, NULL                     },
> -	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default }
> +	{ NCSI_PKT_CMD_CIS,     0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_SP,      4, ncsi_cmd_handler_sp      },
> +	{ NCSI_PKT_CMD_DP,      0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_EC,      0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_DC,      4, ncsi_cmd_handler_dc      },
> +	{ NCSI_PKT_CMD_RC,      4, ncsi_cmd_handler_rc      },
> +	{ NCSI_PKT_CMD_ECNT,    0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_DCNT,    0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_AE,      8, ncsi_cmd_handler_ae      },
> +	{ NCSI_PKT_CMD_SL,      8, ncsi_cmd_handler_sl      },
> +	{ NCSI_PKT_CMD_GLS,     0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_SVF,     8, ncsi_cmd_handler_svf     },
> +	{ NCSI_PKT_CMD_EV,      4, ncsi_cmd_handler_ev      },
> +	{ NCSI_PKT_CMD_DV,      0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_SMA,     8, ncsi_cmd_handler_sma     },
> +	{ NCSI_PKT_CMD_EBF,     4, ncsi_cmd_handler_ebf     },
> +	{ NCSI_PKT_CMD_DBF,     0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_EGMF,    4, ncsi_cmd_handler_egmf    },
> +	{ NCSI_PKT_CMD_DGMF,    0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_SNFC,    4, ncsi_cmd_handler_snfc    },
> +	{ NCSI_PKT_CMD_GVI,     0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_GC,      0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_GP,      0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_GCPS,    0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_GNS,     0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_GNPTS,   0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_GPS,     0, ncsi_cmd_handler_default },
> +	{ NCSI_PKT_CMD_OEM,    -1, ncsi_cmd_handler_oem     },
> +	{ NCSI_PKT_CMD_PLDM,    0, NULL                     },
> +	{ NCSI_PKT_CMD_GPUUID,  0, ncsi_cmd_handler_default }
>  };

You've changed the whitespace here which has made the diff unnecessarily
large; please just change the single _OEM line and keep the whitespace
the same.

>  
>  static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
> @@ -317,11 +351,20 @@ int ncsi_xmit_cmd(struct ncsi_cmd_arg *nca)
>  	}
>  
>  	/* Get packet payload length and allocate the request */
> -	nca->payload = nch->payload;
> +	if (nch->payload >= 0)
> +		nca->payload = nch->payload;
> +
>  	nr = ncsi_alloc_command(nca);
>  	if (!nr)
>  		return -ENOMEM;
>  
> +	/* track netlink information */
> +	if (nca->req_flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
> +		nr->snd_seq = nca->info->snd_seq;
> +		nr->snd_portid = nca->info->snd_portid;
> +		nr->nlhdr = *nca->info->nlhdr;
> +	}
> +
>  	/* Prepare the packet */
>  	nca->id = nr->id;
>  	ret = nch->handler(nr->cmd, nca);
> @@ -341,6 +384,7 @@ int ncsi_xmit_cmd(struct ncsi_cmd_arg *nca)
>  	 * connection a 1 second delay should be sufficient.
>  	 */
>  	nr->enabled = true;
> +
>  	mod_timer(&nr->timer, jiffies + 1 * HZ);
>  
>  	/* Send NCSI packet */
> diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
> index 0912847..6629103 100644
> --- a/net/ncsi/ncsi-manage.c
> +++ b/net/ncsi/ncsi-manage.c
> @@ -19,6 +19,7 @@
>  #include <net/addrconf.h>
>  #include <net/ipv6.h>
>  #include <net/if_inet6.h>
> +#include <net/genetlink.h>
>  
>  #include "internal.h"
>  #include "ncsi-pkt.h"
> @@ -110,8 +111,9 @@ static void ncsi_channel_monitor(struct timer_list *t)
>  	case NCSI_CHANNEL_MONITOR_WAIT ... NCSI_CHANNEL_MONITOR_WAIT_MAX:
>  		break;
>  	default:
> -		netdev_err(ndp->ndev.dev, "NCSI Channel %d timed out!\n",
> -			   nc->id);
> +		netdev_err(ndp->ndev.dev, "NCSI: pkg %u ch %u timed out!\n",
> +			   np->id, nc->id);
> +
>  		if (!(ndp->flags & NCSI_DEV_HWA)) {
>  			ncsi_report_link(ndp, true);
>  			ndp->flags |= NCSI_DEV_RESHUFFLE;
> @@ -143,6 +145,10 @@ void ncsi_start_channel_monitor(struct ncsi_channel *nc)
>  {
>  	unsigned long flags;
>  
> +	netdev_dbg(nc->package->ndp->ndev.dev,
> +			   "NCSI: %s pkg %u ch %u\n",
> +			   __func__, nc->package->id, nc->id);
> +
>  	spin_lock_irqsave(&nc->lock, flags);
>  	WARN_ON_ONCE(nc->monitor.enabled);
>  	nc->monitor.enabled = true;
> @@ -156,6 +162,10 @@ void ncsi_stop_channel_monitor(struct ncsi_channel *nc)
>  {
>  	unsigned long flags;
>  
> +	netdev_dbg(nc->package->ndp->ndev.dev,
> +			   "NCSI: %s pkg %u ch %u\n",
> +			   __func__, nc->package->id, nc->id);
> +
>  	spin_lock_irqsave(&nc->lock, flags);
>  	if (!nc->monitor.enabled) {
>  		spin_unlock_irqrestore(&nc->lock, flags);
> @@ -406,8 +416,13 @@ static void ncsi_request_timeout(struct timer_list *t)
>  {
>  	struct ncsi_request *nr = from_timer(nr, t, timer);
>  	struct ncsi_dev_priv *ndp = nr->ndp;
> +	struct ncsi_package *np;
> +	struct ncsi_channel *nc;
> +	struct ncsi_cmd_pkt *cmd;
>  	unsigned long flags;
>  
> +	netdev_dbg(ndp->ndev.dev, "NCSI: %s\n", __func__);
> +
>  	/* If the request already had associated response,
>  	 * let the response handler to release it.
>  	 */
> @@ -415,10 +430,23 @@ static void ncsi_request_timeout(struct timer_list *t)
>  	nr->enabled = false;
>  	if (nr->rsp || !nr->cmd) {
>  		spin_unlock_irqrestore(&ndp->lock, flags);
> +
> +		netdev_dbg(ndp->ndev.dev, "NCSI: %s - early return\n", __func__);
> +
>  		return;
>  	}
>  	spin_unlock_irqrestore(&ndp->lock, flags);
>  
> +	if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
> +		if (nr->cmd) {
> +			/* Find the package */
> +			cmd = (struct ncsi_cmd_pkt *)skb_network_header(nr->cmd);
> +			ncsi_find_package_and_channel(ndp, cmd->cmd.common.channel,
> +									      &np, &nc);
> +			ncsi_send_netlink_timeout(nr, np, nc);
> +		}
> +	}
> +
>  	/* Release the request */
>  	ncsi_free_request(nr);
>  }
> @@ -432,6 +460,10 @@ static void ncsi_suspend_channel(struct ncsi_dev_priv *ndp)
>  	unsigned long flags;
>  	int ret;
>  
> +	netdev_dbg(ndp->ndev.dev,
> +			   "NCSI: %s pkg %u ch %u state %04x\n",
> +			   __func__, np->id, nc->id, nd->state);
> +
>  	nca.ndp = ndp;
>  	nca.req_flags = NCSI_REQ_FLAG_EVENT_DRIVEN;
>  	switch (nd->state) {
> @@ -647,6 +679,10 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  	unsigned long flags;
>  	int ret;
>  
> +	netdev_dbg(ndp->ndev.dev,
> +			   "NCSI: %s pkg %u ch %u state %04x\n",
> +			   __func__, np->id, nc->id, nd->state);
> +
>  	nca.ndp = ndp;
>  	nca.req_flags = NCSI_REQ_FLAG_EVENT_DRIVEN;
>  	switch (nd->state) {
> @@ -788,8 +824,9 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  		}
>  		break;
>  	case ncsi_dev_state_config_done:
> -		netdev_dbg(ndp->ndev.dev, "NCSI: channel %u config done\n",
> -			   nc->id);
> +		netdev_dbg(ndp->ndev.dev,
> +				   "NCSI: pkg %u ch %u config done\n",
> +				   nc->package->id, nc->id);
>  		spin_lock_irqsave(&nc->lock, flags);
>  		if (nc->reconfigure_needed) {
>  			/* This channel's configuration has been updated
> @@ -815,9 +852,10 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
>  		} else {
>  			hot_nc = NULL;
>  			nc->state = NCSI_CHANNEL_INACTIVE;
> +
>  			netdev_dbg(ndp->ndev.dev,
> -				   "NCSI: channel %u link down after config\n",
> -				   nc->id);
> +					   "NCSI: pkg %u ch %u link down after config\n",
> +					   nc->package->id, nc->id);
>  		}
>  		spin_unlock_irqrestore(&nc->lock, flags);
>  
> @@ -853,6 +891,8 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
>  	force_package = ndp->force_package;
>  	spin_unlock_irqrestore(&ndp->lock, flags);
>  
> +	netdev_dbg(ndp->ndev.dev, "NCSI: %s\n", __func__);
> +
>  	/* Force a specific channel whether or not it has link if we have been
>  	 * configured to do so
>  	 */
> @@ -861,8 +901,8 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
>  		ncm = &found->modes[NCSI_MODE_LINK];
>  		if (!(ncm->data[2] & 0x1))
>  			netdev_info(ndp->ndev.dev,
> -				    "NCSI: Channel %u forced, but it is link down\n",
> -				    found->id);
> +					   "NCSI: pkg %u ch %u forced, but it is link down\n",
> +					   found->package->id, found->id);
>  		goto out;
>  	}
>  
> @@ -914,6 +954,7 @@ static int ncsi_choose_active_channel(struct ncsi_dev_priv *ndp)
>  out:
>  	spin_lock_irqsave(&ndp->lock, flags);
>  	list_add_tail_rcu(&found->link, &ndp->channel_queue);
> +
>  	spin_unlock_irqrestore(&ndp->lock, flags);
>  
>  	return ncsi_process_next_channel(ndp);
> @@ -1154,6 +1195,8 @@ static void ncsi_dev_work(struct work_struct *work)
>  			struct ncsi_dev_priv, work);
>  	struct ncsi_dev *nd = &ndp->ndev;
>  
> +	netdev_dbg(ndp->ndev.dev, "NCSI: %s\n", __func__);
> +
>  	switch (nd->state & ncsi_dev_state_major) {
>  	case ncsi_dev_state_probe:
>  		ncsi_probe_channel(ndp);
> @@ -1176,6 +1219,8 @@ int ncsi_process_next_channel(struct ncsi_dev_priv *ndp)
>  	int old_state;
>  	unsigned long flags;
>  
> +	netdev_dbg(ndp->ndev.dev, "NCSI: %s\n", __func__);
> +
>  	spin_lock_irqsave(&ndp->lock, flags);
>  	nc = list_first_or_null_rcu(&ndp->channel_queue,
>  				    struct ncsi_channel, link);
> @@ -1198,14 +1243,14 @@ int ncsi_process_next_channel(struct ncsi_dev_priv *ndp)
>  	switch (old_state) {
>  	case NCSI_CHANNEL_INACTIVE:
>  		ndp->ndev.state = ncsi_dev_state_config;
> -		netdev_dbg(ndp->ndev.dev, "NCSI: configuring channel %u\n",
> -	                   nc->id);
> +		netdev_dbg(ndp->ndev.dev, "NCSI: configuring pkg %u ch %u\n",
> +				   nc->package->id, nc->id);
>  		ncsi_configure_channel(ndp);
>  		break;
>  	case NCSI_CHANNEL_ACTIVE:
>  		ndp->ndev.state = ncsi_dev_state_suspend;
> -		netdev_dbg(ndp->ndev.dev, "NCSI: suspending channel %u\n",
> -			   nc->id);
> +		netdev_dbg(ndp->ndev.dev, "NCSI: suspending pkg %u ch %u\n",
> +				   nc->package->id, nc->id);
>  		ncsi_suspend_channel(ndp);
>  		break;
>  	default:
> @@ -1225,6 +1270,9 @@ int ncsi_process_next_channel(struct ncsi_dev_priv *ndp)
>  		return ncsi_choose_active_channel(ndp);
>  	}
>  
> +	netdev_dbg(ndp->ndev.dev,
> +			   "NCSI: No more channels to process\n");
> +
>  	ncsi_report_link(ndp, false);
>  	return -ENODEV;
>  }
> @@ -1475,6 +1523,7 @@ struct ncsi_dev *ncsi_register_dev(struct net_device *dev,
>  	if (list_empty(&ncsi_dev_list))
>  		register_inet6addr_notifier(&ncsi_inet6addr_notifier);
>  #endif
> +
>  	list_add_tail_rcu(&ndp->node, &ncsi_dev_list);
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>  
> @@ -1564,6 +1613,7 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
>  	if (list_empty(&ncsi_dev_list))
>  		unregister_inet6addr_notifier(&ncsi_inet6addr_notifier);
>  #endif
> +
>  	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
>  
>  	ncsi_unregister_netlink(nd->dev);
> diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
> index 45f33d6..ab1a959 100644
> --- a/net/ncsi/ncsi-netlink.c
> +++ b/net/ncsi/ncsi-netlink.c
> @@ -20,6 +20,7 @@
>  #include <uapi/linux/ncsi.h>
>  
>  #include "internal.h"
> +#include "ncsi-pkt.h"
>  #include "ncsi-netlink.h"
>  
>  static struct genl_family ncsi_genl_family;
> @@ -29,6 +30,7 @@ static const struct nla_policy ncsi_genl_policy[NCSI_ATTR_MAX + 1] = {
>  	[NCSI_ATTR_PACKAGE_LIST] =	{ .type = NLA_NESTED },
>  	[NCSI_ATTR_PACKAGE_ID] =	{ .type = NLA_U32 },
>  	[NCSI_ATTR_CHANNEL_ID] =	{ .type = NLA_U32 },
> +	[NCSI_ATTR_DATA] =			{ .type = NLA_BINARY, .len = 2048 },
>  };

Is there a particular reason for setting len to 2048, or just a decent
buffer?

>  
>  static struct ncsi_dev_priv *ndp_from_ifindex(struct net *net, u32 ifindex)
> @@ -240,7 +242,7 @@ static int ncsi_pkg_info_all_nl(struct sk_buff *skb,
>  		return 0; /* done */
>  
>  	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
> -			  &ncsi_genl_family, NLM_F_MULTI,  NCSI_CMD_PKG_INFO);
> +			  &ncsi_genl_family, NLM_F_MULTI, NCSI_CMD_PKG_INFO);
>  	if (!hdr) {
>  		rc = -EMSGSIZE;
>  		goto err;
> @@ -316,8 +318,8 @@ static int ncsi_set_interface_nl(struct sk_buff *msg, struct genl_info *info)
>  		 * package
>  		 */
>  		spin_unlock_irqrestore(&ndp->lock, flags);
> -		netdev_info(ndp->ndev.dev, "NCSI: Channel %u does not exist!\n",
> -			    channel_id);
> +		netdev_info(ndp->ndev.dev, "NCSI: pkg %u ch %u does not exist!\n",
> +					package_id, channel_id);
>  		return -ERANGE;
>  	}
>  
> @@ -366,6 +368,191 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
>  	return 0;
>  }
>  
> +static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
> +{
> +	struct ncsi_dev_priv *ndp;
> +
> +	struct ncsi_cmd_arg nca;
> +	struct ncsi_pkt_hdr *hdr;
> +
> +	u32 package_id, channel_id;
> +	unsigned char *data;
> +	void *head;
> +	int len, ret;
> +
> +	if (!info || !info->attrs) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!info->attrs[NCSI_ATTR_IFINDEX]) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!info->attrs[NCSI_ATTR_PACKAGE_ID]) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!info->attrs[NCSI_ATTR_CHANNEL_ID]) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
> +						   nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
> +	if (!ndp) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
> +	channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
> +
> +	if ((package_id & ~0x07) || (channel_id & ~0x1f)) {
> +		ret = -ERANGE;
> +		goto out_netlink;
> +	}

This is correct but hard to read; we could instead just have
	if ((package_id >= 8) ...
which is easier to interpret.
(Probably we should also define the max packages/channels somewhere too)

> +
> +	len = nla_len(info->attrs[NCSI_ATTR_DATA]);
> +	if (len < sizeof(struct ncsi_pkt_hdr)) {
> +		netdev_info(ndp->ndev.dev, "NCSI: no OEM command to send %u\n",
> +					package_id);

For statements like these follow the netdev format, eg:
		netdev_info(ndp->ndev.dev, "NCSI: no OEM command to send %u\n",
			    package_id);

> +		ret = -EINVAL;
> +		goto out_netlink;
> +	} else {
> +		head = nla_data(info->attrs[NCSI_ATTR_DATA]);
> +		data = (unsigned char *)head;
> +	}
> +
> +	hdr = (struct ncsi_pkt_hdr *)data;
> +
> +	nca.ndp = ndp;
> +	nca.package = (unsigned char)package_id;
> +	nca.channel = (unsigned char)channel_id;
> +	nca.type = hdr->type;
> +	nca.req_flags = NCSI_REQ_FLAG_NETLINK_DRIVEN;
> +	nca.info = info;
> +	nca.payload = ntohs(hdr->length);
> +	nca.data = data;
> +
> +	ret = ncsi_xmit_cmd(&nca);
> +out_netlink:
> +	if (ret != 0) {
> +		netdev_err(ndp->ndev.dev, "Error %d sending OEM command\n", ret);
> +		ncsi_send_netlink_err(ndp->ndev.dev,
> +							  info->snd_seq, info->snd_portid, info->nlhdr,
> +							  ret);
> +	}
> +out:
> +	return ret;
> +}
> +
> +int ncsi_send_netlink_rsp(struct ncsi_request *nr, struct ncsi_package *np, struct ncsi_channel *nc)
> +{
> +	struct sk_buff *skb;
> +	struct net *net;
> +	void *hdr;
> +	int rc;
> +
> +	netdev_dbg(nr->ndp->ndev.dev, "NCSI: %s\n", __func__);
> +
> +	net = dev_net(nr->rsp->dev);
> +
> +	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_put(skb, nr->snd_portid, nr->snd_seq,
> +			  &ncsi_genl_family, 0, NCSI_CMD_SEND_CMD);
> +	if (!hdr) {
> +		kfree_skb(skb);
> +		return -EMSGSIZE;
> +	}
> +
> +	nla_put_u32(skb, NCSI_ATTR_IFINDEX, nr->rsp->dev->ifindex);
> +	if (np)
> +		nla_put_u32(skb, NCSI_ATTR_PACKAGE_ID, np->id);
> +	if (nc)
> +		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, nc->id);
> +	else
> +		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, NCSI_RESERVED_CHANNEL);
> +
> +	rc = nla_put(skb, NCSI_ATTR_DATA, nr->rsp->len, (void *)nr->rsp->data);
> +	if (rc)
> +		goto err;
> +
> +	genlmsg_end(skb, hdr);
> +	return genlmsg_unicast(net, skb, nr->snd_portid);
> +
> +err:
> +	kfree_skb(skb);
> +	return rc;
> +}
> +
> +int ncsi_send_netlink_timeout(struct ncsi_request *nr, struct ncsi_package *np, struct ncsi_channel *nc)
> +{
> +	struct sk_buff *skb;
> +	struct net *net;
> +	void *hdr;
> +
> +	netdev_dbg(nr->ndp->ndev.dev, "NCSI: %s\n", __func__);
> +
> +	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_put(skb, nr->snd_portid, nr->snd_seq,
> +			  &ncsi_genl_family, 0, NCSI_CMD_SEND_CMD);
> +	if (!hdr) {
> +		kfree_skb(skb);
> +		return -EMSGSIZE;
> +	}
> +
> +	net = dev_net(nr->cmd->dev);
> +
> +	nla_put_u32(skb, NCSI_ATTR_IFINDEX, nr->cmd->dev->ifindex);
> +
> +	if (np)
> +		nla_put_u32(skb, NCSI_ATTR_PACKAGE_ID, np->id);
> +	else
> +		nla_put_u32(skb, NCSI_ATTR_PACKAGE_ID,
> +					NCSI_PACKAGE_INDEX((((struct ncsi_pkt_hdr *)nr->cmd->data)->channel)));
> +
> +	if (nc)
> +		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, nc->id);
> +	else
> +		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, NCSI_RESERVED_CHANNEL);
> +
> +	genlmsg_end(skb, hdr);
> +	return genlmsg_unicast(net, skb, nr->snd_portid);

How does the receiver of this message know it represents a timeout? Just that
it's missing the NCSI_ATTR_DATA attribute?

> +}
> +
> +int ncsi_send_netlink_err(struct net_device *dev, u32 snd_seq, u32 snd_portid, struct nlmsghdr *nlhdr, int err)
> +{
> +	struct sk_buff *skb;
> +	struct nlmsghdr *nlh;
> +	struct nlmsgerr *nle;
> +	struct net *net;
> +
> +	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	net = dev_net(dev);
> +
> +	nlh = nlmsg_put(skb, snd_portid, snd_seq,
> +					NLMSG_ERROR, sizeof(*nle), 0);
> +	nle = (struct nlmsgerr *)nlmsg_data(nlh);
> +	nle->error = err;
> +	memcpy(&nle->msg, nlhdr, sizeof(*nlh));
> +
> +	nlmsg_end(skb, nlh);
> +
> +	return nlmsg_unicast(net->genl_sock, skb, snd_portid);
> +}
> +
>  static const struct genl_ops ncsi_ops[] = {
>  	{
>  		.cmd = NCSI_CMD_PKG_INFO,
> @@ -386,6 +573,12 @@ static const struct genl_ops ncsi_ops[] = {
>  		.doit = ncsi_clear_interface_nl,
>  		.flags = GENL_ADMIN_PERM,
>  	},
> +	{
> +		.cmd = NCSI_CMD_SEND_CMD,
> +		.policy = ncsi_genl_policy,
> +		.doit = ncsi_send_cmd_nl,
> +		.flags = GENL_ADMIN_PERM,
> +	},
>  };
>  
>  static struct genl_family ncsi_genl_family __ro_after_init = {
> diff --git a/net/ncsi/ncsi-netlink.h b/net/ncsi/ncsi-netlink.h
> index 91a5c25..dadaf32 100644
> --- a/net/ncsi/ncsi-netlink.h
> +++ b/net/ncsi/ncsi-netlink.h
> @@ -14,6 +14,10 @@
>  
>  #include "internal.h"
>  
> +int ncsi_send_netlink_rsp(struct ncsi_request *nr, struct ncsi_package *np, struct ncsi_channel *nc);
> +int ncsi_send_netlink_timeout(struct ncsi_request *nr, struct ncsi_package *np, struct ncsi_channel *nc);
> +int ncsi_send_netlink_err(struct net_device *dev, u32 snd_seq, u32 snd_portid, struct nlmsghdr *nlhdr, int err);
> +
>  int ncsi_init_netlink(struct net_device *dev);
>  int ncsi_unregister_netlink(struct net_device *dev);
>  
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index 930c1d3..bdf9519 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -16,9 +16,11 @@
>  #include <net/ncsi.h>
>  #include <net/net_namespace.h>
>  #include <net/sock.h>
> +#include <net/genetlink.h>
>  
>  #include "internal.h"
>  #include "ncsi-pkt.h"
> +#include "ncsi-netlink.h"
>  
>  static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
>  				 unsigned short payload)
> @@ -32,15 +34,22 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
>  	 * before calling this function.
>  	 */
>  	h = (struct ncsi_rsp_pkt_hdr *)skb_network_header(nr->rsp);
> -	if (h->common.revision != NCSI_PKT_REVISION)
> +
> +	if (h->common.revision != NCSI_PKT_REVISION) {
> +		netdev_dbg(nr->ndp->ndev.dev, "NCSI: unsupported header revision\n");
>  		return -EINVAL;
> -	if (ntohs(h->common.length) != payload)
> +	}
> +	if (ntohs(h->common.length) != payload) {
> +		netdev_dbg(nr->ndp->ndev.dev, "NCSI: payload length mismatched\n");
>  		return -EINVAL;
> +	}
>  
>  	/* Check on code and reason */
>  	if (ntohs(h->code) != NCSI_PKT_RSP_C_COMPLETED ||
> -	    ntohs(h->reason) != NCSI_PKT_RSP_R_NO_ERROR)
> -		return -EINVAL;
> +	    ntohs(h->reason) != NCSI_PKT_RSP_R_NO_ERROR) {
> +		netdev_dbg(nr->ndp->ndev.dev, "NCSI: non zero response/reason code\n");
> +		return -EPERM;
> +	}

Why the change to EPERM?

>  
>  	/* Validate checksum, which might be zeroes if the
>  	 * sender doesn't support checksum according to NCSI
> @@ -52,8 +61,11 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
>  
>  	checksum = ncsi_calculate_checksum((unsigned char *)h,
>  					   sizeof(*h) + payload - 4);
> -	if (*pchecksum != htonl(checksum))
> +
> +	if (*pchecksum != htonl(checksum)) {
> +		netdev_dbg(nr->ndp->ndev.dev, "NCSI: checksum mismatched\n");
>  		return -EINVAL;
> +	}
>  
>  	return 0;
>  }
> @@ -900,6 +912,31 @@ static int ncsi_rsp_handler_gpuuid(struct ncsi_request *nr)
>  	return 0;
>  }
>  
> +static int ncsi_rsp_handler_oem(struct ncsi_request *nr)
> +{
> +	return 0;
> +}
> +
> +static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
> +{
> +	struct ncsi_rsp_pkt *rsp;
> +	struct ncsi_dev_priv *ndp = nr->ndp;
> +	struct ncsi_package *np;
> +	struct ncsi_channel *nc;
> +	int ret;
> +
> +	/* Find the package */
> +	rsp = (struct ncsi_rsp_pkt *)skb_network_header(nr->rsp);
> +	ncsi_find_package_and_channel(ndp, rsp->rsp.common.channel,
> +				      &np, &nc);
> +	if (!np)
> +		return -ENODEV;
> +
> +	ret = ncsi_send_netlink_rsp(nr, np, nc);
> +
> +	return ret;
> +}
> +
>  static struct ncsi_rsp_handler {
>  	unsigned char	type;
>  	int             payload;
> @@ -932,7 +969,7 @@ static struct ncsi_rsp_handler {
>  	{ NCSI_PKT_RSP_GNS,   172, ncsi_rsp_handler_gns     },
>  	{ NCSI_PKT_RSP_GNPTS, 172, ncsi_rsp_handler_gnpts   },
>  	{ NCSI_PKT_RSP_GPS,     8, ncsi_rsp_handler_gps     },
> -	{ NCSI_PKT_RSP_OEM,     0, NULL                     },
> +	{ NCSI_PKT_RSP_OEM,    -1, ncsi_rsp_handler_oem     },
>  	{ NCSI_PKT_RSP_PLDM,    0, NULL                     },
>  	{ NCSI_PKT_RSP_GPUUID, 20, ncsi_rsp_handler_gpuuid  }
>  };
> @@ -950,6 +987,7 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
>  
>  	/* Find the NCSI device */
>  	nd = ncsi_find_dev(dev);
> +
>  	ndp = nd ? TO_NCSI_DEV_PRIV(nd) : NULL;

There's a few spots around where you've added or changed whitespace,
please clean these bits up.

>  	if (!ndp)
>  		return -ENODEV;
> @@ -1002,6 +1040,15 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
>  		netdev_warn(ndp->ndev.dev,
>  			    "NCSI: 'bad' packet ignored for type 0x%x\n",
>  			    hdr->type);
> +
> +		if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
> +			if (ret == -EPERM)
> +				goto out_netlink;
> +			else
> +				ncsi_send_netlink_err(ndp->ndev.dev,
> +									  nr->snd_seq, nr->snd_portid, &nr->nlhdr,
> +									  ret);
> +		}

More netdev formatting, multi-line statements should be like:

				ncsi_send_netlink_err(ndp->ndev.dev,
						      nr->snd_seq, nr->snd_portid, &nr->nlhdr,
						      ret);

>  		goto out;
>  	}
>  
> @@ -1011,6 +1058,17 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
>  		netdev_err(ndp->ndev.dev,
>  			   "NCSI: Handler for packet type 0x%x returned %d\n",
>  			   hdr->type, ret);
> +
> +out_netlink:
> +	if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
> +		ret = ncsi_rsp_handler_netlink(nr);
> +		if (ret) {
> +			netdev_err(ndp->ndev.dev,
> +					   "NCSI: Netlink handler for packet type 0x%x returned %d\n",
> +					   hdr->type, ret);
> +		}
> +	}
> +
>  out:
>  	ncsi_free_request(nr);
>  	return ret;


