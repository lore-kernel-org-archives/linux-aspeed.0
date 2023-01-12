From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:13 +0100
Subject: [PATCH net-next 07/10] net: lan743x: Separate C22 and C45 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-7-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The microchip lan743x MDIO bus driver can perform both C22 and C45
transfers in some variants. Create separate functions for each and
register the C45 versions using the new API calls where appropriate.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 106 +++++++++++++-------------
 1 file changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 534840f9a7ca..e205edf477de 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -792,7 +792,7 @@ static int lan743x_mac_mii_wait_till_not_busy(struct lan743x_adapter *adapter)
 				  !(data & MAC_MII_ACC_MII_BUSY_), 0, 1000000);
 }
 
-static int lan743x_mdiobus_read(struct mii_bus *bus, int phy_id, int index)
+static int lan743x_mdiobus_read_c22(struct mii_bus *bus, int phy_id, int index)
 {
 	struct lan743x_adapter *adapter = bus->priv;
 	u32 val, mii_access;
@@ -814,8 +814,8 @@ static int lan743x_mdiobus_read(struct mii_bus *bus, int phy_id, int index)
 	return (int)(val & 0xFFFF);
 }
 
-static int lan743x_mdiobus_write(struct mii_bus *bus,
-				 int phy_id, int index, u16 regval)
+static int lan743x_mdiobus_write_c22(struct mii_bus *bus,
+				     int phy_id, int index, u16 regval)
 {
 	struct lan743x_adapter *adapter = bus->priv;
 	u32 val, mii_access;
@@ -835,12 +835,10 @@ static int lan743x_mdiobus_write(struct mii_bus *bus,
 	return ret;
 }
 
-static u32 lan743x_mac_mmd_access(int id, int index, int op)
+static u32 lan743x_mac_mmd_access(int id, int dev_addr, int op)
 {
-	u16 dev_addr;
 	u32 ret;
 
-	dev_addr = (index >> 16) & 0x1f;
 	ret = (id << MAC_MII_ACC_PHY_ADDR_SHIFT_) &
 		MAC_MII_ACC_PHY_ADDR_MASK_;
 	ret |= (dev_addr << MAC_MII_ACC_MIIMMD_SHIFT_) &
@@ -858,7 +856,8 @@ static u32 lan743x_mac_mmd_access(int id, int index, int op)
 	return ret;
 }
 
-static int lan743x_mdiobus_c45_read(struct mii_bus *bus, int phy_id, int index)
+static int lan743x_mdiobus_read_c45(struct mii_bus *bus, int phy_id,
+				    int dev_addr, int index)
 {
 	struct lan743x_adapter *adapter = bus->priv;
 	u32 mmd_access;
@@ -868,32 +867,30 @@ static int lan743x_mdiobus_c45_read(struct mii_bus *bus, int phy_id, int index)
 	ret = lan743x_mac_mii_wait_till_not_busy(adapter);
 	if (ret < 0)
 		return ret;
-	if (index & MII_ADDR_C45) {
-		/* Load Register Address */
-		lan743x_csr_write(adapter, MAC_MII_DATA, (u32)(index & 0xffff));
-		mmd_access = lan743x_mac_mmd_access(phy_id, index,
-						    MMD_ACCESS_ADDRESS);
-		lan743x_csr_write(adapter, MAC_MII_ACC, mmd_access);
-		ret = lan743x_mac_mii_wait_till_not_busy(adapter);
-		if (ret < 0)
-			return ret;
-		/* Read Data */
-		mmd_access = lan743x_mac_mmd_access(phy_id, index,
-						    MMD_ACCESS_READ);
-		lan743x_csr_write(adapter, MAC_MII_ACC, mmd_access);
-		ret = lan743x_mac_mii_wait_till_not_busy(adapter);
-		if (ret < 0)
-			return ret;
-		ret = lan743x_csr_read(adapter, MAC_MII_DATA);
-		return (int)(ret & 0xFFFF);
-	}
 
-	ret = lan743x_mdiobus_read(bus, phy_id, index);
-	return ret;
+	/* Load Register Address */
+	lan743x_csr_write(adapter, MAC_MII_DATA, index);
+	mmd_access = lan743x_mac_mmd_access(phy_id, dev_addr,
+					    MMD_ACCESS_ADDRESS);
+	lan743x_csr_write(adapter, MAC_MII_ACC, mmd_access);
+	ret = lan743x_mac_mii_wait_till_not_busy(adapter);
+	if (ret < 0)
+		return ret;
+
+	/* Read Data */
+	mmd_access = lan743x_mac_mmd_access(phy_id, dev_addr,
+					    MMD_ACCESS_READ);
+	lan743x_csr_write(adapter, MAC_MII_ACC, mmd_access);
+	ret = lan743x_mac_mii_wait_till_not_busy(adapter);
+	if (ret < 0)
+		return ret;
+
+	ret = lan743x_csr_read(adapter, MAC_MII_DATA);
+	return (int)(ret & 0xFFFF);
 }
 
-static int lan743x_mdiobus_c45_write(struct mii_bus *bus,
-				     int phy_id, int index, u16 regval)
+static int lan743x_mdiobus_write_c45(struct mii_bus *bus, int phy_id,
+				     int dev_addr, int index, u16 regval)
 {
 	struct lan743x_adapter *adapter = bus->priv;
 	u32 mmd_access;
@@ -903,26 +900,23 @@ static int lan743x_mdiobus_c45_write(struct mii_bus *bus,
 	ret = lan743x_mac_mii_wait_till_not_busy(adapter);
 	if (ret < 0)
 		return ret;
-	if (index & MII_ADDR_C45) {
-		/* Load Register Address */
-		lan743x_csr_write(adapter, MAC_MII_DATA, (u32)(index & 0xffff));
-		mmd_access = lan743x_mac_mmd_access(phy_id, index,
-						    MMD_ACCESS_ADDRESS);
-		lan743x_csr_write(adapter, MAC_MII_ACC, mmd_access);
-		ret = lan743x_mac_mii_wait_till_not_busy(adapter);
-		if (ret < 0)
-			return ret;
-		/* Write Data */
-		lan743x_csr_write(adapter, MAC_MII_DATA, (u32)regval);
-		mmd_access = lan743x_mac_mmd_access(phy_id, index,
-						    MMD_ACCESS_WRITE);
-		lan743x_csr_write(adapter, MAC_MII_ACC, mmd_access);
-		ret = lan743x_mac_mii_wait_till_not_busy(adapter);
-	} else {
-		ret = lan743x_mdiobus_write(bus, phy_id, index, regval);
-	}
 
-	return ret;
+	/* Load Register Address */
+	lan743x_csr_write(adapter, MAC_MII_DATA, (u32)index);
+	mmd_access = lan743x_mac_mmd_access(phy_id, dev_addr,
+					    MMD_ACCESS_ADDRESS);
+	lan743x_csr_write(adapter, MAC_MII_ACC, mmd_access);
+	ret = lan743x_mac_mii_wait_till_not_busy(adapter);
+	if (ret < 0)
+		return ret;
+
+	/* Write Data */
+	lan743x_csr_write(adapter, MAC_MII_DATA, (u32)regval);
+	mmd_access = lan743x_mac_mmd_access(phy_id, dev_addr,
+					    MMD_ACCESS_WRITE);
+	lan743x_csr_write(adapter, MAC_MII_ACC, mmd_access);
+
+	return lan743x_mac_mii_wait_till_not_busy(adapter);
 }
 
 static int lan743x_sgmii_wait_till_not_busy(struct lan743x_adapter *adapter)
@@ -3286,8 +3280,10 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "SGMII operation\n");
 			adapter->mdiobus->probe_capabilities = MDIOBUS_C22_C45;
-			adapter->mdiobus->read = lan743x_mdiobus_c45_read;
-			adapter->mdiobus->write = lan743x_mdiobus_c45_write;
+			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
+			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
+			adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
+			adapter->mdiobus->write_c45 = lan743x_mdiobus_write_c45;
 			adapter->mdiobus->name = "lan743x-mdiobus-c45";
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "lan743x-mdiobus-c45\n");
@@ -3300,15 +3296,15 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 				  "RGMII operation\n");
 			// Only C22 support when RGMII I/F
 			adapter->mdiobus->probe_capabilities = MDIOBUS_C22;
-			adapter->mdiobus->read = lan743x_mdiobus_read;
-			adapter->mdiobus->write = lan743x_mdiobus_write;
+			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
+			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 			adapter->mdiobus->name = "lan743x-mdiobus";
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "lan743x-mdiobus\n");
 		}
 	} else {
-		adapter->mdiobus->read = lan743x_mdiobus_read;
-		adapter->mdiobus->write = lan743x_mdiobus_write;
+		adapter->mdiobus->read = lan743x_mdiobus_read_c22;
+		adapter->mdiobus->write = lan743x_mdiobus_write_c22;
 		adapter->mdiobus->name = "lan743x-mdiobus";
 		netif_dbg(adapter, drv, adapter->netdev, "lan743x-mdiobus\n");
 	}

-- 
2.30.2
