From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 10 Oct 2018 17:19:11 +0000
Subject: [PATCH net-next v4] net/ncsi: Extend NC-SI Netlink interface to
 allow user space to send NC-SI command
In-Reply-To: <7c7f95baba3a467e89aabf726a5230f7@AUSX13MPS302.AMER.DELL.COM>
References: <7c7f95baba3a467e89aabf726a5230f7@AUSX13MPS302.AMER.DELL.COM>
Message-ID: <57729D0A-A210-41F4-BAF8-3BDB2FCBF1B5@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Justin,
Please see minor comments below.

Regards
-Vijay

?On 10/10/18, 9:01 AM, "Justin.Lee1 at Dell.com" <Justin.Lee1@Dell.com> wrote:

    The new command (NCSI_CMD_SEND_CMD) is added to allow user space application
    to send NC-SI command to the network card.
    Also, add a new attribute (NCSI_ATTR_DATA) for transferring request and response.
    
    The work flow is as below. 
    
    Request:
    User space application
    	-> Netlink interface (msg)
    	-> new Netlink handler - ncsi_send_cmd_nl()
    	-> ncsi_xmit_cmd()
    
    Response:
    Response received - ncsi_rcv_rsp()
    	-> internal response handler - ncsi_rsp_handler_xxx()
    	-> ncsi_rsp_handler_netlink()
    	-> ncsi_send_netlink_rsp ()
    	-> Netlink interface (msg)
    	-> user space application
    
    Command timeout - ncsi_request_timeout()
    	-> ncsi_send_netlink_timeout ()
    	-> Netlink interface (msg with zero data length)
    	-> user space application
    
    Error:
    Error detected
    	-> ncsi_send_netlink_err ()
    	-> Netlink interface (err msg)
    	-> user space application
    
    
    Signed-off-by: Justin Lee <justin.lee1@dell.com> 
    
    
    ---
    V4: Update comments and remove some debug message.
    V3: Based on https://urldefense.proofpoint.com/v2/url?u=http-3A__patchwork.ozlabs.org_patch_979688_&d=DwIGaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=v9MU0Ki9pWnTXCWwjHPVgpnCR80vXkkcrIaqU7USl5g&m=38KSrF_ThuoRmouLx-xKKkkpk9EfhNFEEqXbduQqQpE&s=GRXR1sIEzNo7xDKyUWS9t1Ita6vxEX_llzMx2azueVc&e= to remove the duplicated code.
    V2: Remove non-related debug message and clean up the code.
    
    
    --- a/net/ncsi/internal.h
    +++ b/net/ncsi/internal.h
    @@ -175,6 +175,8 @@ struct ncsi_package;
     #define NCSI_RESERVED_CHANNEL	0x1f
     #define NCSI_CHANNEL_INDEX(c)	((c) & ((1 << NCSI_PACKAGE_SHIFT) - 1))
     #define NCSI_TO_CHANNEL(p, c)	(((p) << NCSI_PACKAGE_SHIFT) | (c))
    +#define NCSI_MAX_PACKAGE	8
    +#define NCSI_MAX_CHANNEL	32
     
     struct ncsi_channel {
     	unsigned char               id;
    @@ -219,12 +221,17 @@ struct ncsi_request {
     	unsigned char        id;      /* Request ID - 0 to 255           */
     	bool                 used;    /* Request that has been assigned  */
     	unsigned int         flags;   /* NCSI request property           */
    -#define NCSI_REQ_FLAG_EVENT_DRIVEN	1
    +#define NCSI_REQ_FLAG_EVENT_DRIVEN		1
  
  Why extra space added above?

    +#define NCSI_REQ_FLAG_NETLINK_DRIVEN	2
     	struct ncsi_dev_priv *ndp;    /* Associated NCSI device          */
     	struct sk_buff       *cmd;    /* Associated NCSI command packet  */
     	struct sk_buff       *rsp;    /* Associated NCSI response packet */
     	struct timer_list    timer;   /* Timer on waiting for response   */
     	bool                 enabled; /* Time has been enabled or not    */
    +
    +	u32                  snd_seq;     /* netlink sending sequence number */
    +	u32                  snd_portid;  /* netlink portid of sender        */
    +	struct nlmsghdr      nlhdr;       /* netlink message header          */
     };
     
  Extra line inside structure may not be required.

     enum {
    @@ -310,6 +317,7 @@ struct ncsi_cmd_arg {
     		unsigned int   dwords[4];
     	};
     	unsigned char        *data;       /* NCSI OEM data                 */
    +	struct genl_info     *info;       /* Netlink information           */
     };
     
    diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
    index 45f33d6..62e191f 100644
    --- a/net/ncsi/ncsi-netlink.c
    +++ b/net/ncsi/ncsi-netlink.c
    @@ -20,6 +20,7 @@
     #include <uapi/linux/ncsi.h>
     
     #include "internal.h"
    +#include "ncsi-pkt.h"
     #include "ncsi-netlink.h"
     
     static struct genl_family ncsi_genl_family;
    @@ -29,6 +30,7 @@ static const struct nla_policy ncsi_genl_policy[NCSI_ATTR_MAX + 1] = {
     	[NCSI_ATTR_PACKAGE_LIST] =	{ .type = NLA_NESTED },
     	[NCSI_ATTR_PACKAGE_ID] =	{ .type = NLA_U32 },
     	[NCSI_ATTR_CHANNEL_ID] =	{ .type = NLA_U32 },
    +	[NCSI_ATTR_DATA] =		{ .type = NLA_BINARY, .len = 2048 },
     };
     
     static struct ncsi_dev_priv *ndp_from_ifindex(struct net *net, u32 ifindex)
    @@ -366,6 +368,198 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
     	return 0;
     }
     
    +static int ncsi_send_cmd_nl(struct sk_buff *msg, struct genl_info *info)
    +{
    +	struct ncsi_dev_priv *ndp;
    +
    +	struct ncsi_cmd_arg nca;
    +	struct ncsi_pkt_hdr *hdr;
    +
    +	u32 package_id, channel_id;
    +	unsigned char *data;
    +	int len, ret;
    +
    +	if (!info || !info->attrs) {
    +		ret = -EINVAL;
    +		goto out;
    +	}
    +
    +	if (!info->attrs[NCSI_ATTR_IFINDEX]) {
    +		ret = -EINVAL;
    +		goto out;
    +	}
    +
    +	if (!info->attrs[NCSI_ATTR_PACKAGE_ID]) {
    +		ret = -EINVAL;
    +		goto out;
    +	}
    +
    +	if (!info->attrs[NCSI_ATTR_CHANNEL_ID]) {
    +		ret = -EINVAL;
    +		goto out;
    +	}
    +
    +	ndp = ndp_from_ifindex(get_net(sock_net(msg->sk)),
    +			       nla_get_u32(info->attrs[NCSI_ATTR_IFINDEX]));
    +	if (!ndp) {
    +		ret = -ENODEV;
    +		goto out;
    +	}
    +
    +	package_id = nla_get_u32(info->attrs[NCSI_ATTR_PACKAGE_ID]);
    +	channel_id = nla_get_u32(info->attrs[NCSI_ATTR_CHANNEL_ID]);
    +
    +	if (package_id >= NCSI_MAX_PACKAGE || channel_id >= NCSI_MAX_CHANNEL) {
    +		ret = -ERANGE;
    +		goto out_netlink;
    +	}
    +
    +	len = nla_len(info->attrs[NCSI_ATTR_DATA]);
    +	if (len < sizeof(struct ncsi_pkt_hdr)) {
    +		netdev_info(ndp->ndev.dev, "NCSI: no command to send %u\n",
    +			    package_id);
    +		ret = -EINVAL;
    +		goto out_netlink;
    +	} else {
    +		data = (unsigned char *)nla_data(info->attrs[NCSI_ATTR_DATA]);
    +	}
    +
    +	hdr = (struct ncsi_pkt_hdr *)data;
    +
    +	nca.ndp = ndp;
    +	nca.package = (unsigned char)package_id;
    +	nca.channel = (unsigned char)channel_id;
    +	nca.type = hdr->type;
    +	nca.req_flags = NCSI_REQ_FLAG_NETLINK_DRIVEN;
    +	nca.info = info;
    +	nca.payload = ntohs(hdr->length);
    +	nca.data = data + sizeof(*hdr);
    +
    +	ret = ncsi_xmit_cmd(&nca);
    +out_netlink:
    +	if (ret != 0) {
    +		netdev_err(ndp->ndev.dev,
    +			   "NCSI: Error %d sending OEM command\n",
    +			   ret);
    +		ncsi_send_netlink_err(ndp->ndev.dev,
    +				      info->snd_seq,
    +				      info->snd_portid,
    +				      info->nlhdr,
    +				      ret);
    +	}

  OEM should be removed from above message.

    +out:
    +	return ret;
    +}
    +
     
    
    

