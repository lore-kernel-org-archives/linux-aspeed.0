From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Wed, 24 Nov 2021 14:10:57 +0800
Subject: [PATCH] net:phy: Fix "Link is Down" issue
Message-ID: <20211124061057.12555-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The issue happened randomly in runtime.  The message "Link is Down" is
popped but soon it recovered to "Link is Up".

The "Link is Down" results from the incorrect read data for reading the
PHY register via MDIO bus.  The correct sequence for reading the data
shall be:
1. fire the command
2. wait for command done (this step was missing)
3. wait for data idle
4. read data from data register

Fixes: a9770eac511a ("net: mdio: Move MDIO drivers into a new subdirectory")
Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---
 drivers/net/mdio/mdio-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
index cad820568f75..966c3b4ad59d 100644
--- a/drivers/net/mdio/mdio-aspeed.c
+++ b/drivers/net/mdio/mdio-aspeed.c
@@ -61,6 +61,13 @@ static int aspeed_mdio_read(struct mii_bus *bus, int addr, int regnum)
 
 	iowrite32(ctrl, ctx->base + ASPEED_MDIO_CTRL);
 
+	rc = readl_poll_timeout(ctx->base + ASPEED_MDIO_CTRL, ctrl,
+				!(ctrl & ASPEED_MDIO_CTRL_FIRE),
+				ASPEED_MDIO_INTERVAL_US,
+				ASPEED_MDIO_TIMEOUT_US);
+	if (rc < 0)
+		return rc;
+
 	rc = readl_poll_timeout(ctx->base + ASPEED_MDIO_DATA, data,
 				data & ASPEED_MDIO_DATA_IDLE,
 				ASPEED_MDIO_INTERVAL_US,
-- 
2.25.1

