From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:09 +0100
Subject: [PATCH net-next 03/10] net: mdio: mux-bcm-iproc: Separate C22 and C45
 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-3-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The MDIO mux broadcom iproc can perform both C22 and C45 transfers.
Create separate functions for each and register the C45 versions using
the new API calls.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
Apparently, in the c45 case, the reg value including the MII_ADDR_C45
bit is written to the hardware. Looks weird, that a "random" software
bit is written to a register. Florian is that correct? Also, with this
patch this flag isn't set anymore.
---
 drivers/net/mdio/mdio-mux-bcm-iproc.c | 54 ++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-bcm-iproc.c b/drivers/net/mdio/mdio-mux-bcm-iproc.c
index 014c0baedbd2..956d54846b62 100644
--- a/drivers/net/mdio/mdio-mux-bcm-iproc.c
+++ b/drivers/net/mdio/mdio-mux-bcm-iproc.c
@@ -98,7 +98,7 @@ static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
  * Return value: Successful Read operation returns read reg values and write
  *      operation returns 0. Failure operation returns negative error code.
  */
-static int start_miim_ops(void __iomem *base,
+static int start_miim_ops(void __iomem *base, bool c45,
 			  u16 phyid, u32 reg, u16 val, u32 op)
 {
 	u32 param;
@@ -112,7 +112,7 @@ static int start_miim_ops(void __iomem *base,
 	param = readl(base + MDIO_PARAM_OFFSET);
 	param |= phyid << MDIO_PARAM_PHY_ID;
 	param |= val << MDIO_PARAM_PHY_DATA;
-	if (reg & MII_ADDR_C45)
+	if (c45)
 		param |= BIT(MDIO_PARAM_C45_SEL);
 
 	writel(param, base + MDIO_PARAM_OFFSET);
@@ -131,28 +131,58 @@ static int start_miim_ops(void __iomem *base,
 	return ret;
 }
 
-static int iproc_mdiomux_read(struct mii_bus *bus, int phyid, int reg)
+static int iproc_mdiomux_read_c22(struct mii_bus *bus, int phyid, int reg)
 {
 	struct iproc_mdiomux_desc *md = bus->priv;
 	int ret;
 
-	ret = start_miim_ops(md->base, phyid, reg, 0, MDIO_CTRL_READ_OP);
+	ret = start_miim_ops(md->base, false, phyid, reg, 0, MDIO_CTRL_READ_OP);
 	if (ret < 0)
-		dev_err(&bus->dev, "mdiomux read operation failed!!!");
+		dev_err(&bus->dev, "mdiomux c22 read operation failed!!!");
 
 	return ret;
 }
 
-static int iproc_mdiomux_write(struct mii_bus *bus,
-			       int phyid, int reg, u16 val)
+static int iproc_mdiomux_read_c45(struct mii_bus *bus, int phyid, int devad,
+				  int reg)
+{
+	struct iproc_mdiomux_desc *md = bus->priv;
+	int ret;
+
+	ret = start_miim_ops(md->base, true, phyid, reg | devad << 16, 0,
+			     MDIO_CTRL_READ_OP);
+	if (ret < 0)
+		dev_err(&bus->dev, "mdiomux read c45 operation failed!!!");
+
+	return ret;
+}
+
+static int iproc_mdiomux_write_c22(struct mii_bus *bus,
+				   int phyid, int reg, u16 val)
+{
+	struct iproc_mdiomux_desc *md = bus->priv;
+	int ret;
+
+	/* Write val at reg offset */
+	ret = start_miim_ops(md->base, false, phyid, reg, val,
+			     MDIO_CTRL_WRITE_OP);
+	if (ret < 0)
+		dev_err(&bus->dev, "mdiomux write c22 operation failed!!!");
+
+	return ret;
+}
+
+static int iproc_mdiomux_write_c45(struct mii_bus *bus,
+				   int phyid, int devad, int reg, u16 val)
 {
 	struct iproc_mdiomux_desc *md = bus->priv;
 	int ret;
 
 	/* Write val at reg offset */
-	ret = start_miim_ops(md->base, phyid, reg, val, MDIO_CTRL_WRITE_OP);
+	ret = start_miim_ops(md->base, true, phyid, reg | devad << 16, val,
+			     MDIO_CTRL_WRITE_OP);
 	if (ret < 0)
-		dev_err(&bus->dev, "mdiomux write operation failed!!!");
+		dev_err(&bus->dev, "mdiomux write c45 operation failed!!!");
 
 	return ret;
 }
@@ -223,8 +253,10 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	bus->name = "iProc MDIO mux bus";
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", pdev->name, pdev->id);
 	bus->parent = &pdev->dev;
-	bus->read = iproc_mdiomux_read;
-	bus->write = iproc_mdiomux_write;
+	bus->read = iproc_mdiomux_read_c22;
+	bus->write = iproc_mdiomux_write_c22;
+	bus->read_c45 = iproc_mdiomux_read_c45;
+	bus->write_c45 = iproc_mdiomux_write_c45;
 
 	bus->phy_mask = ~0;
 	bus->dev.of_node = pdev->dev.of_node;

-- 
2.30.2
