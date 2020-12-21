From: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 21 Dec 2020 13:56:23 +0800
Subject: [PATCH v3 5/5] soc: aspeed: Adapt to new LPC device tree layout
In-Reply-To: <20201221055623.31463-1-chiawei_wang@aspeedtech.com>
References: <20201221055623.31463-1-chiawei_wang@aspeedtech.com>
Message-ID: <20201221055623.31463-6-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add check against LPC device v2 compatible string to
ensure that the fixed device tree layout is adopted.
The LPC register offsets are also fixed accordingly.

Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c  | 20 ++++++++++++++------
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 23 +++++++++++++++--------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 439bcd6b8c4a..b04074949240 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -18,15 +18,15 @@
 
 #define DEVICE_NAME	"aspeed-lpc-ctrl"
 
-#define HICR5 0x0
+#define HICR5 0x80
 #define HICR5_ENL2H	BIT(8)
 #define HICR5_ENFWH	BIT(10)
 
-#define HICR6 0x4
+#define HICR6 0x84
 #define SW_FWH2AHB	BIT(17)
 
-#define HICR7 0x8
-#define HICR8 0xc
+#define HICR7 0x88
+#define HICR8 0x8c
 
 struct aspeed_lpc_ctrl {
 	struct miscdevice	miscdev;
@@ -215,6 +215,7 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 	struct device_node *node;
 	struct resource resm;
 	struct device *dev;
+	struct device_node *lpc_np;
 	int rc;
 
 	dev = &pdev->dev;
@@ -270,8 +271,15 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 		}
 	}
 
-	lpc_ctrl->regmap = syscon_node_to_regmap(
-			pdev->dev.parent->of_node);
+	lpc_np = pdev->dev.parent->of_node;
+	if (!of_device_is_compatible(lpc_np, "aspeed,ast2400-lpc-v2") &&
+	    !of_device_is_compatible(lpc_np, "aspeed,ast2500-lpc-v2") &&
+	    !of_device_is_compatible(lpc_np, "aspeed,ast2600-lpc-v2")) {
+		dev_err(dev, "unsupported LPC device binding\n");
+		return -ENODEV;
+	}
+
+	lpc_ctrl->regmap = syscon_node_to_regmap(lpc_np);
 	if (IS_ERR(lpc_ctrl->regmap)) {
 		dev_err(dev, "Couldn't get regmap\n");
 		return -ENODEV;
diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 682ba0eb4eba..63c3d9b8ba61 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -28,26 +28,25 @@
 #define NUM_SNOOP_CHANNELS 2
 #define SNOOP_FIFO_SIZE 2048
 
-#define HICR5	0x0
+#define HICR5	0x80
 #define HICR5_EN_SNP0W		BIT(0)
 #define HICR5_ENINT_SNP0W	BIT(1)
 #define HICR5_EN_SNP1W		BIT(2)
 #define HICR5_ENINT_SNP1W	BIT(3)
-
-#define HICR6	0x4
+#define HICR6	0x84
 #define HICR6_STR_SNP0W		BIT(0)
 #define HICR6_STR_SNP1W		BIT(1)
-#define SNPWADR	0x10
+#define SNPWADR	0x90
 #define SNPWADR_CH0_MASK	GENMASK(15, 0)
 #define SNPWADR_CH0_SHIFT	0
 #define SNPWADR_CH1_MASK	GENMASK(31, 16)
 #define SNPWADR_CH1_SHIFT	16
-#define SNPWDR	0x14
+#define SNPWDR	0x94
 #define SNPWDR_CH0_MASK		GENMASK(7, 0)
 #define SNPWDR_CH0_SHIFT	0
 #define SNPWDR_CH1_MASK		GENMASK(15, 8)
 #define SNPWDR_CH1_SHIFT	8
-#define HICRB	0x80
+#define HICRB	0x100
 #define HICRB_ENSNP0D		BIT(14)
 #define HICRB_ENSNP1D		BIT(15)
 
@@ -258,6 +257,7 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 {
 	struct aspeed_lpc_snoop *lpc_snoop;
 	struct device *dev;
+	struct device_node *lpc_np;
 	u32 port;
 	int rc;
 
@@ -267,8 +267,15 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 	if (!lpc_snoop)
 		return -ENOMEM;
 
-	lpc_snoop->regmap = syscon_node_to_regmap(
-			pdev->dev.parent->of_node);
+	lpc_np = pdev->dev.parent->of_node;
+	if (!of_device_is_compatible(lpc_np, "aspeed,ast2400-lpc-v2") &&
+	    !of_device_is_compatible(lpc_np, "aspeed,ast2500-lpc-v2") &&
+	    !of_device_is_compatible(lpc_np, "aspeed,ast2600-lpc-v2")) {
+		dev_err(dev, "unsupported LPC device binding\n");
+		return -ENODEV;
+	}
+
+	lpc_snoop->regmap = syscon_node_to_regmap(lpc_np);
 	if (IS_ERR(lpc_snoop->regmap)) {
 		dev_err(dev, "Couldn't get regmap\n");
 		return -ENODEV;
-- 
2.17.1

