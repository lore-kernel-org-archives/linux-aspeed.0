From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Fri, 18 Oct 2024 11:49:19 +0800
Subject: [PATCH] i2c: aspeed: Consider i2c reset for muti-master case
Message-ID: <20241018034919.974025-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In the original code, the device reset would not be triggered
when the driver is set to multi-master and bus is free.
It needs to be considered with multi-master condition.

Fixes: <f327c686d3ba> ("i2c: aspeed: Reset the i2c controller when timeout occurs")

Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index cc5a26637fd5..7639ae3ace67 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -716,14 +716,15 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 	if (time_left == 0) {
 		/*
 		 * In a multi-master setup, if a timeout occurs, attempt
-		 * recovery. But if the bus is idle, we still need to reset the
-		 * i2c controller to clear the remaining interrupts.
+		 * recovery device. But if the bus is idle,
+		 * we still need to reset the i2c controller to clear
+		 * the remaining interrupts or reset device abnormal condition.
 		 */
-		if (bus->multi_master &&
-		    (readl(bus->base + ASPEED_I2C_CMD_REG) &
-		     ASPEED_I2CD_BUS_BUSY_STS))
-			aspeed_i2c_recover_bus(bus);
-		else
+		if ((readl(bus->base + ASPEED_I2C_CMD_REG) &
+			ASPEED_I2CD_BUS_BUSY_STS)){
+			if (bus->multi_master)
+				aspeed_i2c_recover_bus(bus);
+		} else
 			aspeed_i2c_reset(bus);
 
 		/*
-- 
2.25.1

