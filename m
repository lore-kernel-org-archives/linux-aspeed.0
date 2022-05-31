From: ryan_chen <ryan_chen@aspeedtech.com>
Date: Tue, 31 May 2022 17:31:40 +0800
Subject: [PATCH] i2c: aspeed: Fix slave mode unexpected irq handler
Message-ID: <20220531093140.28770-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When i2c master send the new i2c transfer immediately
after stop. the i2c slave will see the stop and new
address match stage together. And it needs handle the
stop first. otherwise will occur unexpected handle
isr.

Fixes: f327c686d3ba ("i2c: aspeed: added drover for Aspeed I2C)
Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 771e53d3d197..9f21e090ce47 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -252,6 +252,12 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 
 	/* Slave was requested, restart state machine. */
 	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
+		if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP &&
+			bus->slave_state == ASPEED_I2C_SLAVE_WRITE_RECEIVED) {
+			irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
+			irq_status &= ~ASPEED_I2CD_INTR_NORMAL_STOP;
+			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
+		}
 		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
 		bus->slave_state = ASPEED_I2C_SLAVE_START;
 	}
-- 
2.17.1

