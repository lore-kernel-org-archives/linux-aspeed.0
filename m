From: Michael Walle <michael@walle.cc>
Date: Wed, 18 Jan 2023 11:01:40 +0100
Subject: [PATCH net-next v2 6/6] net: phy: Remove probe_capabilities
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
Message-ID: <20230116-net-next-remove-probe-capabilities-v2-6-15513b05e1f4@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

Deciding if to probe of PHYs using C45 is now determine by if the bus
provides the C45 read method. This makes probe_capabilities redundant
so remove it.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/adi/adin1110.c               | 1 -
 drivers/net/ethernet/freescale/xgmac_mdio.c       | 1 -
 drivers/net/ethernet/mediatek/mtk_eth_soc.c       | 1 -
 drivers/net/ethernet/microchip/lan743x_main.c     | 2 --
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 3 ---
 drivers/net/mdio/mdio-aspeed.c                    | 1 -
 include/linux/phy.h                               | 8 --------
 7 files changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index 0805f249fff2..25f55756681d 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -523,7 +523,6 @@ static int adin1110_register_mdiobus(struct adin1110_priv *priv,
 	mii_bus->priv = priv;
 	mii_bus->parent = dev;
 	mii_bus->phy_mask = ~((u32)GENMASK(2, 0));
-	mii_bus->probe_capabilities = MDIOBUS_C22;
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
 	ret = devm_mdiobus_register(dev, mii_bus);
diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index 8b5a4cd8ff08..a13b4ba4d6e1 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -397,7 +397,6 @@ static int xgmac_mdio_probe(struct platform_device *pdev)
 	bus->read_c45 = xgmac_mdio_read_c45;
 	bus->write_c45 = xgmac_mdio_write_c45;
 	bus->parent = &pdev->dev;
-	bus->probe_capabilities = MDIOBUS_C22_C45;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res->start);
 
 	priv = bus->priv;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index dc50e0b227a6..d67ec28b2ba3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -808,7 +808,6 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 	eth->mii_bus->write = mtk_mdio_write_c22;
 	eth->mii_bus->read_c45 = mtk_mdio_read_c45;
 	eth->mii_bus->write_c45 = mtk_mdio_write_c45;
-	eth->mii_bus->probe_capabilities = MDIOBUS_C22_C45;
 	eth->mii_bus->priv = eth;
 	eth->mii_bus->parent = eth->dev;
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e205edf477de..86b81df374da 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3279,7 +3279,6 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 			lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "SGMII operation\n");
-			adapter->mdiobus->probe_capabilities = MDIOBUS_C22_C45;
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
@@ -3295,7 +3294,6 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "RGMII operation\n");
 			// Only C22 support when RGMII I/F
-			adapter->mdiobus->probe_capabilities = MDIOBUS_C22;
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->name = "lan743x-mdiobus";
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index d2cb22f49ce5..21aaa2730ac8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -553,9 +553,6 @@ int stmmac_mdio_register(struct net_device *ndev)
 
 	new_bus->name = "stmmac";
 
-	if (priv->plat->has_gmac4)
-		new_bus->probe_capabilities = MDIOBUS_C22_C45;
-
 	if (priv->plat->has_xgmac) {
 		new_bus->read = &stmmac_xgmac2_mdio_read_c22;
 		new_bus->write = &stmmac_xgmac2_mdio_write_c22;
diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index 2f4bbda5e56c..c727103c8b05 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -164,7 +164,6 @@ static int aspeed_mdio_probe(struct platform_device *pdev)
 	bus->write = aspeed_mdio_write_c22;
 	bus->read_c45 = aspeed_mdio_read_c45;
 	bus->write_c45 = aspeed_mdio_write_c45;
-	bus->probe_capabilities = MDIOBUS_C22_C45;
 
 	rc = of_mdiobus_register(bus, pdev->dev.of_node);
 	if (rc) {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fceaac0fb319..fbeba4fee8d4 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -419,14 +419,6 @@ struct mii_bus {
 	/** @reset_gpiod: Reset GPIO descriptor pointer */
 	struct gpio_desc *reset_gpiod;
 
-	/** @probe_capabilities: bus capabilities, used for probing */
-	enum {
-		MDIOBUS_NO_CAP = 0,
-		MDIOBUS_C22,
-		MDIOBUS_C45,
-		MDIOBUS_C22_C45,
-	} probe_capabilities;
-
 	/** @shared_lock: protect access to the shared element */
 	struct mutex shared_lock;
 

-- 
2.30.2
