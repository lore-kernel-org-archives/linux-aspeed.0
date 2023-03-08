From: Klaus Kudielka <klaus.kudielka@gmail.com>
Date: Wed, 08 Mar 2023 19:34:40 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus
 capabilities for C22 and C45
In-Reply-To: <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
	 <20230116-net-next-remove-probe-capabilities-v2-4-15513b05e1f4@walle.cc>
	 <449bde236c08d5ab5e54abd73b645d8b29955894.camel@gmail.com>
	 <100c439a-2a4d-4cb2-96f2-5bf273e2121a@lunn.ch>
	 <712bc92ca6d576f33f63f1e9c2edf0030b10d3ae.camel@gmail.com>
	 <db6b8a09-b680-4baa-8963-d355ad29eb09@lunn.ch>
	 <0e10aa8492eadb587949d8744b56fccaabbd183b.camel@gmail.com>
	 <72530e86-9ba9-4a01-9cd2-68835ecae7a0@lunn.ch>
Message-ID: <09d65e1ee0679e1e74b4f3a5a4c55bd48332f043.camel@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2023-03-07 at 21:35 +0100, Andrew Lunn wrote:
> > Summary: Still 4 calls to mdio_bus_scan_c22, but also *2* calls to mdio_bus_scan_c45, approx. 190*100 reads by the switch driver
> 
> Those calls to mdio_bus_scan_c45 are caused by 743a19e38d02 net: dsa:
> mv88e6xxx: Separate C22 and C45 transactions.

Well, yes and no. I understand orion mdio is MDIOBUS_NO_CAP
and therefore the c45 scan is *not* called until 1a136ca2e0
net: mdio: scan bus based on bus capabilities for C22 and C45.
Which is the behaviour I see.
(I needed a close look at the conditions in the if statements
that were removed then)


> The only part of a c45 scan which is not linear is
> mv88e6xxx_g2_smi_phy_wait() which is implemented by
> mv88e6xxx_wait_mask(). That loops reading a register waiting for a bit
> to change. Maybe print out the value of i, and see if it is looping
> more times for C45 than C22?

Here the debug code

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 0a5d6c7bb1..23816cad41 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -90,6 +90,7 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 	u16 data;
 	int err;
 	int i;
+	static unsigned wait_count = 0, loop_count = 0;
 
 	/* There's no bus specific operation to wait for a mask. Even
 	 * if the initial poll takes longer than 50ms, always do at
@@ -100,8 +101,13 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 		if (err)
 			return err;
 
-		if ((data & mask) == val)
+		if ((data & mask) == val) {
+			wait_count++;
+			loop_count += i;
+			if (wait_count % 10 == 0)
+				dev_warn(chip->dev, "wait_count %u, loop_count %u\n", wait_count, loop_count);
 			return 0;
+		}
 
 		if (i < 2)
 			cpu_relax();
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 5b2f48c09a..19fde21cae 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -569,6 +569,7 @@ static int mdiobus_scan_bus_c22(struct mii_bus *bus)
 {
 	int i;
 
+	dev_warn(&bus->dev, "*** mdiobus_scan_bus_c22 call ***\n");
 	for (i = 0; i < PHY_MAX_ADDR; i++) {
 		if ((bus->phy_mask & BIT(i)) == 0) {
 			struct phy_device *phydev;
@@ -578,6 +579,7 @@ static int mdiobus_scan_bus_c22(struct mii_bus *bus)
 				return PTR_ERR(phydev);
 		}
 	}
+	dev_warn(&bus->dev, "*** mdiobus_scan_bus_c22 return ***\n");
 	return 0;
 }
 
@@ -585,6 +587,7 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
 {
 	int i;
 
+	dev_warn(&bus->dev, "*** mdiobus_scan_bus_c45 call ***\n");
 	for (i = 0; i < PHY_MAX_ADDR; i++) {
 		if ((bus->phy_mask & BIT(i)) == 0) {
 			struct phy_device *phydev;
@@ -598,6 +601,7 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
 				return PTR_ERR(phydev);
 		}
 	}
+	dev_warn(&bus->dev, "*** mdiobus_scan_bus_c45 return ***\n");
 	return 0;
 }
 


And here the trimmed results from boot @ 1a136ca2e0, plus debug code.

It's not only the looping during the mv88e6xxx_wait_mask calls, but
also the sheer amount of mv88e6xxx_wait_mask calls during the c45 scans.
(c22: ~0.1 sec & ~150 calls, c45: 2.3-2.5 sec & ~4800 calls)


[    0.195215] mdio_bus fixed-0: *** mdiobus_scan_bus_c22 call ***
[    0.195221] mdio_bus fixed-0: *** mdiobus_scan_bus_c22 return ***
[    0.195617] mdio_bus f1072004.mdio-mii: *** mdiobus_scan_bus_c22 call ***
[    0.195623] mdio_bus f1072004.mdio-mii: *** mdiobus_scan_bus_c22 return ***
[    0.202583] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marvell 88E6176, revision 1
[    0.212708] mdio_bus mv88e6xxx-0: *** mdiobus_scan_bus_c22 call ***
[    0.222200] mv88e6085 f1072004.mdio-mii:10: wait_count 10, loop_count 3
........
[    0.315724] mv88e6085 f1072004.mdio-mii:10: wait_count 150, loop_count 76
[    0.315908] mdio_bus mv88e6xxx-0: *** mdiobus_scan_bus_c22 return ***
[    0.315913] mdio_bus mv88e6xxx-0: *** mdiobus_scan_bus_c45 call ***
[    0.321095] mv88e6085 f1072004.mdio-mii:10: wait_count 160, loop_count 83
........
[    2.610380] mv88e6085 f1072004.mdio-mii:10: wait_count 4980, loop_count 1571
[    2.613258] mdio_bus mv88e6xxx-0: *** mdiobus_scan_bus_c45 return ***
[    2.755785] mv88e6085 f1072004.mdio-mii:10: switch 0x1760 detected: Marvell 88E6176, revision 1
[    2.766047] mdio_bus mv88e6xxx-1: *** mdiobus_scan_bus_c22 call ***
[    2.766960] mv88e6085 f1072004.mdio-mii:10: wait_count 4990, loop_count 1574
........
[    2.867107] mv88e6085 f1072004.mdio-mii:10: wait_count 5130, loop_count 1645
[    2.869938] mdio_bus mv88e6xxx-1: *** mdiobus_scan_bus_c22 return ***
[    2.869943] mdio_bus mv88e6xxx-1: *** mdiobus_scan_bus_c45 call ***
[    2.871556] mv88e6085 f1072004.mdio-mii:10: wait_count 5140, loop_count 1649
........
[    5.371710] mv88e6085 f1072004.mdio-mii:10: wait_count 9970, loop_count 4282
[    5.373332] mdio_bus mv88e6xxx-1: *** mdiobus_scan_bus_c45 return ***




Best regards, Klaus
