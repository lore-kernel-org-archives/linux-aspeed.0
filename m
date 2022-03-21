From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Mon, 21 Mar 2022 15:01:30 +0800
Subject: [PATCH 1/2] net: mdio: add reset deassertion for Aspeed MDIO
In-Reply-To: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
References: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
Message-ID: <20220321070131.23363-2-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add reset deassertion for Aspeed MDIO.  There are 4 MDIO controllers
embedded in Aspeed AST2600 SOC and share one reset control register
SCU50[3]. So devm_reset_control_get_shared is used in this change.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
Cc: stable at vger.kernel.org
---
 drivers/net/mdio/mdio-aspeed.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e2273588c75b..8ac262a12d13 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -3,6 +3,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/delay.h>
+#include <linux/reset.h>
 #include <linux/iopoll.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
@@ -37,6 +38,7 @@
 
 struct aspeed_mdio {
 	void __iomem *base;
+	struct reset_control *reset;
 };
 
 static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
@@ -120,6 +122,12 @@ static int aspeed_mdio_probe(struct platform_device *pdev)
 	if (IS_ERR(ctx->base))
 		return PTR_ERR(ctx->base);
 
+	ctx->reset = devm_reset_control_get_shared(&pdev->dev, NULL);
+	if (IS_ERR(ctx->reset))
+		return PTR_ERR(ctx->reset);
+
+	reset_control_deassert(ctx->reset);
+
 	bus->name = DRV_NAME;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s%d", pdev->name, pdev->id);
 	bus->parent = &pdev->dev;
-- 
2.25.1

