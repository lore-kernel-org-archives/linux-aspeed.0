From: Michael Walle <michael@walle.cc>
Date: Mon, 16 Jan 2023 13:55:14 +0100
Subject: [PATCH net-next 2/6] net: mdio: Rework scanning of bus ready for quirks
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
Message-ID: <20230116-net-next-remove-probe-capabilities-v1-2-5aa29738a023@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

Some C22 PHYs do bad things when there are C45 transactions on the
bus. In order to handle this, the bus needs to be scanned first for
C22 at all addresses, and then C45 scanned for all addresses.

The Marvell pxa168 driver scans a specific address on the bus to find
its PHY. This is a C22 only device, so update it to use the c22
helper.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/ethernet/marvell/pxa168_eth.c |   2 +-
 drivers/net/phy/mdio_bus.c                | 123 +++++++++++++++++++++---------
 include/linux/phy.h                       |   2 +-
 3 files changed, 87 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index cf456d62677f..87fff539d39d 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -965,7 +965,7 @@ static int pxa168_init_phy(struct net_device *dev)
 	if (dev->phydev)
 		return 0;
 
-	phy = mdiobus_scan(pep->smi_bus, pep->phy_addr);
+	phy = mdiobus_scan_c22(pep->smi_bus, pep->phy_addr);
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 61c33c6098a1..25a964b98bc6 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -506,38 +506,12 @@ static int mdiobus_create_device(struct mii_bus *bus,
 	return ret;
 }
 
-/**
- * mdiobus_scan - scan a bus for MDIO devices.
- * @bus: mii_bus to scan
- * @addr: address on bus to scan
- *
- * This function scans the MDIO bus, looking for devices which can be
- * identified using a vendor/product ID in registers 2 and 3. Not all
- * MDIO devices have such registers, but PHY devices typically
- * do. Hence this function assumes anything found is a PHY, or can be
- * treated as a PHY. Other MDIO devices, such as switches, will
- * probably not be found during the scan.
- */
-struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr)
+static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 {
 	struct phy_device *phydev = ERR_PTR(-ENODEV);
 	int err;
 
-	switch (bus->probe_capabilities) {
-	case MDIOBUS_NO_CAP:
-	case MDIOBUS_C22:
-		phydev = get_phy_device(bus, addr, false);
-		break;
-	case MDIOBUS_C45:
-		phydev = get_phy_device(bus, addr, true);
-		break;
-	case MDIOBUS_C22_C45:
-		phydev = get_phy_device(bus, addr, false);
-		if (IS_ERR(phydev))
-			phydev = get_phy_device(bus, addr, true);
-		break;
-	}
-
+	phydev = get_phy_device(bus, addr, c45);
 	if (IS_ERR(phydev))
 		return phydev;
 
@@ -554,7 +528,77 @@ struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr)
 
 	return phydev;
 }
-EXPORT_SYMBOL(mdiobus_scan);
+
+/**
+ * mdiobus_scan_c22 - scan one address on a bus for C22 MDIO devices.
+ * @bus: mii_bus to scan
+ * @addr: address on bus to scan
+ *
+ * This function scans one address on the MDIO bus, looking for
+ * devices which can be identified using a vendor/product ID in
+ * registers 2 and 3. Not all MDIO devices have such registers, but
+ * PHY devices typically do. Hence this function assumes anything
+ * found is a PHY, or can be treated as a PHY. Other MDIO devices,
+ * such as switches, will probably not be found during the scan.
+ */
+struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr)
+{
+	return mdiobus_scan(bus, addr, false);
+}
+EXPORT_SYMBOL(mdiobus_scan_c22);
+
+/**
+ * mdiobus_scan_c45 - scan one address on a bus for C45 MDIO devices.
+ * @bus: mii_bus to scan
+ * @addr: address on bus to scan
+ *
+ * This function scans one address on the MDIO bus, looking for
+ * devices which can be identified using a vendor/product ID in
+ * registers 2 and 3. Not all MDIO devices have such registers, but
+ * PHY devices typically do. Hence this function assumes anything
+ * found is a PHY, or can be treated as a PHY. Other MDIO devices,
+ * such as switches, will probably not be found during the scan.
+ */
+static struct phy_device *mdiobus_scan_c45(struct mii_bus *bus, int addr)
+{
+	return mdiobus_scan(bus, addr, true);
+}
+
+static int mdiobus_scan_bus_c22(struct mii_bus *bus)
+{
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		if ((bus->phy_mask & BIT(i)) == 0) {
+			struct phy_device *phydev;
+
+			phydev = mdiobus_scan_c22(bus, i);
+			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
+				return PTR_ERR(phydev);
+		}
+	}
+	return 0;
+}
+
+static int mdiobus_scan_bus_c45(struct mii_bus *bus)
+{
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		if ((bus->phy_mask & BIT(i)) == 0) {
+			struct phy_device *phydev;
+
+			/* Don't scan C45 if we already have a C22 device */
+			if (bus->mdio_map[i])
+				continue;
+
+			phydev = mdiobus_scan_c45(bus, i);
+			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
+				return PTR_ERR(phydev);
+		}
+	}
+	return 0;
+}
 
 /**
  * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
@@ -639,16 +683,19 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error_reset_gpiod;
 	}
 
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		if ((bus->phy_mask & BIT(i)) == 0) {
-			struct phy_device *phydev;
+	if (bus->probe_capabilities == MDIOBUS_NO_CAP ||
+	    bus->probe_capabilities == MDIOBUS_C22 ||
+	    bus->probe_capabilities == MDIOBUS_C22_C45) {
+		err = mdiobus_scan_bus_c22(bus);
+		if (err)
+			goto error;
+	}
 
-			phydev = mdiobus_scan(bus, i);
-			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV)) {
-				err = PTR_ERR(phydev);
-				goto error;
-			}
-		}
+	if (bus->probe_capabilities == MDIOBUS_C45 ||
+	    bus->probe_capabilities == MDIOBUS_C22_C45) {
+		err = mdiobus_scan_bus_c45(bus);
+		if (err)
+			goto error;
 	}
 
 	mdiobus_setup_mdiodev_from_board_info(bus, mdiobus_create_device);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index b3cf1e08e880..fceaac0fb319 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -464,7 +464,7 @@ static inline struct mii_bus *devm_mdiobus_alloc(struct device *dev)
 }
 
 struct mii_bus *mdio_find_bus(const char *mdio_name);
-struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr);
+struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr);
 
 #define PHY_INTERRUPT_DISABLED	false
 #define PHY_INTERRUPT_ENABLED	true

-- 
2.30.2
