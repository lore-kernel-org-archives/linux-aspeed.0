From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:10 +0100
Subject: [PATCH net-next 04/10] net: mdio: aspeed: Separate C22 and C45 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-4-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The aspeed MDIO bus driver can perform both C22 and C45 transfers.
Modify the existing C45 functions to take the devad as a parameter,
and remove the wrappers so there are individual C22 and C45 functions. Add
the C45 functions to the new API calls.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/mdio/mdio-aspeed.c | 47 +++++++++++-------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index 944d005d2bd1..2f4bbda5e56c 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -104,61 +104,36 @@ static int aspeed_mdio_write_c22(struct mii_bus *bus, int addr, int regnum,
 			      addr, regnum, val);
 }
 
-static int aspeed_mdio_read_c45(struct mii_bus *bus, int addr, int regnum)
+static int aspeed_mdio_read_c45(struct mii_bus *bus, int addr, int devad,
+				int regnum)
 {
-	u8 c45_dev = (regnum >> 16) & 0x1F;
-	u16 c45_addr = regnum & 0xFFFF;
 	int rc;
 
 	rc = aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C45, MDIO_C45_OP_ADDR,
-			    addr, c45_dev, c45_addr);
+			    addr, devad, regnum);
 	if (rc < 0)
 		return rc;
 
 	rc = aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C45, MDIO_C45_OP_READ,
-			    addr, c45_dev, 0);
+			    addr, devad, 0);
 	if (rc < 0)
 		return rc;
 
 	return aspeed_mdio_get_data(bus);
 }
 
-static int aspeed_mdio_write_c45(struct mii_bus *bus, int addr, int regnum,
-				 u16 val)
+static int aspeed_mdio_write_c45(struct mii_bus *bus, int addr, int devad,
+				 int regnum, u16 val)
 {
-	u8 c45_dev = (regnum >> 16) & 0x1F;
-	u16 c45_addr = regnum & 0xFFFF;
 	int rc;
 
 	rc = aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C45, MDIO_C45_OP_ADDR,
-			    addr, c45_dev, c45_addr);
+			    addr, devad, regnum);
 	if (rc < 0)
 		return rc;
 
 	return aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C45, MDIO_C45_OP_WRITE,
-			      addr, c45_dev, val);
-}
-
-static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
-{
-	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d\n", __func__, addr,
-		regnum);
-
-	if (regnum & MII_ADDR_C45)
-		return aspeed_mdio_read_c45(bus, addr, regnum);
-
-	return aspeed_mdio_read_c22(bus, addr, regnum);
-}
-
-static int aspeed_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
-{
-	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d, val: 0x%x\n",
-		__func__, addr, regnum, val);
-
-	if (regnum & MII_ADDR_C45)
-		return aspeed_mdio_write_c45(bus, addr, regnum, val);
-
-	return aspeed_mdio_write_c22(bus, addr, regnum, val);
+			      addr, devad, val);
 }
 
 static int aspeed_mdio_probe(struct platform_device *pdev)
@@ -185,8 +160,10 @@ static int aspeed_mdio_probe(struct platform_device *pdev)
 	bus->name = DRV_NAME;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s%d", pdev->name, pdev->id);
 	bus->parent = &pdev->dev;
-	bus->read = aspeed_mdio_read;
-	bus->write = aspeed_mdio_write;
+	bus->read = aspeed_mdio_read_c22;
+	bus->write = aspeed_mdio_write_c22;
+	bus->read_c45 = aspeed_mdio_read_c45;
+	bus->write_c45 = aspeed_mdio_write_c45;
 	bus->probe_capabilities = MDIOBUS_C22_C45;
 
 	rc = of_mdiobus_register(bus, pdev->dev.of_node);

-- 
2.30.2
