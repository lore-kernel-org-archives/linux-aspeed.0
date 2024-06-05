From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:50 -0500
Subject: [PATCH v4 18/40] fsi: aspeed: Don't clear all IRQs during OPB transfers
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-19-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In order to support FSI interrupts, the OPB transfer functions should
not clear all the IRQs pending. Instead, just write the OPB ACK bit
to the IRQ status register. As commented, this register invisibly
masks the interrupt once the interrupt condition is cleared. Fix this
by writing 0 before each OPB transfer.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 04aa5cb9b6fad..f840c7c4a56b9 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -47,6 +47,11 @@ static const u32 fsi_base = 0xa0000000;
 #define OPB_CLK_SYNC	0x3c
 #define OPB_IRQ_CLEAR	0x40
 #define OPB_IRQ_MASK	0x44
+/*
+ * This register does NOT behave in the expected manner. It is expected that writing 1b would clear
+ * the corresponding interrupt condition. However it also invisibly masks the interrupt! Writing 0b
+ * unmasks again.
+ */
 #define OPB_IRQ_STATUS	0x48
 
 #define OPB0_SELECT	0x10
@@ -113,13 +118,14 @@ static int __opb_write(struct fsi_master_aspeed *aspeed, u32 addr,
 	writel_relaxed(transfer_size, base + OPB0_XFER_SIZE);
 	writel_relaxed(addr, base + OPB0_FSI_ADDR);
 	writel_relaxed(val, base + OPB0_FSI_DATA_W);
-	writel_relaxed(0x1, base + OPB_IRQ_CLEAR);
+	writel_relaxed(0, base + OPB_IRQ_STATUS);
 	writel(0x1, base + OPB_TRIGGER);
 
 	ret = readl_poll_timeout(base + OPB_IRQ_STATUS, reg,
 				(reg & OPB0_XFER_ACK_EN) != 0,
 				0, OPB_POLL_TIMEOUT);
 
+	writel(OPB0_XFER_ACK_EN, base + OPB_IRQ_STATUS);
 	status = readl(base + OPB0_STATUS);
 
 	/* Return error when poll timed out */
@@ -165,13 +171,14 @@ static int __opb_read(struct fsi_master_aspeed *aspeed, uint32_t addr,
 	writel_relaxed(CMD_READ, base + OPB0_RW);
 	writel_relaxed(transfer_size, base + OPB0_XFER_SIZE);
 	writel_relaxed(addr, base + OPB0_FSI_ADDR);
-	writel_relaxed(0x1, base + OPB_IRQ_CLEAR);
+	writel_relaxed(0, aspeed->base + OPB_IRQ_STATUS);
 	writel(0x1, base + OPB_TRIGGER);
 
 	ret = readl_poll_timeout(base + OPB_IRQ_STATUS, reg,
 			   (reg & OPB0_XFER_ACK_EN) != 0,
 			   0, OPB_POLL_TIMEOUT);
 
+	writel(OPB0_XFER_ACK_EN, base + OPB_IRQ_STATUS);
 	status = readl(base + OPB0_STATUS);
 
 	result = readl(base + OPB0_FSI_DATA_R);
@@ -530,8 +537,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	}
 
 	writel(0x1, aspeed->base + OPB_CLK_SYNC);
-	writel(OPB1_XFER_ACK_EN | OPB0_XFER_ACK_EN,
-			aspeed->base + OPB_IRQ_MASK);
 
 	writel(opb_retry_counter, aspeed->base + OPB_RETRY_COUNTER);
 
-- 
2.39.3

