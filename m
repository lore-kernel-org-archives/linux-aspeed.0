From: Potin Lai <potin.lai@quantatw.com>
Date: Wed,  6 Apr 2022 09:20:02 +0800
Subject: [PATCH v2 3/3] net: mdio: aspeed: Add c45 support
In-Reply-To: <20220406012002.15128-1-potin.lai@quantatw.com>
References: <20220406012002.15128-1-potin.lai@quantatw.com>
Message-ID: <20220406012002.15128-4-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add Clause 45 support for Aspeed mdio driver.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/net/mdio/mdio-aspeed.c | 35 ++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index 5becddb56117..4236ba78aa65 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -21,6 +21,10 @@
 #define   ASPEED_MDIO_CTRL_OP		GENMASK(27, 26)
 #define     MDIO_C22_OP_WRITE		0b01
 #define     MDIO_C22_OP_READ		0b10
+#define     MDIO_C45_OP_ADDR		0b00
+#define     MDIO_C45_OP_WRITE		0b01
+#define     MDIO_C45_OP_PREAD		0b10
+#define     MDIO_C45_OP_READ		0b11
 #define   ASPEED_MDIO_CTRL_PHYAD	GENMASK(25, 21)
 #define   ASPEED_MDIO_CTRL_REGAD	GENMASK(20, 16)
 #define   ASPEED_MDIO_CTRL_MIIWDATA	GENMASK(15, 0)
@@ -100,15 +104,37 @@ static int aspeed_mdio_write_c22(struct mii_bus *bus, int addr, int regnum,
 
 static int aspeed_mdio_read_c45(struct mii_bus *bus, int addr, int regnum)
 {
-	/* TODO: add c45 support */
-	return -EOPNOTSUPP;
+	int rc;
+	u8 c45_dev = (regnum >> 16) & 0x1F;
+	u16 c45_addr = regnum & 0xFFFF;
+
+	rc = aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C45, MDIO_C45_OP_ADDR,
+			    addr, c45_dev, c45_addr);
+	if (rc < 0)
+		return rc;
+
+	rc = aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C45, MDIO_C45_OP_READ,
+			    addr, c45_dev, 0);
+	if (rc < 0)
+		return rc;
+
+	return aspeed_mdio_get_data(bus);
 }
 
 static int aspeed_mdio_write_c45(struct mii_bus *bus, int addr, int regnum,
 				 u16 val)
 {
-	/* TODO: add c45 support */
-	return -EOPNOTSUPP;
+	int rc;
+	u8 c45_dev = (regnum >> 16) & 0x1F;
+	u16 c45_addr = regnum & 0xFFFF;
+
+	rc = aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C45, MDIO_C45_OP_ADDR,
+			    addr, c45_dev, c45_addr);
+	if (rc < 0)
+		return rc;
+
+	return aspeed_mdio_op(bus, ASPEED_MDIO_CTRL_ST_C45, MDIO_C45_OP_WRITE,
+			      addr, c45_dev, val);
 }
 
 static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
@@ -153,6 +179,7 @@ static int aspeed_mdio_probe(struct platform_device *pdev)
 	bus->parent = &pdev->dev;
 	bus->read = aspeed_mdio_read;
 	bus->write = aspeed_mdio_write;
+	bus->probe_capabilities = MDIOBUS_C22_C45;
 
 	rc = of_mdiobus_register(bus, pdev->dev.of_node);
 	if (rc) {
-- 
2.17.1

