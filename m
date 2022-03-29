From: Potin Lai <potin.lai@quantatw.com>
Date: Wed, 30 Mar 2022 00:19:49 +0800
Subject: [PATCH 1/1] net: mdio: aspeed: Add Clause 45 support
Message-ID: <20220329161949.19762-1-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add Clause 45 support for Aspeed mdio driver.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/net/mdio/mdio-aspeed.c | 122 ++++++++++++++++++++++++---------
 1 file changed, 88 insertions(+), 34 deletions(-)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index e2273588c75b..aa2b678b2381 100644
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
@@ -39,34 +43,35 @@ struct aspeed_mdio {
 	void __iomem *base;
 };
 
-static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
+static int aspeed_mdio_ctrl_reg(struct mii_bus *bus, u8 st, u8 op, u8 phyad,
+				u8 regad, u16 data)
 {
 	struct aspeed_mdio *ctx = bus->priv;
 	u32 ctrl;
-	u32 data;
-	int rc;
-
-	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d\n", __func__, addr,
-		regnum);
 
-	/* Just clause 22 for the moment */
-	if (regnum & MII_ADDR_C45)
-		return -EOPNOTSUPP;
+	dev_dbg(&bus->dev, "%s: st: %u op: %u, phyad: %u, regad: %u, data: %u\n",
+		__func__, st, op, phyad, regad, data);
 
 	ctrl = ASPEED_MDIO_CTRL_FIRE
-		| FIELD_PREP(ASPEED_MDIO_CTRL_ST, ASPEED_MDIO_CTRL_ST_C22)
-		| FIELD_PREP(ASPEED_MDIO_CTRL_OP, MDIO_C22_OP_READ)
-		| FIELD_PREP(ASPEED_MDIO_CTRL_PHYAD, addr)
-		| FIELD_PREP(ASPEED_MDIO_CTRL_REGAD, regnum);
+		| FIELD_PREP(ASPEED_MDIO_CTRL_ST, st)
+		| FIELD_PREP(ASPEED_MDIO_CTRL_OP, op)
+		| FIELD_PREP(ASPEED_MDIO_CTRL_PHYAD, phyad)
+		| FIELD_PREP(ASPEED_MDIO_CTRL_REGAD, regad)
+		| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
 
-	rc = readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
+	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
 				!(ctrl & ASPEED_MDIO_CTRL_FIRE),
 				ASPEED_MDIO_INTERVAL_US,
 				ASPEED_MDIO_TIMEOUT_US);
-	if (rc < 0)
-		return rc;
+}
+
+static int aspeed_mdio_read_data_reg(struct mii_bus *bus)
+{
+	struct aspeed_mdio *ctx = bus->priv;
+	int rc;
+	u32 data;
 
 	rc = readl_poll_timeout(ctx->base + ASPEED_MDIO_DATA, data,
 				data & ASPEED_MDIO_DATA_IDLE,
@@ -78,31 +83,80 @@ static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
 	return FIELD_GET(ASPEED_MDIO_DATA_MIIRDATA, data);
 }
 
-static int aspeed_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
+static int aspeed_mdio_c45_read(struct mii_bus *bus, int addr, int regnum)
 {
-	struct aspeed_mdio *ctx = bus->priv;
-	u32 ctrl;
+	int rc;
+	u8 c45_dev = (regnum >> 16) & 0x1F;
+	u16 c45_addr = regnum & 0xFFFF;
 
-	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d, val: 0x%x\n",
-		__func__, addr, regnum, val);
+	rc = aspeed_mdio_ctrl_reg(bus, ASPEED_MDIO_CTRL_ST_C45,
+				  MDIO_C45_OP_ADDR, addr, c45_dev, c45_addr);
+	if (rc < 0)
+		return rc;
+
+	rc = aspeed_mdio_ctrl_reg(bus, ASPEED_MDIO_CTRL_ST_C45,
+				  MDIO_C45_OP_READ, addr, c45_dev, 0);
+	if (rc < 0)
+		return rc;
+
+	return aspeed_mdio_read_data_reg(bus);
+}
+
+static int aspeed_mdio_c22_read(struct mii_bus *bus, int addr, int regnum)
+{
+	int rc;
+
+	rc = aspeed_mdio_ctrl_reg(bus, ASPEED_MDIO_CTRL_ST_C22,
+				  MDIO_C22_OP_READ, addr, regnum, 0);
+	if (rc < 0)
+		return rc;
+
+	return aspeed_mdio_read_data_reg(bus);
+}
+
+static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d\n", __func__, addr,
+		regnum);
 
-	/* Just clause 22 for the moment */
 	if (regnum & MII_ADDR_C45)
-		return -EOPNOTSUPP;
+		return aspeed_mdio_c45_read(bus, addr, regnum);
 
-	ctrl = ASPEED_MDIO_CTRL_FIRE
-		| FIELD_PREP(ASPEED_MDIO_CTRL_ST, ASPEED_MDIO_CTRL_ST_C22)
-		| FIELD_PREP(ASPEED_MDIO_CTRL_OP, MDIO_C22_OP_WRITE)
-		| FIELD_PREP(ASPEED_MDIO_CTRL_PHYAD, addr)
-		| FIELD_PREP(ASPEED_MDIO_CTRL_REGAD, regnum)
-		| FIELD_PREP(ASPEED_MDIO_CTRL_MIIWDATA, val);
+	return aspeed_mdio_c22_read(bus, addr, regnum);
+}
 
-	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
+static int aspeed_mdio_c45_write(struct mii_bus *bus, int addr, int regnum,
+				 u16 val)
+{
+	int rc;
+	u8 c45_dev = (regnum >> 16) & 0x1F;
+	u16 c45_addr = regnum & 0xFFFF;
 
-	return readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
-				  !(ctrl & ASPEED_MDIO_CTRL_FIRE),
-				  ASPEED_MDIO_INTERVAL_US,
-				  ASPEED_MDIO_TIMEOUT_US);
+	rc = aspeed_mdio_ctrl_reg(bus, ASPEED_MDIO_CTRL_ST_C45,
+				  MDIO_C45_OP_ADDR, addr, c45_dev, c45_addr);
+	if (rc < 0)
+		return rc;
+
+	return aspeed_mdio_ctrl_reg(bus, ASPEED_MDIO_CTRL_ST_C45,
+				    MDIO_C45_OP_WRITE, addr, c45_dev, val);
+}
+
+static int aspeed_mdio_c22_write(struct mii_bus *bus, int addr, int regnum,
+				 u16 val)
+{
+	return aspeed_mdio_ctrl_reg(bus, ASPEED_MDIO_CTRL_ST_C22,
+				    MDIO_C22_OP_WRITE, addr, regnum, val);
+}
+
+static int aspeed_mdio_write(struct mii_bus *bus, int addr, int regnum, u16 val)
+{
+	dev_dbg(&bus->dev, "%s: addr: %d, regnum: %d, val: 0x%x\n",
+		__func__, addr, regnum, val);
+
+	if (regnum & MII_ADDR_C45)
+		return aspeed_mdio_c45_write(bus, addr, regnum, val);
+
+	return aspeed_mdio_c22_write(bus, addr, regnum, val);
 }
 
 static int aspeed_mdio_probe(struct platform_device *pdev)
-- 
2.17.1

