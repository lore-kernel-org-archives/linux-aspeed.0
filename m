From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:14 +0100
Subject: [PATCH net-next 08/10] net: stmmac: Separate C22 and C45 transactions
 for xgmac2
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-8-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The stmicro stmmac xgmac2 MDIO bus driver can perform both C22 and C45
transfers. Create separate functions for each and register the C45
versions using the new API calls where appropriate.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 131 +++++++++++++---------
 1 file changed, 81 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 5f177ea80725..4836a40df1af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -45,8 +45,8 @@
 #define MII_XGMAC_PA_SHIFT		16
 #define MII_XGMAC_DA_SHIFT		21
 
-static int stmmac_xgmac2_c45_format(struct stmmac_priv *priv, int phyaddr,
-				    int phyreg, u32 *hw_addr)
+static void stmmac_xgmac2_c45_format(struct stmmac_priv *priv, int phyaddr,
+				     int devad, int phyreg, u32 *hw_addr)
 {
 	u32 tmp;
 
@@ -56,19 +56,14 @@ static int stmmac_xgmac2_c45_format(struct stmmac_priv *priv, int phyaddr,
 	writel(tmp, priv->ioaddr + XGMAC_MDIO_C22P);
 
 	*hw_addr = (phyaddr << MII_XGMAC_PA_SHIFT) | (phyreg & 0xffff);
-	*hw_addr |= (phyreg >> MII_DEVADDR_C45_SHIFT) << MII_XGMAC_DA_SHIFT;
-	return 0;
+	*hw_addr |= devad << MII_XGMAC_DA_SHIFT;
 }
 
-static int stmmac_xgmac2_c22_format(struct stmmac_priv *priv, int phyaddr,
-				    int phyreg, u32 *hw_addr)
+static void stmmac_xgmac2_c22_format(struct stmmac_priv *priv, int phyaddr,
+				     int phyreg, u32 *hw_addr)
 {
 	u32 tmp;
 
-	/* HW does not support C22 addr >= 4 */
-	if (phyaddr > MII_XGMAC_MAX_C22ADDR)
-		return -ENODEV;
-
 	/* Set port as Clause 22 */
 	tmp = readl(priv->ioaddr + XGMAC_MDIO_C22P);
 	tmp &= ~MII_XGMAC_C22P_MASK;
@@ -76,16 +71,14 @@ static int stmmac_xgmac2_c22_format(struct stmmac_priv *priv, int phyaddr,
 	writel(tmp, priv->ioaddr + XGMAC_MDIO_C22P);
 
 	*hw_addr = (phyaddr << MII_XGMAC_PA_SHIFT) | (phyreg & 0x1f);
-	return 0;
 }
 
-static int stmmac_xgmac2_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
+static int stmmac_xgmac2_mdio_read(struct stmmac_priv *priv, u32 addr,
+				   u32 value)
 {
-	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv = netdev_priv(ndev);
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 tmp, addr, value = MII_XGMAC_BUSY;
+	u32 tmp;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -99,20 +92,6 @@ static int stmmac_xgmac2_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
 		goto err_disable_clks;
 	}
 
-	if (phyreg & MII_ADDR_C45) {
-		phyreg &= ~MII_ADDR_C45;
-
-		ret = stmmac_xgmac2_c45_format(priv, phyaddr, phyreg, &addr);
-		if (ret)
-			goto err_disable_clks;
-	} else {
-		ret = stmmac_xgmac2_c22_format(priv, phyaddr, phyreg, &addr);
-		if (ret)
-			goto err_disable_clks;
-
-		value |= MII_XGMAC_SADDR;
-	}
-
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
 	value |= MII_XGMAC_READ;
@@ -144,14 +123,44 @@ static int stmmac_xgmac2_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
 	return ret;
 }
 
-static int stmmac_xgmac2_mdio_write(struct mii_bus *bus, int phyaddr,
-				    int phyreg, u16 phydata)
+static int stmmac_xgmac2_mdio_read_c22(struct mii_bus *bus, int phyaddr,
+				       int phyreg)
 {
 	struct net_device *ndev = bus->priv;
-	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct stmmac_priv *priv;
+	u32 addr;
+
+	priv = netdev_priv(ndev);
+
+	/* HW does not support C22 addr >= 4 */
+	if (phyaddr > MII_XGMAC_MAX_C22ADDR)
+		return -ENODEV;
+
+	stmmac_xgmac2_c22_format(priv, phyaddr, phyreg, &addr);
+
+	return stmmac_xgmac2_mdio_read(priv, addr, MII_XGMAC_BUSY);
+}
+
+static int stmmac_xgmac2_mdio_read_c45(struct mii_bus *bus, int phyaddr,
+				       int devad, int phyreg)
+{
+	struct net_device *ndev = bus->priv;
+	struct stmmac_priv *priv;
+	u32 addr;
+
+	priv = netdev_priv(ndev);
+
+	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
+
+	return stmmac_xgmac2_mdio_read(priv, addr, MII_XGMAC_BUSY);
+}
+
+static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
+				    u32 value, u16 phydata)
+{
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 addr, tmp, value = MII_XGMAC_BUSY;
+	u32 tmp;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -165,20 +174,6 @@ static int stmmac_xgmac2_mdio_write(struct mii_bus *bus, int phyaddr,
 		goto err_disable_clks;
 	}
 
-	if (phyreg & MII_ADDR_C45) {
-		phyreg &= ~MII_ADDR_C45;
-
-		ret = stmmac_xgmac2_c45_format(priv, phyaddr, phyreg, &addr);
-		if (ret)
-			goto err_disable_clks;
-	} else {
-		ret = stmmac_xgmac2_c22_format(priv, phyaddr, phyreg, &addr);
-		if (ret)
-			goto err_disable_clks;
-
-		value |= MII_XGMAC_SADDR;
-	}
-
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
 	value |= phydata;
@@ -205,6 +200,40 @@ static int stmmac_xgmac2_mdio_write(struct mii_bus *bus, int phyaddr,
 	return ret;
 }
 
+static int stmmac_xgmac2_mdio_write_c22(struct mii_bus *bus, int phyaddr,
+					int phyreg, u16 phydata)
+{
+	struct net_device *ndev = bus->priv;
+	struct stmmac_priv *priv;
+	u32 addr;
+
+	priv = netdev_priv(ndev);
+
+	/* HW does not support C22 addr >= 4 */
+	if (phyaddr > MII_XGMAC_MAX_C22ADDR)
+		return -ENODEV;
+
+	stmmac_xgmac2_c22_format(priv, phyaddr, phyreg, &addr);
+
+	return stmmac_xgmac2_mdio_write(priv, addr,
+					MII_XGMAC_BUSY | MII_XGMAC_SADDR, phydata);
+}
+
+static int stmmac_xgmac2_mdio_write_c45(struct mii_bus *bus, int phyaddr,
+					int devad, int phyreg, u16 phydata)
+{
+	struct net_device *ndev = bus->priv;
+	struct stmmac_priv *priv;
+	u32 addr;
+
+	priv = netdev_priv(ndev);
+
+	stmmac_xgmac2_c45_format(priv, phyaddr, devad, phyreg, &addr);
+
+	return stmmac_xgmac2_mdio_write(priv, addr, MII_XGMAC_BUSY,
+					phydata);
+}
+
 /**
  * stmmac_mdio_read
  * @bus: points to the mii_bus structure
@@ -457,8 +486,10 @@ int stmmac_mdio_register(struct net_device *ndev)
 		new_bus->probe_capabilities = MDIOBUS_C22_C45;
 
 	if (priv->plat->has_xgmac) {
-		new_bus->read = &stmmac_xgmac2_mdio_read;
-		new_bus->write = &stmmac_xgmac2_mdio_write;
+		new_bus->read = &stmmac_xgmac2_mdio_read_c22;
+		new_bus->write = &stmmac_xgmac2_mdio_write_c22;
+		new_bus->read_c45 = &stmmac_xgmac2_mdio_read_c45;
+		new_bus->write_c45 = &stmmac_xgmac2_mdio_write_c45;
 
 		/* Right now only C22 phys are supported */
 		max_addr = MII_XGMAC_MAX_C22ADDR + 1;
@@ -490,7 +521,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 
 	/* Looks like we need a dummy read for XGMAC only and C45 PHYs */
 	if (priv->plat->has_xgmac)
-		stmmac_xgmac2_mdio_read(new_bus, 0, MII_ADDR_C45);
+		stmmac_xgmac2_mdio_read_c45(new_bus, 0, 0, 0);
 
 	/* If fixed-link is set, skip PHY scanning */
 	if (!fwnode)

-- 
2.30.2
