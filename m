From: Justin.Lee1@Dell.com <Justin.Lee1@Dell.com>
Date: Fri, 28 Sep 2018 18:15:59 +0000
Subject: [PATCH net v2] net/ncsi: Extend NC-SI Netlink interface to allow user
 space to send NC-SI command
Message-ID: <58fff61ffd8d4038b59f32b696e76bbc@AUSX13MPS306.AMER.DELL.COM>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The new command (NCSI_CMD_SEND_CMD) is added to allow user space application 
to send NC-SI command to the network card.
Also, add a new attribute (NCSI_ATTR_DATA) for transferring request and response.

The work flow is as below. 

Request:
User space application -> Netlink interface (msg)
                                              -> new Netlink handler - ncsi_send_cmd_nl()
                                              -> ncsi_xmit_cmd()
Response:
Response received - ncsi_rcv_rsp() -> internal response handler - ncsi_rsp_handler_xxx()
                                                                        -> ncsi_rsp_handler_netlink()
                                                                        -> ncsi_send_netlink_rsp ()
                                                                        -> Netlink interface (msg)
                                                                        -> user space application
Command timeout - ncsi_request_timeout() -> ncsi_send_netlink_timeout ()
                                                                                            -> Netlink interface (msg with zero data length)
                                                                                            -> user space application
Error:
Error detected -> ncsi_send_netlink_err () -> Netlink interface (err msg)
                                                                                       -> user space application


Signed-off-by: Justin Lee <justin.lee1@dell.com>

---
 include/uapi/linux/ncsi.h |   3 +
 net/ncsi/internal.h       |  12 ++-
 net/ncsi/ncsi-cmd.c       |  47 ++++++++++-
 net/ncsi/ncsi-manage.c    |  22 +++++
 net/ncsi/ncsi-netlink.c   | 205 ++++++++++++++++++++++++++++++++++++++++++++++
 net/ncsi/ncsi-netlink.h   |  12 +++
 net/ncsi/ncsi-rsp.c       |  71 ++++++++++++++--
 7 files changed, 363 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/ncsi.h b/include/uapi/linux/ncsi.h
