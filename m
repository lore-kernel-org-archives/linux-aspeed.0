From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:15 +0100
Subject: [PATCH net-next 09/10] net: stmmac: Separate C22 and C45 transactions
 for xgmac
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-9-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The stmmac MDIO bus driver in variant gmac4 can perform both C22 and
C45 transfers. Create separate functions for each and register the
C45 versions using the new API calls where appropriate.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 200 +++++++++++++++-------
 1 file changed, 138 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 4836a40df1af..d2cb22f49ce5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -234,8 +234,29 @@ static int stmmac_xgmac2_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 					phydata);
 }
 
+static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
+{
+	unsigned int mii_address = priv->hw->mii.addr;
+	unsigned int mii_data = priv->hw->mii.data;
+	u32 v;
+
+	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
+			       100, 10000))
+		return -EBUSY;
+
+	writel(data, priv->ioaddr + mii_data);
+	writel(value, priv->ioaddr + mii_address);
+
+	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
+			       100, 10000))
+		return -EBUSY;
+
+	/* Read the data from the MII data register */
+	return readl(priv->ioaddr + mii_data) & MII_DATA_MASK;
+}
+
 /**
- * stmmac_mdio_read
+ * stmmac_mdio_read_c22
  * @bus: points to the mii_bus structure
  * @phyaddr: MII addr
  * @phyreg: MII reg
@@ -244,15 +265,12 @@ static int stmmac_xgmac2_mdio_write_c45(struct mii_bus *bus, int phyaddr,
  * accessing the PHY registers.
  * Fortunately, it seems this has no drawback for the 7109 MAC.
  */
-static int stmmac_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
+static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 {
 	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned int mii_address = priv->hw->mii.addr;
-	unsigned int mii_data = priv->hw->mii.data;
 	u32 value = MII_BUSY;
 	int data = 0;
-	u32 v;
 
 	data = pm_runtime_resume_and_get(priv->device);
 	if (data < 0)
@@ -265,60 +283,94 @@ static int stmmac_mdio_read(struct mii_bus *bus, int phyaddr, int phyreg)
 		& priv->hw->mii.clk_csr_mask;
 	if (priv->plat->has_gmac4) {
 		value |= MII_GMAC4_READ;
-		if (phyreg & MII_ADDR_C45) {
-			value |= MII_GMAC4_C45E;
-			value &= ~priv->hw->mii.reg_mask;
-			value |= ((phyreg >> MII_DEVADDR_C45_SHIFT) <<
-			       priv->hw->mii.reg_shift) &
-			       priv->hw->mii.reg_mask;
-
-			data |= (phyreg & MII_REGADDR_C45_MASK) <<
-				MII_GMAC4_REG_ADDR_SHIFT;
-		}
 	}
 
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000)) {
-		data = -EBUSY;
-		goto err_disable_clks;
-	}
+	data = stmmac_mdio_read(priv, data, value);
 
-	writel(data, priv->ioaddr + mii_data);
-	writel(value, priv->ioaddr + mii_address);
+	pm_runtime_put(priv->device);
 
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000)) {
-		data = -EBUSY;
-		goto err_disable_clks;
+	return data;
+}
+
+/**
+ * stmmac_mdio_read_c45
+ * @bus: points to the mii_bus structure
+ * @phyaddr: MII addr
+ * @devad: device address to read
+ * @phyreg: MII reg
+ * Description: it reads data from the MII register from within the phy device.
+ * For the 7111 GMAC, we must set the bit 0 in the MII address register while
+ * accessing the PHY registers.
+ * Fortunately, it seems this has no drawback for the 7109 MAC.
+ */
+static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
+				int phyreg)
+{
+	struct net_device *ndev = bus->priv;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 value = MII_BUSY;
+	int data = 0;
+
+	data = pm_runtime_get_sync(priv->device);
+	if (data < 0) {
+		pm_runtime_put_noidle(priv->device);
+		return data;
 	}
 
-	/* Read the data from the MII data register */
-	data = (int)readl(priv->ioaddr + mii_data) & MII_DATA_MASK;
+	value |= (phyaddr << priv->hw->mii.addr_shift)
+		& priv->hw->mii.addr_mask;
+	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
+	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
+		& priv->hw->mii.clk_csr_mask;
+	value |= MII_GMAC4_READ;
+	value |= MII_GMAC4_C45E;
+	value &= ~priv->hw->mii.reg_mask;
+	value |= (devad << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
+
+	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
+
+	data = stmmac_mdio_read(priv, data, value);
 
-err_disable_clks:
 	pm_runtime_put(priv->device);
 
 	return data;
 }
 
+static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
+{
+	unsigned int mii_address = priv->hw->mii.addr;
+	unsigned int mii_data = priv->hw->mii.data;
+	u32 v;
+
+	/* Wait until any existing MII operation is complete */
+	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
+			       100, 10000))
+		return -EBUSY;
+
+	/* Set the MII address register to write */
+	writel(data, priv->ioaddr + mii_data);
+	writel(value, priv->ioaddr + mii_address);
+
+	/* Wait until any existing MII operation is complete */
+	return readl_poll_timeout(priv->ioaddr + mii_address, v,
+				  !(v & MII_BUSY), 100, 10000);
+}
+
 /**
- * stmmac_mdio_write
+ * stmmac_mdio_write_c22
  * @bus: points to the mii_bus structure
  * @phyaddr: MII addr
  * @phyreg: MII reg
  * @phydata: phy data
  * Description: it writes the data into the MII register from within the device.
  */
