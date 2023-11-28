From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Tue, 28 Nov 2023 14:52:35 +0700
Subject: [PATCH v2 RESEND 1/2] i2c: aspeed: Fix unhandled Tx done with NAK
In-Reply-To: <20231128075236.2724038-1-quan@os.amperecomputing.com>
References: <20231128075236.2724038-1-quan@os.amperecomputing.com>
Message-ID: <20231128075236.2724038-2-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Under normal conditions, after the last byte is sent by the Slave, the
TX_NAK interrupt is raised.  However, it is also observed that
sometimes the Master issues the next transaction too quickly while the
Slave IRQ handler is not yet invoked and the TX_NAK interrupt for the
last byte of the previous READ_PROCESSED state has not been ack?ed.
This TX_NAK interrupt is then raised together with SLAVE_MATCH interrupt
and RX_DONE interrupt of the next coming transaction from Master. The
Slave IRQ handler currently handles the SLAVE_MATCH and RX_DONE, but
ignores the TX_NAK, causing complaints such as
"aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
0x00000086, but was 0x00000084"

This commit adds code to handle this case by emitting a SLAVE_STOP event
for the TX_NAK before processing the RX_DONE for the coming transaction
from the Master.

Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v2:
  + Split to separate series [Joel]
  + Added the Fixes line [Joel]
  + Revised commit message [Quan]

v1:
  + First introduced in
https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/
---
 drivers/i2c/busses/i2c-aspeed.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 28e2a5fc4528..79476b46285b 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -253,6 +253,11 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 
 	/* Slave was requested, restart state machine. */
 	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
+		if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
+		    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
+			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
+			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
+		}
 		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
 		bus->slave_state = ASPEED_I2C_SLAVE_START;
 	}
-- 
2.35.1

