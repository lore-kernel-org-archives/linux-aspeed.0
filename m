From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Wed, 6 Sep 2023 08:49:10 +0800
Subject: [PATCH v3] i2c: aspeed: Reset the i2c controller when timeout occurs
Message-ID: <20230906004910.4157305-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Reset the i2c controller when an i2c transfer timeout occurs.
The remaining interrupts and device should be reset to avoid
unpredictable controller behavior.

Fixes: 2e57b7cebb98 ("i2c: aspeed: Add multi-master use case support")
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.1+
Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
V3: Submit this patch for clearing patch style typo.
---
 drivers/i2c/busses/i2c-aspeed.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 2e5acfeb76c8..5a416b39b818 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -698,13 +698,16 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 
 	if (time_left == 0) {
 		/*
-		 * If timed out and bus is still busy in a multi master
-		 * environment, attempt recovery at here.
+		 * In a multi-master setup, if a timeout occurs, attempt
+		 * recovery. But if the bus is idle, we still need to reset the
+		 * i2c controller to clear the remaining interrupts.
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