index 4c292ec..4992bfc 100644
--- a/include/uapi/linux/ncsi.h
+++ b/include/uapi/linux/ncsi.h
@@ -30,6 +30,7 @@ enum ncsi_nl_commands {
 	NCSI_CMD_PKG_INFO,
 	NCSI_CMD_SET_INTERFACE,
 	NCSI_CMD_CLEAR_INTERFACE,
+	NCSI_CMD_SEND_CMD,
 
 	__NCSI_CMD_AFTER_LAST,
 	NCSI_CMD_MAX = __NCSI_CMD_AFTER_LAST - 1
@@ -43,6 +44,7 @@ enum ncsi_nl_commands {
  * @NCSI_ATTR_PACKAGE_LIST: nested array of NCSI_PKG_ATTR attributes
  * @NCSI_ATTR_PACKAGE_ID: package ID
  * @NCSI_ATTR_CHANNEL_ID: channel ID
+ * @NCSI_ATTR_DATA: command payload
  * @NCSI_ATTR_MAX: highest attribute number
  */
 enum ncsi_nl_attrs {
@@ -51,6 +53,7 @@ enum ncsi_nl_attrs {
 	NCSI_ATTR_PACKAGE_LIST,
 	NCSI_ATTR_PACKAGE_ID,
 	NCSI_ATTR_CHANNEL_ID,
+	NCSI_ATTR_DATA,
 
 	__NCSI_ATTR_AFTER_LAST,
 	NCSI_ATTR_MAX = __NCSI_ATTR_AFTER_LAST - 1
diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 8055e39..1a3ef9e 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -171,6 +171,8 @@ struct ncsi_package;
 #define NCSI_RESERVED_CHANNEL	0x1f
 #define NCSI_CHANNEL_INDEX(c)	((c) & ((1 << NCSI_PACKAGE_SHIFT) - 1))
 #define NCSI_TO_CHANNEL(p, c)	(((p) << NCSI_PACKAGE_SHIFT) | (c))
+#define NCSI_MAX_PACKAGE	8
+#define NCSI_MAX_CHANNEL	32
 
 struct ncsi_channel {
 	unsigned char               id;
@@ -215,12 +217,17 @@ struct ncsi_request {
 	unsigned char        id;      /* Request ID - 0 to 255           */
 	bool                 used;    /* Request that has been assigned  */
 	unsigned int         flags;   /* NCSI request property           */
-#define NCSI_REQ_FLAG_EVENT_DRIVEN	1
+#define NCSI_REQ_FLAG_EVENT_DRIVEN		1
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
 
 enum {
@@ -305,6 +312,9 @@ struct ncsi_cmd_arg {
 		unsigned short words[8];
 		unsigned int   dwords[4];
 	};
+
+	unsigned char        *data;       /* Netlink data                  */
+	struct genl_info     *info;       /* Netlink information           */
 };
 
 extern struct list_head ncsi_dev_list;
diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
index 7567ca63..43b544c 100644
--- a/net/ncsi/ncsi-cmd.c
+++ b/net/ncsi/ncsi-cmd.c
@@ -17,6 +17,7 @@
 #include <net/ncsi.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
+#include <net/genetlink.h>
 
 #include "internal.h"
 #include "ncsi-pkt.h"
@@ -211,6 +212,39 @@ static int ncsi_cmd_handler_snfc(struct sk_buff *skb,
 	return 0;
 }
 
+static int ncsi_cmd_handler_oem(struct sk_buff *skb,
+				struct ncsi_cmd_arg *nca)
+{
+	struct ncsi_cmd_pkt *cmd;
+	unsigned char *dest, *source;
+	unsigned short len;
+
+	/* struct ncsi_cmd_pkt = minimum length
+	 *                       - frame checksum
+	 *                       - Ethernet header
+	 *                     = 64 - 4 - 14 = 46
+	 * minimum payload = 46 - ncsi header - ncsi checksum
+	 *                 = 46 - 16 - 4 = 26
+	 */
+	len = nca->payload;
+
+	/* minimum payload length is 26 bytes to meet minimum packet
+	 * length 64
+	 */
+	if (len < 26)
+		cmd = skb_put_zero(skb, sizeof(*cmd));
+	else
+		cmd = skb_put_zero(skb, len + sizeof(struct ncsi_pkt_hdr) + 4);
+
+	dest = (unsigned char *)cmd + sizeof(struct ncsi_pkt_hdr);
+	source = (unsigned char *)nca->data + sizeof(struct ncsi_pkt_hdr);
+	memcpy(dest, source, len);
+
+	ncsi_cmd_build_header(&cmd->cmd.common, nca);
+
+	return 0;
+}
+
 static struct ncsi_cmd_handler {
 	unsigned char type;
 	int           payload;
@@ -244,7 +278,7 @@ static struct ncsi_cmd_handler {
 	{ NCSI_PKT_CMD_GNS,    0, ncsi_cmd_handler_default },
 	{ NCSI_PKT_CMD_GNPTS,  0, ncsi_cmd_handler_default },
 	{ NCSI_PKT_CMD_GPS,    0, ncsi_cmd_handler_default },
-	{ NCSI_PKT_CMD_OEM,    0, NULL                     },
+	{ NCSI_PKT_CMD_OEM,    -1, ncsi_cmd_handler_oem     },
 	{ NCSI_PKT_CMD_PLDM,   0, NULL                     },
 	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default }
 };
@@ -317,11 +351,20 @@ int ncsi_xmit_cmd(struct ncsi_cmd_arg *nca)
 	}
 
 	/* Get packet payload length and allocate the request */
-	nca->payload = nch->payload;
+	if (nch->payload >= 0)
+		nca->payload = nch->payload;
+
 	nr = ncsi_alloc_command(nca);
 	if (!nr)
 		return -ENOMEM;
 
+	/* track netlink information */
+	if (nca->req_flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
+		nr->snd_seq = nca->info->snd_seq;
+		nr->snd_portid = nca->info->snd_portid;
+		nr->nlhdr = *nca->info->nlhdr;
+	}
+
 	/* Prepare the packet */
 	nca->id = nr->id;
 	ret = nch->handler(nr->cmd, nca);
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 0912847..29f33a1 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -19,6 +19,7 @@
 #include <net/addrconf.h>
 #include <net/ipv6.h>
 #include <net/if_inet6.h>
+#include <net/genetlink.h>
 
 #include "internal.h"
 #include "ncsi-pkt.h"
@@ -406,8 +407,13 @@ static void ncsi_request_timeout(struct timer_list *t)
 {
 	struct ncsi_request *nr = from_timer(nr, t, timer);
 	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct ncsi_package *np;
+	struct ncsi_channel *nc;
+	struct ncsi_cmd_pkt *cmd;
 	unsigned long flags;
 
+	netdev_dbg(ndp->ndev.dev, "NCSI: %s\n", __func__);
+
 	/* If the request already had associated response,
 	 * let the response handler to release it.
 	 */
@@ -415,10 +421,26 @@ static void ncsi_request_timeout(struct timer_list *t)
 	nr->enabled = false;
 	if (nr->rsp || !nr->cmd) {
 		spin_unlock_irqrestore(&ndp->lock, flags);
+
+		netdev_dbg(ndp->ndev.dev,
+			   "NCSI: %s - early return\n", __func__);
+
 		return;
 	}
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
+	if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
+		if (nr->cmd) {
+			/* Find the package */
+			cmd = (struct ncsi_cmd_pkt *)
+			      skb_network_header(nr->cmd);
+			ncsi_find_package_and_channel(ndp,
+						      cmd->cmd.common.channel,
+						      &np, &nc);
+			ncsi_send_netlink_timeout(nr, np, nc);
+		}
+	}
+
 	/* Release the request */
 	ncsi_free_request(nr);
 }
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index 45f33d6..ce57675 100644
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
@@ -366,6 +368,203 @@ static int ncsi_clear_interface_nl(struct sk_buff *msg, struct genl_info *info)
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
+	void *head;
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
+		netdev_info(ndp->ndev.dev, "NCSI: no OEM command to send %u\n",
+			    package_id);
+		ret = -EINVAL;
+		goto out_netlink;
+	} else {
+		head = nla_data(info->attrs[NCSI_ATTR_DATA]);
+		data = (unsigned char *)head;
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
+	nca.data = data;
+
+	ret = ncsi_xmit_cmd(&nca);
+out_netlink:
+	if (ret != 0) {
+		netdev_err(ndp->ndev.dev,
+			   "Error %d sending OEM command\n", ret);
+		ncsi_send_netlink_err(ndp->ndev.dev,
+				      info->snd_seq,
+				      info->snd_portid,
+				      info->nlhdr,
+				      ret);
+	}
+out:
+	return ret;
+}
+
+int ncsi_send_netlink_rsp(struct ncsi_request *nr,
+			  struct ncsi_package *np,
+			  struct ncsi_channel *nc)
+{
+	struct sk_buff *skb;
+	struct net *net;
+	void *hdr;
+	int rc;
+
+	netdev_dbg(nr->ndp->ndev.dev, "NCSI: %s\n", __func__);
+
+	net = dev_net(nr->rsp->dev);
+
+	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(skb, nr->snd_portid, nr->snd_seq,
+			  &ncsi_genl_family, 0, NCSI_CMD_SEND_CMD);
+	if (!hdr) {
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
+
+	nla_put_u32(skb, NCSI_ATTR_IFINDEX, nr->rsp->dev->ifindex);
+	if (np)
+		nla_put_u32(skb, NCSI_ATTR_PACKAGE_ID, np->id);
+	if (nc)
+		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, nc->id);
+	else
+		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, NCSI_RESERVED_CHANNEL);
+
+	rc = nla_put(skb, NCSI_ATTR_DATA, nr->rsp->len, (void *)nr->rsp->data);
+	if (rc)
+		goto err;
+
+	genlmsg_end(skb, hdr);
+	return genlmsg_unicast(net, skb, nr->snd_portid);
+
+err:
+	kfree_skb(skb);
+	return rc;
+}
+
+int ncsi_send_netlink_timeout(struct ncsi_request *nr,
+			      struct ncsi_package *np,
+			      struct ncsi_channel *nc)
+{
+	struct sk_buff *skb;
+	struct net *net;
+	void *hdr;
+
+	netdev_dbg(nr->ndp->ndev.dev, "NCSI: %s\n", __func__);
+
+	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(skb, nr->snd_portid, nr->snd_seq,
+			  &ncsi_genl_family, 0, NCSI_CMD_SEND_CMD);
+	if (!hdr) {
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
+
+	net = dev_net(nr->cmd->dev);
+
+	nla_put_u32(skb, NCSI_ATTR_IFINDEX, nr->cmd->dev->ifindex);
+
+	if (np)
+		nla_put_u32(skb, NCSI_ATTR_PACKAGE_ID, np->id);
+	else
+		nla_put_u32(skb, NCSI_ATTR_PACKAGE_ID,
+			    NCSI_PACKAGE_INDEX((((struct ncsi_pkt_hdr *)
+						 nr->cmd->data)->channel)));
+
+	if (nc)
+		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, nc->id);
+	else
+		nla_put_u32(skb, NCSI_ATTR_CHANNEL_ID, NCSI_RESERVED_CHANNEL);
+
+	genlmsg_end(skb, hdr);
+	return genlmsg_unicast(net, skb, nr->snd_portid);
+}
+
+int ncsi_send_netlink_err(struct net_device *dev,
+			  u32 snd_seq,
+			  u32 snd_portid,
+			  struct nlmsghdr *nlhdr,
+			  int err)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	struct nlmsgerr *nle;
+	struct net *net;
+
+	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	net = dev_net(dev);
+
+	nlh = nlmsg_put(skb, snd_portid, snd_seq,
+			NLMSG_ERROR, sizeof(*nle), 0);
+	nle = (struct nlmsgerr *)nlmsg_data(nlh);
+	nle->error = err;
+	memcpy(&nle->msg, nlhdr, sizeof(*nlh));
+
+	nlmsg_end(skb, nlh);
+
+	return nlmsg_unicast(net->genl_sock, skb, snd_portid);
+}
+
 static const struct genl_ops ncsi_ops[] = {
 	{
 		.cmd = NCSI_CMD_PKG_INFO,
@@ -386,6 +585,12 @@ static const struct genl_ops ncsi_ops[] = {
 		.doit = ncsi_clear_interface_nl,
 		.flags = GENL_ADMIN_PERM,
 	},
+	{
+		.cmd = NCSI_CMD_SEND_CMD,
+		.policy = ncsi_genl_policy,
+		.doit = ncsi_send_cmd_nl,
+		.flags = GENL_ADMIN_PERM,
+	},
 };
 
 static struct genl_family ncsi_genl_family __ro_after_init = {
diff --git a/net/ncsi/ncsi-netlink.h b/net/ncsi/ncsi-netlink.h
index 91a5c25..c4a4688 100644
--- a/net/ncsi/ncsi-netlink.h
+++ b/net/ncsi/ncsi-netlink.h
@@ -14,6 +14,18 @@
 
 #include "internal.h"
 
+int ncsi_send_netlink_rsp(struct ncsi_request *nr,
+			  struct ncsi_package *np,
+			  struct ncsi_channel *nc);
+int ncsi_send_netlink_timeout(struct ncsi_request *nr,
+			      struct ncsi_package *np,
+			      struct ncsi_channel *nc);
+int ncsi_send_netlink_err(struct net_device *dev,
+			  u32 snd_seq,
+			  u32 snd_portid,
+			  struct nlmsghdr *nlhdr,
+			  int err);
+
 int ncsi_init_netlink(struct net_device *dev);
 int ncsi_unregister_netlink(struct net_device *dev);
 
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 930c1d3..010970f 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -16,9 +16,11 @@
 #include <net/ncsi.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
+#include <net/genetlink.h>
 
 #include "internal.h"
 #include "ncsi-pkt.h"
+#include "ncsi-netlink.h"
 
 static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 				 unsigned short payload)
@@ -32,15 +34,22 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 	 * before calling this function.
 	 */
 	h = (struct ncsi_rsp_pkt_hdr *)skb_network_header(nr->rsp);
-	if (h->common.revision != NCSI_PKT_REVISION)
+
+	if (h->common.revision != NCSI_PKT_REVISION) {
+		netdev_dbg(nr->ndp->ndev.dev, "NCSI: unsupported header revision\n");
 		return -EINVAL;
-	if (ntohs(h->common.length) != payload)
+	}
+	if (ntohs(h->common.length) != payload) {
+		netdev_dbg(nr->ndp->ndev.dev, "NCSI: payload length mismatched\n");
 		return -EINVAL;
+	}
 
 	/* Check on code and reason */
 	if (ntohs(h->code) != NCSI_PKT_RSP_C_COMPLETED ||
-	    ntohs(h->reason) != NCSI_PKT_RSP_R_NO_ERROR)
-		return -EINVAL;
+	    ntohs(h->reason) != NCSI_PKT_RSP_R_NO_ERROR) {
+		netdev_dbg(nr->ndp->ndev.dev, "NCSI: non zero response/reason code\n");
+		return -EPERM;
+	}
 
 	/* Validate checksum, which might be zeroes if the
 	 * sender doesn't support checksum according to NCSI
@@ -52,8 +61,11 @@ static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 
 	checksum = ncsi_calculate_checksum((unsigned char *)h,
 					   sizeof(*h) + payload - 4);
-	if (*pchecksum != htonl(checksum))
+
+	if (*pchecksum != htonl(checksum)) {
+		netdev_dbg(nr->ndp->ndev.dev, "NCSI: checksum mismatched\n");
 		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -900,6 +912,31 @@ static int ncsi_rsp_handler_gpuuid(struct ncsi_request *nr)
 	return 0;
 }
 
+static int ncsi_rsp_handler_oem(struct ncsi_request *nr)
+{
+	return 0;
+}
+
+static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
+{
+	struct ncsi_rsp_pkt *rsp;
+	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct ncsi_package *np;
+	struct ncsi_channel *nc;
+	int ret;
+
+	/* Find the package */
+	rsp = (struct ncsi_rsp_pkt *)skb_network_header(nr->rsp);
+	ncsi_find_package_and_channel(ndp, rsp->rsp.common.channel,
+				      &np, &nc);
+	if (!np)
+		return -ENODEV;
+
+	ret = ncsi_send_netlink_rsp(nr, np, nc);
+
+	return ret;
+}
+
 static struct ncsi_rsp_handler {
 	unsigned char	type;
 	int             payload;
@@ -932,7 +969,7 @@ static struct ncsi_rsp_handler {
 	{ NCSI_PKT_RSP_GNS,   172, ncsi_rsp_handler_gns     },
 	{ NCSI_PKT_RSP_GNPTS, 172, ncsi_rsp_handler_gnpts   },
 	{ NCSI_PKT_RSP_GPS,     8, ncsi_rsp_handler_gps     },
-	{ NCSI_PKT_RSP_OEM,     0, NULL                     },
+	{ NCSI_PKT_RSP_OEM,    -1, ncsi_rsp_handler_oem     },
 	{ NCSI_PKT_RSP_PLDM,    0, NULL                     },
 	{ NCSI_PKT_RSP_GPUUID, 20, ncsi_rsp_handler_gpuuid  }
 };
@@ -1002,6 +1039,17 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 		netdev_warn(ndp->ndev.dev,
 			    "NCSI: 'bad' packet ignored for type 0x%x\n",
 			    hdr->type);
+
+		if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
+			if (ret == -EPERM)
+				goto out_netlink;
+			else
+				ncsi_send_netlink_err(ndp->ndev.dev,
+						      nr->snd_seq,
+						      nr->snd_portid,
+						      &nr->nlhdr,
+						      ret);
+		}
 		goto out;
 	}
 
@@ -1011,6 +1059,17 @@ int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
 		netdev_err(ndp->ndev.dev,
 			   "NCSI: Handler for packet type 0x%x returned %d\n",
 			   hdr->type, ret);
+
+out_netlink:
+	if (nr->flags == NCSI_REQ_FLAG_NETLINK_DRIVEN) {
+		ret = ncsi_rsp_handler_netlink(nr);
+		if (ret) {
+			netdev_err(ndp->ndev.dev,
+				   "NCSI: Netlink handler for packet type 0x%x returned %d\n",
+				   hdr->type, ret);
+		}
+	}
+
 out:
 	ncsi_free_request(nr);
 	return ret;
-- 
2.9.3

