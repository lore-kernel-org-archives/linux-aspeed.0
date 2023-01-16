From: Michael Walle <michael@walle.cc>
Date: Mon, 16 Jan 2023 13:55:16 +0100
Subject: [PATCH net-next 4/6] net: mdio: scan bus based on bus capabilities
 for C22 and C45
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
Message-ID: <20230116-net-next-remove-probe-capabilities-v1-4-5aa29738a023@walle.cc>
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
---
 drivers/net/phy/mdio_bus.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index f173c91842e0..34790e601cb1 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -710,9 +710,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error_reset_gpiod;
 	}
 
-	if (bus->probe_capabilities == MDIOBUS_NO_CAP ||
-	    bus->probe_capabilities == MDIOBUS_C22 ||
-	    bus->probe_capabilities == MDIOBUS_C22_C45) {
+	if (bus->read) {
 		err = mdiobus_scan_bus_c22(bus);
 		if (err)
 			goto error;
@@ -720,9 +718,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 
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
