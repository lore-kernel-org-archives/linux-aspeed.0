From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Mon, 19 Oct 2020 15:39:08 +0800
Subject: [PATCH] net: ftgmac100: Fix missing TX-poll issue
Message-ID: <20201019073908.32262-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The cpu accesses the register and the memory via different bus/path on
aspeed soc.  So we can not guarantee that the tx-poll command
(register access) is always behind the tx descriptor (memory).  In other
words, the HW may start working even the data is not yet ready.  By
adding a dummy read after the last data write, we can ensure the data
are pushed to the memory, then guarantee the processing sequence

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 00024dd41147..9a99a87f29f3 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -804,7 +804,8 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	 * before setting the OWN bit on the first descriptor.
 	 */
 	dma_wmb();
-	first->txdes0 = cpu_to_le32(f_ctl_stat);
+	WRITE_ONCE(first->txdes0, cpu_to_le32(f_ctl_stat));
+	READ_ONCE(first->txdes0);
 
 	/* Update next TX pointer */
 	priv->tx_pointer = pointer;
-- 
2.17.1

