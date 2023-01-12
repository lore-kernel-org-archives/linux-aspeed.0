From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:16 +0100
Subject: [PATCH net-next 10/10] enetc: Separate C22 and C45 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-10-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The enetc MDIO bus driver can perform both C22 and C45 transfers.
Create separate functions for each and register the C45 versions using
the new API calls where appropriate.

This driver is shared with the Felix DSA switch, so update that at the
same time.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c             |   6 +-
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c  | 119 +++++++++++++++------
 .../net/ethernet/freescale/enetc/enetc_pci_mdio.c  |   6 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  12 ++-
 include/linux/fsl/enetc_mdio.h                     |  21 +++-
 5 files changed, 121 insertions(+), 43 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 01ac70fd7ddf..cbcc457499f3 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -954,8 +954,10 @@ static int vsc9959_mdio_bus_alloc(struct ocelot *ocelot)
 		return -ENOMEM;
 
 	bus->name = "VSC9959 internal MDIO bus";
-	bus->read = enetc_mdio_read;
-	bus->write = enetc_mdio_write;
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
 	bus->parent = dev;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = hw;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
index 1c8f5cc6dec4..998aaa394e9c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
@@ -55,7 +55,8 @@ static int enetc_mdio_wait_complete(struct enetc_mdio_priv *mdio_priv)
 				  is_busy, !is_busy, 10, 10 * 1000);
 }
 
-int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum, u16 value)
+int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id, int regnum,
+			 u16 value)
 {
 	struct enetc_mdio_priv *mdio_priv = bus->priv;
 	u32 mdio_ctl, mdio_cfg;
@@ -63,14 +64,39 @@ int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum, u16 value)
 	int ret;
 
 	mdio_cfg = ENETC_EMDIO_CFG;
-	if (regnum & MII_ADDR_C45) {
-		dev_addr = (regnum >> 16) & 0x1f;
-		mdio_cfg |= MDIO_CFG_ENC45;
-	} else {
-		/* clause 22 (ie 1G) */
-		dev_addr = regnum & 0x1f;
-		mdio_cfg &= ~MDIO_CFG_ENC45;
-	}
+	dev_addr = regnum & 0x1f;
+	mdio_cfg &= ~MDIO_CFG_ENC45;
+
+	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
+
+	ret = enetc_mdio_wait_complete(mdio_priv);
+	if (ret)
+		return ret;
+
+	/* set port and dev addr */
+	mdio_ctl = MDIO_CTL_PORT_ADDR(phy_id) | MDIO_CTL_DEV_ADDR(dev_addr);
+	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CTL, mdio_ctl);
+
+	/* write the value */
+	enetc_mdio_wr(mdio_priv, ENETC_MDIO_DATA, value);
+
+	ret = enetc_mdio_wait_complete(mdio_priv);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_mdio_write_c22);
+
+int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id, int dev_addr,
+			 int regnum, u16 value)
+{
+	struct enetc_mdio_priv *mdio_priv = bus->priv;
+	u32 mdio_ctl, mdio_cfg;
+	int ret;
+
+	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg |= MDIO_CFG_ENC45;
 
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
 
@@ -83,13 +109,11 @@ int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum, u16 value)
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CTL, mdio_ctl);
 
 	/* set the register address */
-	if (regnum & MII_ADDR_C45) {
-		enetc_mdio_wr(mdio_priv, ENETC_MDIO_ADDR, regnum & 0xffff);
+	enetc_mdio_wr(mdio_priv, ENETC_MDIO_ADDR, regnum & 0xffff);
 
-		ret = enetc_mdio_wait_complete(mdio_priv);
-		if (ret)
-			return ret;
-	}
+	ret = enetc_mdio_wait_complete(mdio_priv);
+	if (ret)
+		return ret;
 
 	/* write the value */
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_DATA, value);
@@ -100,9 +124,9 @@ int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum, u16 value)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(enetc_mdio_write);
+EXPORT_SYMBOL_GPL(enetc_mdio_write_c45);
 