-static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
-			     u16 phydata)
+static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
+				 u16 phydata)
 {
 	struct net_device *ndev = bus->priv;
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned int mii_address = priv->hw->mii.addr;
-	unsigned int mii_data = priv->hw->mii.data;
 	int ret, data = phydata;
 	u32 value = MII_BUSY;
-	u32 v;
 
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
@@ -330,38 +382,57 @@ static int stmmac_mdio_write(struct mii_bus *bus, int phyaddr, int phyreg,
 
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
-	if (priv->plat->has_gmac4) {
+	if (priv->plat->has_gmac4)
 		value |= MII_GMAC4_WRITE;
-		if (phyreg & MII_ADDR_C45) {
-			value |= MII_GMAC4_C45E;
-			value &= ~priv->hw->mii.reg_mask;
-			value |= ((phyreg >> MII_DEVADDR_C45_SHIFT) <<
-			       priv->hw->mii.reg_shift) &
-			       priv->hw->mii.reg_mask;
-
-			data |= (phyreg & MII_REGADDR_C45_MASK) <<
-				MII_GMAC4_REG_ADDR_SHIFT;
-		}
-	} else {
+	else
 		value |= MII_WRITE;
-	}
 
-	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000)) {
-		ret = -EBUSY;
-		goto err_disable_clks;
+	ret = stmmac_mdio_write(priv, data, value);
+
+	pm_runtime_put(priv->device);
+
+	return ret;
+}
+
+/**
+ * stmmac_mdio_write_c45
+ * @bus: points to the mii_bus structure
+ * @phyaddr: MII addr
+ * @phyreg: MII reg
+ * @devad: device address to read
+ * @phydata: phy data
+ * Description: it writes the data into the MII register from within the device.
+ */
+static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
+				 int devad, int phyreg, u16 phydata)
+{
+	struct net_device *ndev = bus->priv;
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret, data = phydata;
+	u32 value = MII_BUSY;
+
+	ret = pm_runtime_get_sync(priv->device);
+	if (ret < 0) {
+		pm_runtime_put_noidle(priv->device);
+		return ret;
 	}
 
-	/* Set the MII address register to write */
-	writel(data, priv->ioaddr + mii_data);
-	writel(value, priv->ioaddr + mii_address);
+	value |= (phyaddr << priv->hw->mii.addr_shift)
+		& priv->hw->mii.addr_mask;
+	value |= (phyreg << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
 
-	/* Wait until any existing MII operation is complete */
-	ret = readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-				 100, 10000);
+	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
+		& priv->hw->mii.clk_csr_mask;
+
+	value |= MII_GMAC4_WRITE;
+	value |= MII_GMAC4_C45E;
+	value &= ~priv->hw->mii.reg_mask;
+	value |= (devad << priv->hw->mii.reg_shift) & priv->hw->mii.reg_mask;
+
+	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
+
+	ret = stmmac_mdio_write(priv, data, value);
 
-err_disable_clks:
 	pm_runtime_put(priv->device);
 
 	return ret;
@@ -499,8 +570,13 @@ int stmmac_mdio_register(struct net_device *ndev)
 			dev_err(dev, "Unsupported phy_addr (max=%d)\n",
 					MII_XGMAC_MAX_C22ADDR);
 	} else {
-		new_bus->read = &stmmac_mdio_read;
-		new_bus->write = &stmmac_mdio_write;
+		new_bus->read = &stmmac_mdio_read_c22;
+		new_bus->write = &stmmac_mdio_write_c22;
+		if (priv->plat->has_gmac4) {
+			new_bus->read_c45 = &stmmac_mdio_read_c45;
+			new_bus->write_c45 = &stmmac_mdio_write_c45;
+		}
+
 		max_addr = PHY_MAX_ADDR;
 	}
 

-- 
2.30.2
