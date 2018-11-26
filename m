From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 26 Nov 2018 13:49:04 -0800
Subject: [PATCH net-next v2] net/ncsi: Add NCSI Mellanox OEM command
Message-ID: <20181126214905.3703229-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds OEM Mellanox commands and response handling. It also
defines OEM Get MAC Address handler to get and configure the device.

ncsi_oem_gma_handler_mlx: This handler send NCSI mellanox command for
getting mac address.
ncsi_rsp_handler_oem_mlx: This handles response received for all
mellanox OEM commands.
ncsi_rsp_handler_oem_mlx_gma: This handles get mac address response and
set it to device.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 net/ncsi/internal.h    |  5 +++++
 net/ncsi/ncsi-manage.c | 28 +++++++++++++++++++++++++++-
 net/ncsi/ncsi-pkt.h    |  9 +++++++++
 net/ncsi/ncsi-rsp.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 1dae77c54009..7f3eb1360b9b 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -73,10 +73,15 @@ enum {
 #define NCSI_OEM_MFR_BCM_ID             0x113d
 /* Broadcom specific OEM Command */
 #define NCSI_OEM_BCM_CMD_GMA            0x01   /* CMD ID for Get MAC */
+/* Mellanox specific OEM Command */
+#define NCSI_OEM_MLX_CMD_GMA            0x00   /* CMD ID for Get MAC */
+#define NCSI_OEM_MLX_CMD_GMA_PARAM      0x1b   /* Parameter for GMA  */
 /* OEM Command payload lengths*/
 #define NCSI_OEM_BCM_CMD_GMA_LEN        12
+#define NCSI_OEM_MLX_CMD_GMA_LEN        8
 /* Mac address offset in OEM response */
 #define BCM_MAC_ADDR_OFFSET             28
+#define MLX_MAC_ADDR_OFFSET             8
 
 
 struct ncsi_channel_version {
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index bfc43b28c7a6..2c9bcb705460 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -675,12 +675,38 @@ static int ncsi_oem_gma_handler_bcm(struct ncsi_cmd_arg *nca)
 	return ret;
 }
 
+static int ncsi_oem_gma_handler_mlx(struct ncsi_cmd_arg *nca)
+{
+	union {
+		u8 data_u8[NCSI_OEM_MLX_CMD_GMA_LEN];
+		u32 data_u32[NCSI_OEM_MLX_CMD_GMA_LEN / sizeof(u32)];
+	} u;
+	int ret = 0;
+
+	nca->payload = NCSI_OEM_MLX_CMD_GMA_LEN;
+
+	memset(&u, 0, sizeof(u));
+	u.data_u32[0] = ntohl(NCSI_OEM_MFR_MLX_ID);
+	u.data_u8[5] = NCSI_OEM_MLX_CMD_GMA;
+	u.data_u8[6] = NCSI_OEM_MLX_CMD_GMA_PARAM;
+
+	nca->data = u.data_u8;
+
+	ret = ncsi_xmit_cmd(nca);
+	if (ret)
+		netdev_err(nca->ndp->ndev.dev,
+			   "NCSI: Failed to transmit cmd 0x%x during configure\n",
+			   nca->type);
+	return ret;
+}
+
 /* OEM Command handlers initialization */
 static struct ncsi_oem_gma_handler {
 	unsigned int	mfr_id;
 	int		(*handler)(struct ncsi_cmd_arg *nca);
 } ncsi_oem_gma_handlers[] = {
-	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm }
+	{ NCSI_OEM_MFR_BCM_ID, ncsi_oem_gma_handler_bcm },
+	{ NCSI_OEM_MFR_MLX_ID, ncsi_oem_gma_handler_mlx }
 };
 
 static int ncsi_gma_handler(struct ncsi_cmd_arg *nca, unsigned int mf_id)
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index 4d3f06be38bd..2a6d83a596c9 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -165,6 +165,15 @@ struct ncsi_rsp_oem_pkt {
 	unsigned char           data[];      /* Payload data      */
 };
 
+/* Mellanox Response Data */
+struct ncsi_rsp_oem_mlx_pkt {
+	unsigned char           cmd_rev;     /* Command Revision  */
+	unsigned char           cmd;         /* Command ID        */
+	unsigned char           param;       /* Parameter         */
+	unsigned char           optional;    /* Optional data     */
+	unsigned char           data[];      /* Data              */
+};
+
 /* Broadcom Response Data */
 struct ncsi_rsp_oem_bcm_pkt {
 	unsigned char           ver;         /* Payload Version   */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index 77e07ba3f493..ba9a4ba97c64 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -611,6 +611,45 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 	return 0;
 }
 
+/* Response handler for Mellanox command Get Mac Address */
+static int ncsi_rsp_handler_oem_mlx_gma(struct ncsi_request *nr)
+{
+	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct net_device *ndev = ndp->ndev.dev;
+	const struct net_device_ops *ops = ndev->netdev_ops;
+	struct ncsi_rsp_oem_pkt *rsp;
+	struct sockaddr saddr;
+	int ret = 0;
+
+	/* Get the response header */
+	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+
+	saddr.sa_family = ndev->type;
+	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+	memcpy(saddr.sa_data, &rsp->data[MLX_MAC_ADDR_OFFSET], ETH_ALEN);
+	ret = ops->ndo_set_mac_address(ndev, &saddr);
+	if (ret < 0)
+		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
+
+	return ret;
+}
+
+/* Response handler for Mellanox card */
+static int ncsi_rsp_handler_oem_mlx(struct ncsi_request *nr)
+{
+	struct ncsi_rsp_oem_mlx_pkt *mlx;
+	struct ncsi_rsp_oem_pkt *rsp;
+
+	/* Get the response header */
+	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+	mlx = (struct ncsi_rsp_oem_mlx_pkt *)(rsp->data);
+
+	if (mlx->cmd == NCSI_OEM_MLX_CMD_GMA &&
+	    mlx->param == NCSI_OEM_MLX_CMD_GMA_PARAM)
+		return ncsi_rsp_handler_oem_mlx_gma(nr);
+	return 0;
+}
+
 /* Response handler for Broadcom command Get Mac Address */
 static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
 {
@@ -655,7 +694,7 @@ static struct ncsi_rsp_oem_handler {
 	unsigned int	mfr_id;
 	int		(*handler)(struct ncsi_request *nr);
 } ncsi_rsp_oem_handlers[] = {
-	{ NCSI_OEM_MFR_MLX_ID, NULL },
+	{ NCSI_OEM_MFR_MLX_ID, ncsi_rsp_handler_oem_mlx },
 	{ NCSI_OEM_MFR_BCM_ID, ncsi_rsp_handler_oem_bcm }
 };
 
-- 
2.17.1

