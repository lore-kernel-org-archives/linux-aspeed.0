From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:12 +0100
Subject: [PATCH net-next 06/10] net: ethernet: mtk_eth_soc: Separate C22 and
 C45 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-6-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The mediatek bus driver can perform both C22 and C45 transfers.
Create separate functions for each and register the C45 versions using
the new API calls.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 178 +++++++++++++++++-----------
 1 file changed, 112 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index e3de9a53b2d9..dc50e0b227a6 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -215,8 +215,8 @@ static int mtk_mdio_busy_wait(struct mtk_eth *eth)
 	return -ETIMEDOUT;
 }
 
-static int _mtk_mdio_write(struct mtk_eth *eth, u32 phy_addr, u32 phy_reg,
-			   u32 write_data)
+static int _mtk_mdio_write_c22(struct mtk_eth *eth, u32 phy_addr, u32 phy_reg,
+			       u32 write_data)
 {
 	int ret;
 
@@ -224,35 +224,13 @@ static int _mtk_mdio_write(struct mtk_eth *eth, u32 phy_addr, u32 phy_reg,
 	if (ret < 0)
 		return ret;
 
-	if (phy_reg & MII_ADDR_C45) {
-		mtk_w32(eth, PHY_IAC_ACCESS |
-			     PHY_IAC_START_C45 |
-			     PHY_IAC_CMD_C45_ADDR |
-			     PHY_IAC_REG(mdiobus_c45_devad(phy_reg)) |
-			     PHY_IAC_ADDR(phy_addr) |
-			     PHY_IAC_DATA(mdiobus_c45_regad(phy_reg)),
-			MTK_PHY_IAC);
-
-		ret = mtk_mdio_busy_wait(eth);
-		if (ret < 0)
-			return ret;
-
-		mtk_w32(eth, PHY_IAC_ACCESS |
-			     PHY_IAC_START_C45 |
-			     PHY_IAC_CMD_WRITE |
-			     PHY_IAC_REG(mdiobus_c45_devad(phy_reg)) |
-			     PHY_IAC_ADDR(phy_addr) |
-			     PHY_IAC_DATA(write_data),
-			MTK_PHY_IAC);
-	} else {
-		mtk_w32(eth, PHY_IAC_ACCESS |
-			     PHY_IAC_START_C22 |
-			     PHY_IAC_CMD_WRITE |
-			     PHY_IAC_REG(phy_reg) |
-			     PHY_IAC_ADDR(phy_addr) |
-			     PHY_IAC_DATA(write_data),
-			MTK_PHY_IAC);
-	}
+	mtk_w32(eth, PHY_IAC_ACCESS |
+		PHY_IAC_START_C22 |
+		PHY_IAC_CMD_WRITE |
+		PHY_IAC_REG(phy_reg) |
+		PHY_IAC_ADDR(phy_addr) |
+		PHY_IAC_DATA(write_data),
+		MTK_PHY_IAC);
 
 	ret = mtk_mdio_busy_wait(eth);
 	if (ret < 0)
@@ -261,7 +239,8 @@ static int _mtk_mdio_write(struct mtk_eth *eth, u32 phy_addr, u32 phy_reg,
 	return 0;
 }
 
-static int _mtk_mdio_read(struct mtk_eth *eth, u32 phy_addr, u32 phy_reg)
+static int _mtk_mdio_write_c45(struct mtk_eth *eth, u32 phy_addr,
+			       u32 devad, u32 phy_reg, u32 write_data)
 {
 	int ret;
 
@@ -269,33 +248,82 @@ static int _mtk_mdio_read(struct mtk_eth *eth, u32 phy_addr, u32 phy_reg)
 	if (ret < 0)
 		return ret;
 
-	if (phy_reg & MII_ADDR_C45) {
-		mtk_w32(eth, PHY_IAC_ACCESS |
-			     PHY_IAC_START_C45 |
-			     PHY_IAC_CMD_C45_ADDR |
-			     PHY_IAC_REG(mdiobus_c45_devad(phy_reg)) |
-			     PHY_IAC_ADDR(phy_addr) |
-			     PHY_IAC_DATA(mdiobus_c45_regad(phy_reg)),
-			MTK_PHY_IAC);
-
-		ret = mtk_mdio_busy_wait(eth);
-		if (ret < 0)
-			return ret;
-
-		mtk_w32(eth, PHY_IAC_ACCESS |
-			     PHY_IAC_START_C45 |
-			     PHY_IAC_CMD_C45_READ |
-			     PHY_IAC_REG(mdiobus_c45_devad(phy_reg)) |
-			     PHY_IAC_ADDR(phy_addr),
-			MTK_PHY_IAC);
-	} else {
-		mtk_w32(eth, PHY_IAC_ACCESS |
-			     PHY_IAC_START_C22 |
-			     PHY_IAC_CMD_C22_READ |
-			     PHY_IAC_REG(phy_reg) |
-			     PHY_IAC_ADDR(phy_addr),
-			MTK_PHY_IAC);
-	}
+	mtk_w32(eth, PHY_IAC_ACCESS |
+		PHY_IAC_START_C45 |
+		PHY_IAC_CMD_C45_ADDR |
+		PHY_IAC_REG(devad) |
+		PHY_IAC_ADDR(phy_addr) |
+		PHY_IAC_DATA(phy_reg),
+		MTK_PHY_IAC);
+
+	ret = mtk_mdio_busy_wait(eth);
+	if (ret < 0)
+		return ret;
+
+	mtk_w32(eth, PHY_IAC_ACCESS |
+		PHY_IAC_START_C45 |
+		PHY_IAC_CMD_WRITE |
+		PHY_IAC_REG(devad) |
+		PHY_IAC_ADDR(phy_addr) |
+		PHY_IAC_DATA(write_data),
+		MTK_PHY_IAC);
+
+	ret = mtk_mdio_busy_wait(eth);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int _mtk_mdio_read_c22(struct mtk_eth *eth, u32 phy_addr, u32 phy_reg)
+{
+	int ret;
+
+	ret = mtk_mdio_busy_wait(eth);
+	if (ret < 0)
+		return ret;
+
+	mtk_w32(eth, PHY_IAC_ACCESS |
+		PHY_IAC_START_C22 |
+		PHY_IAC_CMD_C22_READ |
+		PHY_IAC_REG(phy_reg) |
+		PHY_IAC_ADDR(phy_addr),
+		MTK_PHY_IAC);
+
+	ret = mtk_mdio_busy_wait(eth);
+	if (ret < 0)
+		return ret;
+
+	return mtk_r32(eth, MTK_PHY_IAC) & PHY_IAC_DATA_MASK;
+}
+
+static int _mtk_mdio_read_c45(struct mtk_eth *eth, u32 phy_addr,
+			      u32 devad, u32 phy_reg)
+{
+	int ret;
+
+	ret = mtk_mdio_busy_wait(eth);
+	if (ret < 0)
+		return ret;
+
+	mtk_w32(eth, PHY_IAC_ACCESS |
+		PHY_IAC_START_C45 |
+		PHY_IAC_CMD_C45_ADDR |
+		PHY_IAC_REG(devad) |
+		PHY_IAC_ADDR(phy_addr) |
+		PHY_IAC_DATA(phy_reg),
+		MTK_PHY_IAC);
+
+	ret = mtk_mdio_busy_wait(eth);
+	if (ret < 0)
+		return ret;
+
+	mtk_w32(eth, PHY_IAC_ACCESS |
+		PHY_IAC_START_C45 |
+		PHY_IAC_CMD_C45_READ |
+		PHY_IAC_REG(devad) |
+		PHY_IAC_ADDR(phy_addr),
+		MTK_PHY_IAC);
 
 	ret = mtk_mdio_busy_wait(eth);
 	if (ret < 0)
@@ -304,19 +332,35 @@ static int _mtk_mdio_read(struct mtk_eth *eth, u32 phy_addr, u32 phy_reg)
 	return mtk_r32(eth, MTK_PHY_IAC) & PHY_IAC_DATA_MASK;
 }
 
-static int mtk_mdio_write(struct mii_bus *bus, int phy_addr,
-			  int phy_reg, u16 val)
+static int mtk_mdio_write_c22(struct mii_bus *bus, int phy_addr,
+			      int phy_reg, u16 val)
+{
+	struct mtk_eth *eth = bus->priv;
+
+	return _mtk_mdio_write_c22(eth, phy_addr, phy_reg, val);
+}
+
+static int mtk_mdio_write_c45(struct mii_bus *bus, int phy_addr,
+			      int devad, int phy_reg, u16 val)
+{
+	struct mtk_eth *eth = bus->priv;
+
+	return _mtk_mdio_write_c45(eth, phy_addr, devad, phy_reg, val);
+}
+
+static int mtk_mdio_read_c22(struct mii_bus *bus, int phy_addr, int phy_reg)
 {
 	struct mtk_eth *eth = bus->priv;
 
-	return _mtk_mdio_write(eth, phy_addr, phy_reg, val);
+	return _mtk_mdio_read_c22(eth, phy_addr, phy_reg);
 }
 
-static int mtk_mdio_read(struct mii_bus *bus, int phy_addr, int phy_reg)
+static int mtk_mdio_read_c45(struct mii_bus *bus, int phy_addr, int devad,
+			     int phy_reg)
 {
 	struct mtk_eth *eth = bus->priv;
 
-	return _mtk_mdio_read(eth, phy_addr, phy_reg);
+	return _mtk_mdio_read_c45(eth, phy_addr, devad, phy_reg);
 }
 
 static int mt7621_gmac0_rgmii_adjust(struct mtk_eth *eth,
@@ -760,8 +804,10 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 	}
 
 	eth->mii_bus->name = "mdio";
-	eth->mii_bus->read = mtk_mdio_read;
-	eth->mii_bus->write = mtk_mdio_write;
+	eth->mii_bus->read = mtk_mdio_read_c22;
+	eth->mii_bus->write = mtk_mdio_write_c22;
+	eth->mii_bus->read_c45 = mtk_mdio_read_c45;
+	eth->mii_bus->write_c45 = mtk_mdio_write_c45;
 	eth->mii_bus->probe_capabilities = MDIOBUS_C22_C45;
 	eth->mii_bus->priv = eth;
 	eth->mii_bus->parent = eth->dev;

-- 
2.30.2
