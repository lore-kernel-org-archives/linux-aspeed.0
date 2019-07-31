From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 31 Jul 2019 15:09:58 +0930
Subject: [PATCH net-next v2 3/4] net: ftgmac100: Add support for DT phy-handle
 property
In-Reply-To: <20190731053959.16293-1-andrew@aj.id.au>
References: <20190731053959.16293-1-andrew@aj.id.au>
Message-ID: <20190731053959.16293-4-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

phy-handle is necessary for the AST2600 which separates the MDIO
controllers from the MAC.

I've tried to minimise the intrusion of supporting the AST2600 to the
FTGMAC100 by leaving in place the existing MDIO support for the embedded
MDIO interface. The AST2400 and AST2500 continue to be supported this
way, as it avoids breaking/reworking existing devicetrees.

The AST2600 support by contrast requires the presence of the phy-handle
property in the MAC devicetree node to specify the appropriate PHY to
associate with the MAC. In the event that someone wants to specify the
MDIO bus topology under the MAC node on an AST2400 or AST2500, the
current auto-probe approach is done conditional on the absence of an
"mdio" child node of the MAC.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 37 +++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 030fed65393e..563384b788ab 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -1619,8 +1620,13 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 	if (!priv->mii_bus)
 		return -EIO;
 
-	if (priv->is_aspeed) {
-		/* This driver supports the old MDIO interface */
+	if (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
+	    of_device_is_compatible(np, "aspeed,ast2500-mac")) {
+		/* The AST2600 has a separate MDIO controller */
+
+		/* For the AST2400 and AST2500 this driver only supports the
+		 * old MDIO interface
+		 */
 		reg = ioread32(priv->base + FTGMAC100_OFFSET_REVR);
 		reg &= ~FTGMAC100_REVR_NEW_MDIO_INTERFACE;
 		iowrite32(reg, priv->base + FTGMAC100_OFFSET_REVR);
@@ -1797,7 +1803,8 @@ static int ftgmac100_probe(struct platform_device *pdev)
 
 	np = pdev->dev.of_node;
 	if (np && (of_device_is_compatible(np, "aspeed,ast2400-mac") ||
-		   of_device_is_compatible(np, "aspeed,ast2500-mac"))) {
+		   of_device_is_compatible(np, "aspeed,ast2500-mac") ||
+		   of_device_is_compatible(np, "aspeed,ast2600-mac"))) {
 		priv->rxdes0_edorr_mask = BIT(30);
 		priv->txdes0_edotr_mask = BIT(30);
 		priv->is_aspeed = true;
@@ -1817,7 +1824,29 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		priv->ndev = ncsi_register_dev(netdev, ftgmac100_ncsi_handler);
 		if (!priv->ndev)
 			goto err_ncsi_dev;
-	} else {
+	} else if (np && of_get_property(np, "phy-handle", NULL)) {
+		struct phy_device *phy;
+
+		phy = of_phy_get_and_connect(priv->netdev, np,
+					     &ftgmac100_adjust_link);
+		if (!phy) {
+			dev_err(&pdev->dev, "Failed to connect to phy\n");
+			goto err_setup_mdio;
+		}
+
+		/* Indicate that we support PAUSE frames (see comment in
+		 * Documentation/networking/phy.txt)
+		 */
+		phy_support_asym_pause(phy);
+
+		/* Display what we found */
+		phy_attached_info(phy);
+	} else if (np && !of_get_child_by_name(np, "mdio")) {
+		/* Support legacy ASPEED devicetree descriptions that decribe a
+		 * MAC with an embedded MDIO controller but have no "mdio"
+		 * child node. Automatically scan the MDIO bus for available
+		 * PHYs.
+		 */
 		priv->use_ncsi = false;
 		err = ftgmac100_setup_mdio(netdev);
 		if (err)
-- 
2.20.1

