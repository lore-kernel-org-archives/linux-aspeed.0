From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Mon, 19 Oct 2020 16:57:15 +0800
Subject: [PATCH 2/4] ftgmac100: Fix missing-poll issue
In-Reply-To: <20201019085717.32413-1-dylan_hung@aspeedtech.com>
References: <20201019085717.32413-1-dylan_hung@aspeedtech.com>
Message-ID: <20201019085717.32413-3-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

the tx-poll command may advance the tx descriptor due the HW design.
By adding a pseudo read and proper memory barrier, we can ensure all the
data are ready before TX poll command.

Fixes: 52c0cae87465 ("ftgmac100: Remove tx descriptor accessors")
Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 7cacbe4aecb7..810bda80f138 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -814,8 +814,8 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	 * before setting the OWN bit on the first descriptor.
 	 */
 	dma_wmb();
-	first->txdes0 = cpu_to_le32(f_ctl_stat);
-
+	WRITE_ONCE(first->txdes0, cpu_to_le32(f_ctl_stat));
+	READ_ONCE(first->txdes0);
 	/* Update next TX pointer */
 	priv->tx_pointer = pointer;
 
-- 
2.17.1

