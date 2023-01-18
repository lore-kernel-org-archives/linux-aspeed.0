From: Michael Walle <michael@walle.cc>
Date: Wed, 18 Jan 2023 11:01:38 +0100
Subject: [PATCH net-next v2 4/6] net: mdio: scan bus based on bus capabilities
 for C22 and C45
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
Message-ID: <20230116-net-next-remove-probe-capabilities-v2-4-15513b05e1f4@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

Now that all MDIO bus drivers which set probe_capabilities to
MDIOBUS_C22_C45 have been converted to use the name API for C45
transactions, perform the scanning of the bus based on which methods
the bus provides.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/phy/mdio_bus.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index a664eeb1868d..5b2f48c09a6a 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -711,9 +711,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error_reset_gpiod;
 	}
 
-	if (bus->probe_capabilities == MDIOBUS_NO_CAP ||
-	    bus->probe_capabilities == MDIOBUS_C22 ||
-	    bus->probe_capabilities == MDIOBUS_C22_C45) {
+	if (bus->read) {
 		err = mdiobus_scan_bus_c22(bus);
 		if (err)
 			goto error;
@@ -721,9 +719,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 
 	prevent_c45_scan = mdiobus_prevent_c45_scan(bus);
 
-	if (!prevent_c45_scan &&
-	    (bus->probe_capabilities == MDIOBUS_C45 ||
-	     bus->probe_capabilities == MDIOBUS_C22_C45)) {
+	if (!prevent_c45_scan && bus->read_c45) {
 		err = mdiobus_scan_bus_c45(bus);
 		if (err)
 			goto error;

-- 
2.30.2
