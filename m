From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:11 +0100
Subject: [PATCH net-next 05/10] net: mdio: ipq4019: Separate C22 and C45 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-5-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The ipq4019 driver can perform both C22 and C45 transfers.  Create
separate functions for each and register the C45 versions using the
new driver API calls.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/mdio/mdio-ipq4019.c | 154 +++++++++++++++++++++++-----------------
 1 file changed, 90 insertions(+), 64 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 4eba5a91075c..78b93de636f5 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -53,7 +53,8 @@ static int ipq4019_mdio_wait_busy(struct mii_bus *bus)
 				  IPQ4019_MDIO_SLEEP, IPQ4019_MDIO_TIMEOUT);
 }
 
-static int ipq4019_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
+static int ipq4019_mdio_read_c45(struct mii_bus *bus, int mii_id, int mmd,
+				 int reg)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
 	unsigned int data;
@@ -62,61 +63,71 @@ static int ipq4019_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
 	if (ipq4019_mdio_wait_busy(bus))
 		return -ETIMEDOUT;
 
-	/* Clause 45 support */
-	if (regnum & MII_ADDR_C45) {
-		unsigned int mmd = (regnum >> 16) & 0x1F;
-		unsigned int reg = regnum & 0xFFFF;
+	data = readl(priv->membase + MDIO_MODE_REG);
 
-		/* Enter Clause 45 mode */
-		data = readl(priv->membase + MDIO_MODE_REG);
+	data |= MDIO_MODE_C45;
 
-		data |= MDIO_MODE_C45;
+	writel(data, priv->membase + MDIO_MODE_REG);
 
-		writel(data, priv->membase + MDIO_MODE_REG);
+	/* issue the phy address and mmd */
+	writel((mii_id << 8) | mmd, priv->membase + MDIO_ADDR_REG);
 
-		/* issue the phy address and mmd */
-		writel((mii_id << 8) | mmd, priv->membase + MDIO_ADDR_REG);
+	/* issue reg */
+	writel(reg, priv->membase + MDIO_DATA_WRITE_REG);
 
-		/* issue reg */
-		writel(reg, priv->membase + MDIO_DATA_WRITE_REG);
+	cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_ADDR;
 
-		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_ADDR;
-	} else {
-		/* Enter Clause 22 mode */
-		data = readl(priv->membase + MDIO_MODE_REG);
+	/* issue read command */
+	writel(cmd, priv->membase + MDIO_CMD_REG);
 
-		data &= ~MDIO_MODE_C45;
+	/* Wait read complete */
+	if (ipq4019_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
 
-		writel(data, priv->membase + MDIO_MODE_REG);
+	cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_READ;
 
-		/* issue the phy address and reg */
-		writel((mii_id << 8) | regnum, priv->membase + MDIO_ADDR_REG);
+	writel(cmd, priv->membase + MDIO_CMD_REG);
 
-		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_READ;
-	}
+	if (ipq4019_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
 
-	/* issue read command */
-	writel(cmd, priv->membase + MDIO_CMD_REG);
+	/* Read and return data */
+	return readl(priv->membase + MDIO_DATA_READ_REG);
+}
+
+static int ipq4019_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
+{
+	struct ipq4019_mdio_data *priv = bus->priv;
+	unsigned int data;
+	unsigned int cmd;
 
-	/* Wait read complete */
 	if (ipq4019_mdio_wait_busy(bus))
 		return -ETIMEDOUT;
 
-	if (regnum & MII_ADDR_C45) {
-		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_READ;
+	data = readl(priv->membase + MDIO_MODE_REG);
 
-		writel(cmd, priv->membase + MDIO_CMD_REG);
+	data &= ~MDIO_MODE_C45;
 
-		if (ipq4019_mdio_wait_busy(bus))
-			return -ETIMEDOUT;
-	}
+	writel(data, priv->membase + MDIO_MODE_REG);
+
+	/* issue the phy address and reg */
+	writel((mii_id << 8) | regnum, priv->membase + MDIO_ADDR_REG);
+
+	cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_READ;
+
+	/* issue read command */
+	writel(cmd, priv->membase + MDIO_CMD_REG);
+
+	/* Wait read complete */
+	if (ipq4019_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
 
 	/* Read and return data */
 	return readl(priv->membase + MDIO_DATA_READ_REG);
 }
 
-static int ipq4019_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
-							 u16 value)
+static int ipq4019_mdio_write_c45(struct mii_bus *bus, int mii_id, int mmd,
+				  int reg, u16 value)
 {
 	struct ipq4019_mdio_data *priv = bus->priv;
 	unsigned int data;
@@ -125,50 +136,63 @@ static int ipq4019_mdio_write(struct mii_bus *bus, int mii_id, int regnum,
 	if (ipq4019_mdio_wait_busy(bus))
 		return -ETIMEDOUT;
 
-	/* Clause 45 support */
-	if (regnum & MII_ADDR_C45) {
-		unsigned int mmd = (regnum >> 16) & 0x1F;
-		unsigned int reg = regnum & 0xFFFF;
+	data = readl(priv->membase + MDIO_MODE_REG);
 
-		/* Enter Clause 45 mode */
-		data = readl(priv->membase + MDIO_MODE_REG);
+	data |= MDIO_MODE_C45;
 
-		data |= MDIO_MODE_C45;
+	writel(data, priv->membase + MDIO_MODE_REG);
 
-		writel(data, priv->membase + MDIO_MODE_REG);
+	/* issue the phy address and mmd */
+	writel((mii_id << 8) | mmd, priv->membase + MDIO_ADDR_REG);
 
-		/* issue the phy address and mmd */
-		writel((mii_id << 8) | mmd, priv->membase + MDIO_ADDR_REG);
+	/* issue reg */
+	writel(reg, priv->membase + MDIO_DATA_WRITE_REG);
 
-		/* issue reg */
-		writel(reg, priv->membase + MDIO_DATA_WRITE_REG);
+	cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_ADDR;
 
-		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_ADDR;
+	writel(cmd, priv->membase + MDIO_CMD_REG);
 
-		writel(cmd, priv->membase + MDIO_CMD_REG);
+	if (ipq4019_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
 
-		if (ipq4019_mdio_wait_busy(bus))
-			return -ETIMEDOUT;
-	} else {
-		/* Enter Clause 22 mode */
-		data = readl(priv->membase + MDIO_MODE_REG);
+	/* issue write data */
+	writel(value, priv->membase + MDIO_DATA_WRITE_REG);
 
-		data &= ~MDIO_MODE_C45;
+	cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_WRITE;
+	writel(cmd, priv->membase + MDIO_CMD_REG);
 
-		writel(data, priv->membase + MDIO_MODE_REG);
+	/* Wait write complete */
+	if (ipq4019_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
 
-		/* issue the phy address and reg */
-		writel((mii_id << 8) | regnum, priv->membase + MDIO_ADDR_REG);
-	}
+	return 0;
+}
+
+static int ipq4019_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
+				  u16 value)
+{
+	struct ipq4019_mdio_data *priv = bus->priv;
+	unsigned int data;
+	unsigned int cmd;
+
+	if (ipq4019_mdio_wait_busy(bus))
+		return -ETIMEDOUT;
+
+	/* Enter Clause 22 mode */
+	data = readl(priv->membase + MDIO_MODE_REG);
+
+	data &= ~MDIO_MODE_C45;
+
+	writel(data, priv->membase + MDIO_MODE_REG);
+
+	/* issue the phy address and reg */
+	writel((mii_id << 8) | regnum, priv->membase + MDIO_ADDR_REG);
 
 	/* issue write data */
 	writel(value, priv->membase + MDIO_DATA_WRITE_REG);
 
 	/* issue write command */
-	if (regnum & MII_ADDR_C45)
-		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_C45_WRITE;
-	else
-		cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_WRITE;
+	cmd = MDIO_CMD_ACCESS_START | MDIO_CMD_ACCESS_CODE_WRITE;
 
 	writel(cmd, priv->membase + MDIO_CMD_REG);
 
@@ -235,8 +259,10 @@ static int ipq4019_mdio_probe(struct platform_device *pdev)
 		priv->eth_ldo_rdy = devm_ioremap_resource(&pdev->dev, res);
 
 	bus->name = "ipq4019_mdio";
-	bus->read = ipq4019_mdio_read;
-	bus->write = ipq4019_mdio_write;
+	bus->read = ipq4019_mdio_read_c22;
+	bus->write = ipq4019_mdio_write_c22;
+	bus->read_c45 = ipq4019_mdio_read_c45;
+	bus->write_c45 = ipq4019_mdio_write_c45;
 	bus->reset = ipq_mdio_reset;
 	bus->parent = &pdev->dev;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s%d", pdev->name, pdev->id);

-- 
2.30.2
