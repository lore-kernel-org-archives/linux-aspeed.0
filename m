From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Mon, 14 Aug 2023 19:15:34 +0800
Subject: [PATCH] drivers:i2c:add controller reset when the timeout occurred
Message-ID: <20230814111534.2771900-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

1.Call i2c controller reset when the i2c transfer timeout occurred.
The rest of interrupts and device should be reset avoid unperdicted
controller behavior occurred.

Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 2e5acfeb76c8..1900954deb55 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -699,12 +699,16 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 	if (time_left == 0) {
 		/*
 		 * If timed out and bus is still busy in a multi master
-		 * environment, attempt recovery at here.
+		 * environment, attempt recovery at here. Even the bus is
+		 * idle, we still need reset i2c controller avoid rest of
+		 * interrupts.
 		 */
 		if (bus->multi_master &&
 		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
 		     ASPEED_I2CD_BUS_BUSY_STS))
 			aspeed_i2c_recover_bus(bus);
+		else
+			aspeed_i2c_reset(bus);
 
 		/*
 		 * If timed out and the state is still pending, drop the pending
-- 
2.25.1