-int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
+int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
 {
 	struct enetc_mdio_priv *mdio_priv = bus->priv;
 	u32 mdio_ctl, mdio_cfg;
@@ -110,14 +134,51 @@ int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
 	int ret;
 
 	mdio_cfg = ENETC_EMDIO_CFG;
-	if (regnum & MII_ADDR_C45) {
-		dev_addr = (regnum >> 16) & 0x1f;
-		mdio_cfg |= MDIO_CFG_ENC45;
-	} else {
-		dev_addr = regnum & 0x1f;
-		mdio_cfg &= ~MDIO_CFG_ENC45;
+	dev_addr = regnum & 0x1f;
+	mdio_cfg &= ~MDIO_CFG_ENC45;
+
+	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
+
+	ret = enetc_mdio_wait_complete(mdio_priv);
+	if (ret)
+		return ret;
+
+	/* set port and device addr */
+	mdio_ctl = MDIO_CTL_PORT_ADDR(phy_id) | MDIO_CTL_DEV_ADDR(dev_addr);
+	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CTL, mdio_ctl);
+
+	/* initiate the read */
+	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CTL, mdio_ctl | MDIO_CTL_READ);
+
+	ret = enetc_mdio_wait_complete(mdio_priv);
+	if (ret)
+		return ret;
+
+	/* return all Fs if nothing was there */
+	if (enetc_mdio_rd(mdio_priv, ENETC_MDIO_CFG) & MDIO_CFG_RD_ER) {
+		dev_dbg(&bus->dev,
+			"Error while reading PHY%d reg at %d.%d\n",
+			phy_id, dev_addr, regnum);
+		return 0xffff;
 	}
 
+	value = enetc_mdio_rd(mdio_priv, ENETC_MDIO_DATA) & 0xffff;
+
+	return value;
+}
+EXPORT_SYMBOL_GPL(enetc_mdio_read_c22);
+
+int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id, int dev_addr,
+			int regnum)
+{
+	struct enetc_mdio_priv *mdio_priv = bus->priv;
+	u32 mdio_ctl, mdio_cfg;
+	u16 value;
+	int ret;
+
+	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg |= MDIO_CFG_ENC45;
+
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
 
 	ret = enetc_mdio_wait_complete(mdio_priv);
@@ -129,13 +190,11 @@ int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CTL, mdio_ctl);
 
 	/* set the register address */
-	if (regnum & MII_ADDR_C45) {
-		enetc_mdio_wr(mdio_priv, ENETC_MDIO_ADDR, regnum & 0xffff);
+	enetc_mdio_wr(mdio_priv, ENETC_MDIO_ADDR, regnum & 0xffff);
 
-		ret = enetc_mdio_wait_complete(mdio_priv);
-		if (ret)
-			return ret;
-	}
+	ret = enetc_mdio_wait_complete(mdio_priv);
+	if (ret)
+		return ret;
 
 	/* initiate the read */
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CTL, mdio_ctl | MDIO_CTL_READ);
@@ -156,7 +215,7 @@ int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
 
 	return value;
 }
-EXPORT_SYMBOL_GPL(enetc_mdio_read);
+EXPORT_SYMBOL_GPL(enetc_mdio_read_c45);
 
 struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index dafb26f81f95..a1b595bd7993 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -39,8 +39,10 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	}
 
 	bus->name = ENETC_MDIO_BUS_NAME;
-	bus->read = enetc_mdio_read;
-	bus->write = enetc_mdio_write;
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
 	bus->parent = dev;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = hw;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 9f6c4f5c0a6c..bc012deedab4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -848,8 +848,10 @@ static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 		return -ENOMEM;
 
 	bus->name = "Freescale ENETC MDIO Bus";
-	bus->read = enetc_mdio_read;
-	bus->write = enetc_mdio_write;
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
 	bus->parent = dev;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
@@ -885,8 +887,10 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 		return -ENOMEM;
 
 	bus->name = "Freescale ENETC internal MDIO Bus";
-	bus->read = enetc_mdio_read;
-	bus->write = enetc_mdio_write;
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
 	bus->parent = dev;
 	bus->phy_mask = ~0;
 	mdio_priv = bus->priv;
diff --git a/include/linux/fsl/enetc_mdio.h b/include/linux/fsl/enetc_mdio.h
index 2d9203314865..df25fffdc0ae 100644
--- a/include/linux/fsl/enetc_mdio.h
+++ b/include/linux/fsl/enetc_mdio.h
@@ -37,16 +37,27 @@ struct enetc_mdio_priv {
 
 #if IS_REACHABLE(CONFIG_FSL_ENETC_MDIO)
 
-int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum);
-int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum, u16 value);
+int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum);
+int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id, int regnum,
+			 u16 value);
+int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id, int devad, int regnum);
+int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id, int devad, int regnum,
+			 u16 value);
 struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs);
 
 #else
 
-static inline int enetc_mdio_read(struct mii_bus *bus, int phy_id, int regnum)
+static inline int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id,
+				      int regnum)
 { return -EINVAL; }
-static inline int enetc_mdio_write(struct mii_bus *bus, int phy_id, int regnum,
-				   u16 value)
+static inline int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id,
+				       int regnum, u16 value)
+{ return -EINVAL; }
+static inline int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id,
+				      int devad, int regnum)
+{ return -EINVAL; }
+static inline int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id,
+				       int devad, int regnum, u16 value)
 { return -EINVAL; }
 struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
 { return ERR_PTR(-EINVAL); }

-- 
2.30.2
