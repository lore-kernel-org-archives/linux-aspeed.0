From: Michael Walle <michael@walle.cc>
Date: Mon, 16 Jan 2023 13:55:17 +0100
Subject: [PATCH net-next 5/6] net: phy: Decide on C45 capabilities based on
 presence of method
In-Reply-To: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
References: <20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023@walle.cc>
Message-ID: <20230116-net-next-remove-probe-capabilities-v1-5-5aa29738a023@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Andrew Lunn <andrew@lunn.ch>

Some PHYs provide invalid IDs in C22 space. If C45 is supported on the
bus an attempt can be made to get the IDs from the C45 space. Decide
on this based on the presence of the C45 read method in the bus
structure. This will allow the unreliable probe_capabilities to be
removed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 0d371a0a49f2..9ba8f973f26f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -946,7 +946,7 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
 	 * probe with C45 to see if we're able to get a valid PHY ID in the C45
 	 * space, if successful, create the C45 PHY device.
 	 */
-	if (!is_c45 && phy_id == 0 && bus->probe_capabilities >= MDIOBUS_C45) {
+	if (!is_c45 && phy_id == 0 && bus->read_c45) {
 		r = get_phy_c45_ids(bus, addr, &c45_ids);
 		if (!r)
 			return phy_device_create(bus, addr, phy_id,

-- 
2.30.2
