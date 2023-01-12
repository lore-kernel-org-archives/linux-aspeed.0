From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:08 +0100
Subject: [PATCH net-next 02/10] net: mdio: i2c: Separate C22 and C45 transactions
In-Reply-To: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
References: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-2-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

The MDIO over I2C bus driver can perform both C22 and C45 transfers.
Create separate functions for each and register the C45 versions using
the new API calls.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/mdio/mdio-i2c.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mdio/mdio-i2c.c b/drivers/net/mdio/mdio-i2c.c
index bf8bf5e20faf..9577a1842997 100644
--- a/drivers/net/mdio/mdio-i2c.c
+++ b/drivers/net/mdio/mdio-i2c.c
@@ -30,7 +30,8 @@ static unsigned int i2c_mii_phy_addr(int phy_id)
 	return phy_id + 0x40;
 }
 
-static int i2c_mii_read_default(struct mii_bus *bus, int phy_id, int reg)
+static int i2c_mii_read_default_c45(struct mii_bus *bus, int phy_id, int devad,
+				    int reg)
 {
 	struct i2c_adapter *i2c = bus->priv;
 	struct i2c_msg msgs[2];
@@ -41,8 +42,8 @@ static int i2c_mii_read_default(struct mii_bus *bus, int phy_id, int reg)
 		return 0xffff;
 
 	p = addr;
-	if (reg & MII_ADDR_C45) {
-		*p++ = 0x20 | ((reg >> 16) & 31);
+	if (devad >= 0) {
+		*p++ = 0x20 | devad;
 		*p++ = reg >> 8;
 	}
 	*p++ = reg;
@@ -64,8 +65,8 @@ static int i2c_mii_read_default(struct mii_bus *bus, int phy_id, int reg)
 	return data[0] << 8 | data[1];
 }
 
-static int i2c_mii_write_default(struct mii_bus *bus, int phy_id, int reg,
-				 u16 val)
+static int i2c_mii_write_default_c45(struct mii_bus *bus, int phy_id,
+				     int devad, int reg, u16 val)
 {
 	struct i2c_adapter *i2c = bus->priv;
 	struct i2c_msg msg;
@@ -76,8 +77,8 @@ static int i2c_mii_write_default(struct mii_bus *bus, int phy_id, int reg,
 		return 0;
 
 	p = data;
-	if (reg & MII_ADDR_C45) {
-		*p++ = (reg >> 16) & 31;
+	if (devad >= 0) {
+		*p++ = devad;
 		*p++ = reg >> 8;
 	}
 	*p++ = reg;
@@ -94,6 +95,17 @@ static int i2c_mii_write_default(struct mii_bus *bus, int phy_id, int reg,
 	return ret < 0 ? ret : 0;
 }
 
+static int i2c_mii_read_default_c22(struct mii_bus *bus, int phy_id, int reg)
+{
+	return i2c_mii_read_default_c45(bus, phy_id, -1, reg);
+}
+
+static int i2c_mii_write_default_c22(struct mii_bus *bus, int phy_id, int reg,
+				     u16 val)
+{
+	return i2c_mii_write_default_c45(bus, phy_id, -1, reg, val);
+}
+
 /* RollBall SFPs do not access internal PHY via I2C address 0x56, but
  * instead via address 0x51, when SFP page is set to 0x03 and password to
  * 0xffffffff.
@@ -403,8 +415,10 @@ struct mii_bus *mdio_i2c_alloc(struct device *parent, struct i2c_adapter *i2c,
 		mii->write = i2c_mii_write_rollball;
 		break;
 	default:
-		mii->read = i2c_mii_read_default;
-		mii->write = i2c_mii_write_default;
+		mii->read = i2c_mii_read_default_c22;
+		mii->write = i2c_mii_write_default_c22;
+		mii->read_c45 = i2c_mii_read_default_c45;
+		mii->write_c45 = i2c_mii_write_default_c45;
 		break;
 	}
 

-- 
2.30.2
