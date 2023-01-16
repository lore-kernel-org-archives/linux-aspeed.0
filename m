From: Michael Walle <michael@walle.cc>
Date: Mon, 16 Jan 2023 13:55:13 +0100
Subject: [PATCH net-next 1/6] net: mdio: Move mdiobus_scan() within file
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
Message-ID: <20230116-net-next-remove-probe-capabilities-v1-1-5aa29738a023@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

No functional change, just place it earlier in preparation for some
refactoring.

While at it, correct the comment format and one typo.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/phy/mdio_bus.c | 101 ++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 902e1c88ef58..61c33c6098a1 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -506,6 +506,56 @@ static int mdiobus_create_device(struct mii_bus *bus,
 	return ret;
 }
 
+/**
+ * mdiobus_scan - scan a bus for MDIO devices.
+ * @bus: mii_bus to scan
+ * @addr: address on bus to scan
+ *
+ * This function scans the MDIO bus, looking for devices which can be
+ * identified using a vendor/product ID in registers 2 and 3. Not all
+ * MDIO devices have such registers, but PHY devices typically
+ * do. Hence this function assumes anything found is a PHY, or can be
+ * treated as a PHY. Other MDIO devices, such as switches, will
+ * probably not be found during the scan.
+ */
+struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr)
+{
+	struct phy_device *phydev = ERR_PTR(-ENODEV);
+	int err;
+
+	switch (bus->probe_capabilities) {
+	case MDIOBUS_NO_CAP:
+	case MDIOBUS_C22:
+		phydev = get_phy_device(bus, addr, false);
+		break;
+	case MDIOBUS_C45:
+		phydev = get_phy_device(bus, addr, true);
+		break;
+	case MDIOBUS_C22_C45:
+		phydev = get_phy_device(bus, addr, false);
+		if (IS_ERR(phydev))
+			phydev = get_phy_device(bus, addr, true);
+		break;
+	}
+
+	if (IS_ERR(phydev))
+		return phydev;
+
+	/* For DT, see if the auto-probed phy has a corresponding child
+	 * in the bus node, and set the of_node pointer in this case.
+	 */
+	of_mdiobus_link_mdiodev(bus, &phydev->mdio);
+
+	err = phy_device_register(phydev);
+	if (err) {
+		phy_device_free(phydev);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return phydev;
+}
+EXPORT_SYMBOL(mdiobus_scan);
+
 /**
  * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
  * @bus: target mii_bus
@@ -679,57 +729,6 @@ void mdiobus_free(struct mii_bus *bus)
 }
 EXPORT_SYMBOL(mdiobus_free);
 
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
-{
-	struct phy_device *phydev = ERR_PTR(-ENODEV);
-	int err;
-
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
-	if (IS_ERR(phydev))
-		return phydev;
-
-	/*
-	 * For DT, see if the auto-probed phy has a correspoding child
-	 * in the bus node, and set the of_node pointer in this case.
-	 */
-	of_mdiobus_link_mdiodev(bus, &phydev->mdio);
-
-	err = phy_device_register(phydev);
-	if (err) {
-		phy_device_free(phydev);
-		return ERR_PTR(-ENODEV);
-	}
-
-	return phydev;
-}
-EXPORT_SYMBOL(mdiobus_scan);
-
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
 	preempt_disable();

-- 
2.30.2
