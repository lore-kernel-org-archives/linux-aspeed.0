From: Joel Stanley <joel@jms.id.au>
Date: Thu, 12 Mar 2020 22:44:13 +1030
Subject: [PATCH] soc: aspeed-lpc-ctrl: LPC to AHB mapping on ast2600
Message-ID: <20200312121413.294384-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ast2600 disables the mapping of AHB memory regions by default,
only allowing the LPC window to point to SPI NOR. In order to point the
window to any AHB address, an ast2600 specific bit must be toggled.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index f4ac14c40518..142cb4cc85e7 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -22,6 +22,9 @@
 #define HICR5_ENL2H	BIT(8)
 #define HICR5_ENFWH	BIT(10)
 
+#define HICR6 0x4
+#define SW_FWH2AHB	BIT(17)
+
 #define HICR7 0x8
 #define HICR8 0xc
 
@@ -33,6 +36,7 @@ struct aspeed_lpc_ctrl {
 	resource_size_t		mem_size;
 	u32		pnor_size;
 	u32		pnor_base;
+	bool			fwh2ahb;
 };
 
 static struct aspeed_lpc_ctrl *file_aspeed_lpc_ctrl(struct file *file)
@@ -177,6 +181,16 @@ static long aspeed_lpc_ctrl_ioctl(struct file *file, unsigned int cmd,
 		if (rc)
 			return rc;
 
+		/*
+		 * Switch to FWH2AHB mode, AST2600 only.
+		 *
+		 * The other bits in this register are interrupt status bits
+		 * that are cleared by writing 1. As we don't want to clear
+		 * them, set only the bit of interest.
+		 */
+		if (lpc_ctrl->fwh2ahb)
+			regmap_write(lpc_ctrl->regmap, HICR6, SW_FWH2AHB);
+
 		/*
 		 * Enable LPC FHW cycles. This is required for the host to
 		 * access the regions specified.
@@ -274,6 +288,9 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	if (of_device_is_compatible(dev->of_node, "aspeed,ast2600-lpc-ctrl"))
+		lpc_ctrl->fwh2ahb = true;
+
 	lpc_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_ctrl->miscdev.name = DEVICE_NAME;
 	lpc_ctrl->miscdev.fops = &aspeed_lpc_ctrl_fops;
-- 
2.25.1

