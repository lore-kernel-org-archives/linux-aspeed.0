From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:07 +0100
Subject: [PATCH net-next 01/10] net: mdio: cavium: Separate C22 and C45 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-1-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The cavium IP can perform both C22 and C45 transfers.  Create separate
functions for each and register the C45 versions in both the octeon
and thunder bus driver.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/mdio/mdio-cavium.c  | 111 +++++++++++++++++++++++++++++-----------
 drivers/net/mdio/mdio-cavium.h  |   9 +++-
 drivers/net/mdio/mdio-octeon.c  |   6 ++-
 drivers/net/mdio/mdio-thunder.c |   6 ++-
 4 files changed, 95 insertions(+), 37 deletions(-)

diff --git a/drivers/net/mdio/mdio-cavium.c b/drivers/net/mdio/mdio-cavium.c
index 95ce274c1be1..fd81546a4d3d 100644
--- a/drivers/net/mdio/mdio-cavium.c
+++ b/drivers/net/mdio/mdio-cavium.c
@@ -26,7 +26,7 @@ static void cavium_mdiobus_set_mode(struct cavium_mdiobus *p,
 }
 
 static int cavium_mdiobus_c45_addr(struct cavium_mdiobus *p,
-				   int phy_id, int regnum)
+				   int phy_id, int devad, int regnum)
 {
 	union cvmx_smix_cmd smi_cmd;
 	union cvmx_smix_wr_dat smi_wr;
@@ -38,12 +38,10 @@ static int cavium_mdiobus_c45_addr(struct cavium_mdiobus *p,
 	smi_wr.s.dat = regnum & 0xffff;
 	oct_mdio_writeq(smi_wr.u64, p->register_base + SMI_WR_DAT);
 
-	regnum = (regnum >> 16) & 0x1f;
-
 	smi_cmd.u64 = 0;
 	smi_cmd.s.phy_op = 0; /* MDIO_CLAUSE_45_ADDRESS */
 	smi_cmd.s.phy_adr = phy_id;
-	smi_cmd.s.reg_adr = regnum;
+	smi_cmd.s.reg_adr = devad;
 	oct_mdio_writeq(smi_cmd.u64, p->register_base + SMI_CMD);
 
 	do {
@@ -59,28 +57,51 @@ static int cavium_mdiobus_c45_addr(struct cavium_mdiobus *p,
 	return 0;
 }
 
-int cavium_mdiobus_read(struct mii_bus *bus, int phy_id, int regnum)
+int cavium_mdiobus_read_c22(struct mii_bus *bus, int phy_id, int regnum)
 {
 	struct cavium_mdiobus *p = bus->priv;
 	union cvmx_smix_cmd smi_cmd;
 	union cvmx_smix_rd_dat smi_rd;
-	unsigned int op = 1; /* MDIO_CLAUSE_22_READ */
 	int timeout = 1000;
 
-	if (regnum & MII_ADDR_C45) {
-		int r = cavium_mdiobus_c45_addr(p, phy_id, regnum);
+	cavium_mdiobus_set_mode(p, C22);
+
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = 1; /* MDIO_CLAUSE_22_READ */;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = regnum;
+	oct_mdio_writeq(smi_cmd.u64, p->register_base + SMI_CMD);
+
+	do {
+		/* Wait 1000 clocks so we don't saturate the RSL bus
+		 * doing reads.
+		 */
+		__delay(1000);
+		smi_rd.u64 = oct_mdio_readq(p->register_base + SMI_RD_DAT);
+	} while (smi_rd.s.pending && --timeout);
+
+	if (smi_rd.s.val)
+		return smi_rd.s.dat;
+	else
+		return -EIO;
+}
+EXPORT_SYMBOL(cavium_mdiobus_read_c22);
 
-		if (r < 0)
-			return r;
+int cavium_mdiobus_read_c45(struct mii_bus *bus, int phy_id, int devad,
+			    int regnum)
+{
+	struct cavium_mdiobus *p = bus->priv;
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_rd_dat smi_rd;
+	int timeout = 1000;
+	int r;
 
-		regnum = (regnum >> 16) & 0x1f;
-		op = 3; /* MDIO_CLAUSE_45_READ */
-	} else {
-		cavium_mdiobus_set_mode(p, C22);
-	}
+	r = cavium_mdiobus_c45_addr(p, phy_id, devad, regnum);
+	if (r < 0)
+		return r;
 
 	smi_cmd.u64 = 0;
-	smi_cmd.s.phy_op = op;
+	smi_cmd.s.phy_op = 3; /* MDIO_CLAUSE_45_READ */
 	smi_cmd.s.phy_adr = phy_id;
 	smi_cmd.s.reg_adr = regnum;
 	oct_mdio_writeq(smi_cmd.u64, p->register_base + SMI_CMD);
@@ -98,36 +119,64 @@ int cavium_mdiobus_read(struct mii_bus *bus, int phy_id, int regnum)
 	else
 		return -EIO;
 }
-EXPORT_SYMBOL(cavium_mdiobus_read);
+EXPORT_SYMBOL(cavium_mdiobus_read_c45);
 
-int cavium_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
+int cavium_mdiobus_write_c22(struct mii_bus *bus, int phy_id, int regnum,
+			     u16 val)
 {
 	struct cavium_mdiobus *p = bus->priv;
 	union cvmx_smix_cmd smi_cmd;
 	union cvmx_smix_wr_dat smi_wr;
-	unsigned int op = 0; /* MDIO_CLAUSE_22_WRITE */
 	int timeout = 1000;
 
-	if (regnum & MII_ADDR_C45) {
-		int r = cavium_mdiobus_c45_addr(p, phy_id, regnum);
+	cavium_mdiobus_set_mode(p, C22);
 
-		if (r < 0)
-			return r;
+	smi_wr.u64 = 0;
+	smi_wr.s.dat = val;
+	oct_mdio_writeq(smi_wr.u64, p->register_base + SMI_WR_DAT);
 
-		regnum = (regnum >> 16) & 0x1f;
-		op = 1; /* MDIO_CLAUSE_45_WRITE */
-	} else {
-		cavium_mdiobus_set_mode(p, C22);
-	}
+	smi_cmd.u64 = 0;
+	smi_cmd.s.phy_op = 0; /* MDIO_CLAUSE_22_WRITE */;
+	smi_cmd.s.phy_adr = phy_id;
+	smi_cmd.s.reg_adr = regnum;
+	oct_mdio_writeq(smi_cmd.u64, p->register_base + SMI_CMD);
+
+	do {
+		/* Wait 1000 clocks so we don't saturate the RSL bus
+		 * doing reads.
+		 */
+		__delay(1000);
+		smi_wr.u64 = oct_mdio_readq(p->register_base + SMI_WR_DAT);
+	} while (smi_wr.s.pending && --timeout);
+
+	if (timeout <= 0)
+		return -EIO;
+
+	return 0;
+}
+EXPORT_SYMBOL(cavium_mdiobus_write_c22);
+
+int cavium_mdiobus_write_c45(struct mii_bus *bus, int phy_id, int devad,
+			     int regnum, u16 val)
+{
+	struct cavium_mdiobus *p = bus->priv;
+	union cvmx_smix_cmd smi_cmd;
+	union cvmx_smix_wr_dat smi_wr;
+	int timeout = 1000;
+	int r;
+
+	r = cavium_mdiobus_c45_addr(p, phy_id, devad, regnum);
+	if (r < 0)
+		return r;
 
 	smi_wr.u64 = 0;
 	smi_wr.s.dat = val;
 	oct_mdio_writeq(smi_wr.u64, p->register_base + SMI_WR_DAT);
 
 	smi_cmd.u64 = 0;
-	smi_cmd.s.phy_op = op;
+	smi_cmd.s.phy_op = 1; /* MDIO_CLAUSE_45_WRITE */
 	smi_cmd.s.phy_adr = phy_id;
-	smi_cmd.s.reg_adr = regnum;
+	smi_cmd.s.reg_adr = devad;
 	oct_mdio_writeq(smi_cmd.u64, p->register_base + SMI_CMD);
 
 	do {
@@ -143,7 +192,7 @@ int cavium_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val)
 
 	return 0;
 }
-EXPORT_SYMBOL(cavium_mdiobus_write);
+EXPORT_SYMBOL(cavium_mdiobus_write_c45);
 
 MODULE_DESCRIPTION("Common code for OCTEON and Thunder MDIO bus drivers");
 MODULE_AUTHOR("David Daney");
diff --git a/drivers/net/mdio/mdio-cavium.h b/drivers/net/mdio/mdio-cavium.h
index a2245d436f5d..71b8e20cd664 100644
--- a/drivers/net/mdio/mdio-cavium.h
+++ b/drivers/net/mdio/mdio-cavium.h
@@ -114,5 +114,10 @@ static inline u64 oct_mdio_readq(void __iomem *addr)
 #define oct_mdio_readq(addr)		readq(addr)
 #endif
 
-int cavium_mdiobus_read(struct mii_bus *bus, int phy_id, int regnum);
-int cavium_mdiobus_write(struct mii_bus *bus, int phy_id, int regnum, u16 val);
+int cavium_mdiobus_read_c22(struct mii_bus *bus, int phy_id, int regnum);
+int cavium_mdiobus_write_c22(struct mii_bus *bus, int phy_id, int regnum,
+			     u16 val);
+int cavium_mdiobus_read_c45(struct mii_bus *bus, int phy_id, int devad,
+			    int regnum);
+int cavium_mdiobus_write_c45(struct mii_bus *bus, int phy_id, int devad,
+			     int regnum, u16 val);
diff --git a/drivers/net/mdio/mdio-octeon.c b/drivers/net/mdio/mdio-octeon.c
index e096e68ac667..7c65c547d377 100644
--- a/drivers/net/mdio/mdio-octeon.c
+++ b/drivers/net/mdio/mdio-octeon.c
@@ -58,8 +58,10 @@ static int octeon_mdiobus_probe(struct platform_device *pdev)
 	snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%px", bus->register_base);
 	bus->mii_bus->parent = &pdev->dev;
 
-	bus->mii_bus->read = cavium_mdiobus_read;
-	bus->mii_bus->write = cavium_mdiobus_write;
+	bus->mii_bus->read = cavium_mdiobus_read_c22;
+	bus->mii_bus->write = cavium_mdiobus_write_c22;
+	bus->mii_bus->read_c45 = cavium_mdiobus_read_c45;
+	bus->mii_bus->write_c45 = cavium_mdiobus_write_c45;
 
 	platform_set_drvdata(pdev, bus);
 
diff --git a/drivers/net/mdio/mdio-thunder.c b/drivers/net/mdio/mdio-thunder.c
index 822d2cdd2f35..3847ee92c109 100644
--- a/drivers/net/mdio/mdio-thunder.c
+++ b/drivers/net/mdio/mdio-thunder.c
@@ -93,8 +93,10 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 		bus->mii_bus->name = KBUILD_MODNAME;
 		snprintf(bus->mii_bus->id, MII_BUS_ID_SIZE, "%llx", r.start);
 		bus->mii_bus->parent = &pdev->dev;
-		bus->mii_bus->read = cavium_mdiobus_read;
-		bus->mii_bus->write = cavium_mdiobus_write;
+		bus->mii_bus->read = cavium_mdiobus_read_c22;
+		bus->mii_bus->write = cavium_mdiobus_write_c22;
+		bus->mii_bus->read_c45 = cavium_mdiobus_read_c45;
+		bus->mii_bus->write_c45 = cavium_mdiobus_write_c45;
 
 		err = of_mdiobus_register(bus->mii_bus, node);
 		if (err)

-- 
2.30.2
