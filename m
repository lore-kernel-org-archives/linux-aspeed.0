From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon,  5 Sep 2022 16:56:33 -0700
Subject: [PATCH net-next 1/2] net: ftgmac100: support fixed link
In-Reply-To: <20220905235634.20957-1-rentao.bupt@gmail.com>
References: <20220905235634.20957-1-rentao.bupt@gmail.com>
Message-ID: <20220905235634.20957-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Support fixed link in ftgmac100 driver. Fixed link is used on several
Meta OpenBMC platforms, such as Elbert (AST2620) and Wedge400 (AST2520).

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 9277d5fb5052..da04beee5865 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1701,10 +1701,14 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
 
 static void ftgmac100_phy_disconnect(struct net_device *netdev)
 {
+	struct ftgmac100 *priv = netdev_priv(netdev);
+
 	if (!netdev->phydev)
 		return;
 
 	phy_disconnect(netdev->phydev);
+	if (of_phy_is_fixed_link(priv->dev->of_node))
+		of_phy_deregister_fixed_link(priv->dev->of_node);
 }
 
 static void ftgmac100_destroy_mdio(struct net_device *netdev)
@@ -1867,6 +1871,26 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			err = -EINVAL;
 			goto err_phy_connect;
 		}
+	} else if (np && of_phy_is_fixed_link(np)) {
+		struct phy_device *phy;
+
+		err = of_phy_register_fixed_link(np);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to register fixed PHY\n");
+			goto err_phy_connect;
+		}
+
+		phy = of_phy_get_and_connect(priv->netdev, np,
+					     &ftgmac100_adjust_link);
+		if (!phy) {
+			dev_err(&pdev->dev, "Failed to connect to fixed PHY\n");
+			of_phy_deregister_fixed_link(np);
+			err = -EINVAL;
+			goto err_phy_connect;
+		}
+
+		/* Display what we found */
+		phy_attached_info(phy);
 	} else if (np && of_get_property(np, "phy-handle", NULL)) {
 		struct phy_device *phy;
 
-- 
2.30.2

