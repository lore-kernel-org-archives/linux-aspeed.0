From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Fri, 16 Feb 2024 20:04:55 +0800
Subject: [PATCH] i2c: aspeed: Fix the dummy irq expected print
Message-ID: <20240216120455.4138642-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When the i2c error condition occurred and master state was not idle,
the master irq function will goto complete state without any other
interrupt handling. It would cause dummy irq expected print. Under
this condition, assign the irq_status into irq_handle.

Signed-off-by: Tommy Huang <tommy_huang@aspeedtech.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 5511fd46a65e..ce8c4846b7fa 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -445,6 +445,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 			irq_status);
 		irq_handled |= (irq_status & ASPEED_I2CD_INTR_MASTER_ERRORS);
 		if (bus->master_state != ASPEED_I2C_MASTER_INACTIVE) {
+			irq_handled = irq_status;
 			bus->cmd_err = ret;
 			bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
 			goto out_complete;
-- 
2.25.1

