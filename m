From: Tommy Huang <tommy_huang@aspeedtech.com>
Date: Tue, 5 Mar 2024 09:19:06 +0800
Subject: [PATCH v2] i2c: aspeed: Fix the dummy irq expected print
Message-ID: <20240305011906.2745639-1-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When the i2c error condition occurred and master state was not
idle, the master irq function will goto complete state without any
other interrupt handling. It would cause dummy irq expected print.
Under this condition, assign the irq_status into irq_handle.

For example, when the abnormal start / stop occurred (bit 5) with
normal stop status (bit 4) at same time. Then the normal stop status
would not be handled and it would cause irq expected print in
the aspeed_i2c_bus_irq.

...
aspeed-i2c-bus x. i2c-bus: irq handled != irq.
Expected 0x00000030, but was 0x00000020
...

Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

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

