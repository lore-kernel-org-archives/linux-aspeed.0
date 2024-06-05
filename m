From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:41 -0500
Subject: [PATCH v4 09/40] fsi: aspeed: Add AST2700 support
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-10-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2700 requires a few bits set differently in the OPB retry
counter register, so add some match data and set the register
accordingly.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f0a19cd451a07..3d15e867237df 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -18,6 +18,10 @@
 
 #include "fsi-master.h"
 
+struct fsi_master_aspeed_data {
+	u32 opb_retry_counter;
+};
+
 struct fsi_master_aspeed {
 	struct fsi_master	master;
 	struct mutex		lock;	/* protect HW access */
@@ -81,6 +85,13 @@ static const u32 fsi_base = 0xa0000000;
 #define XFER_HALFWORD	(BIT(0))
 #define XFER_BYTE	(0)
 
+/* OPB_RETRY_COUNTER */
+#define OPB_RC_FSI_OPB		BIT(19)	/* Access FSI space over OPB, not AHB (AST27xx+) */
+#define OPB_RC_CTRL_OPB		BIT(18)	/* Access controller over OPB, not AHB (AST27xx+) */
+#define OPB_RC_XFER_ACK_EN	BIT(16)	/* Enable OPBx xfer ack bit without mask */
+#define OPB_RC_COUNT		GENMASK(15, 0)	/* Number of retries */
+#define OPB_RC_DEFAULT		0x10
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/fsi_master_aspeed.h>
 
@@ -536,6 +547,8 @@ static int tacoma_cabled_fsi_fixup(struct device *dev)
 
 static int fsi_master_aspeed_probe(struct platform_device *pdev)
 {
+	const struct fsi_master_aspeed_data *md = of_device_get_match_data(&pdev->dev);
+	u32 opb_retry_counter = md ? md->opb_retry_counter : OPB_RC_DEFAULT;
 	struct fsi_master_aspeed *aspeed;
 	int rc, links, reg;
 	__be32 raw;
@@ -579,8 +592,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	writel(OPB1_XFER_ACK_EN | OPB0_XFER_ACK_EN,
 			aspeed->base + OPB_IRQ_MASK);
 
-	/* TODO: determine an appropriate value */
-	writel(0x10, aspeed->base + OPB_RETRY_COUNTER);
+	writel(opb_retry_counter, aspeed->base + OPB_RETRY_COUNTER);
 
 	writel(ctrl_base, aspeed->base + OPB_CTRL_BASE);
 	writel(fsi_base, aspeed->base + OPB_FSI_BASE);
@@ -656,8 +668,23 @@ static int fsi_master_aspeed_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct fsi_master_aspeed_data fsi_master_ast2600_data = {
+	.opb_retry_counter = OPB_RC_DEFAULT,
+};
+
+static const struct fsi_master_aspeed_data fsi_master_ast2700_data = {
+	.opb_retry_counter = OPB_RC_FSI_OPB | OPB_RC_CTRL_OPB | OPB_RC_DEFAULT,
+};
+
 static const struct of_device_id fsi_master_aspeed_match[] = {
-	{ .compatible = "aspeed,ast2600-fsi-master" },
+	{
+		.compatible = "aspeed,ast2600-fsi-master",
+		.data = &fsi_master_ast2600_data,
+	},
+	{
+		.compatible = "aspeed,ast2700-fsi-master",
+		.data = &fsi_master_ast2700_data,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, fsi_master_aspeed_match);
-- 
2.39.3

