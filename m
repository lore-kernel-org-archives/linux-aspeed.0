From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 7 Jan 2020 11:30:33 -0800
Subject: [net-next PATCH] net/ncsi: Send device address as source address
Message-ID: <20200107193034.1322431-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

After receiving device mac address from device, send this as
a source address for further commands instead of broadcast
address.

This will help in multi host NIC cards.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 net/ncsi/ncsi-cmd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
index 0187e65176c0..ba9ae482141b 100644
--- a/net/ncsi/ncsi-cmd.c
+++ b/net/ncsi/ncsi-cmd.c
@@ -369,7 +369,15 @@ int ncsi_xmit_cmd(struct ncsi_cmd_arg *nca)
 	eh = skb_push(nr->cmd, sizeof(*eh));
 	eh->h_proto = htons(ETH_P_NCSI);
 	eth_broadcast_addr(eh->h_dest);
-	eth_broadcast_addr(eh->h_source);
+
+	/* If mac address received from device then use it for
+	 * source address as unicast address else use broadcast
+	 * address as source address
+	 */
+	if (nca->ndp->gma_flag == 1)
+		memcpy(eh->h_source, nca->ndp->ndev.dev->dev_addr, ETH_ALEN);
+	else
+		eth_broadcast_addr(eh->h_source);
 
 	/* Start the timer for the request that might not have
 	 * corresponding response. Given NCSI is an internal
-- 
2.17.1

