From: Lixue Liang <lianglixuehao@126.com>
Date: Fri, 28 Jul 2023 12:24:16 +0000
Subject: [PATCH] i2c: aspeed: Avoid accessing freed buffers during i2c transfers.
Message-ID: <20230728122416.17782-1-lianglixuehao@126.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Lixue Liang <lianglixue@greatwall.com.cn>

After waiting for the transmission timeout, the I2C controller will
continue to transmit data when the bus is idle. Clearing bus->msg will
avoid kernel panic when accessing the freed msg->buf in
aspeed_i2c_master_irq.

Signed-off-by: Lixue Liang <lianglixue@greatwall.com.cn>
---
 drivers/i2c/busses/i2c-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 2e5acfeb76c8..c83057497e26 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -713,6 +713,8 @@ static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
 		spin_lock_irqsave(&bus->lock, flags);
 		if (bus->master_state == ASPEED_I2C_MASTER_PENDING)
 			bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
+
+		bus->msgs = NULL;
 		spin_unlock_irqrestore(&bus->lock, flags);
 
 		return -ETIMEDOUT;
-- 
2.27.0

