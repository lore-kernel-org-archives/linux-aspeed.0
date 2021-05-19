From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 19 May 2021 14:49:30 +0700
Subject: [PATCH v3 3/7] i2c: aspeed: Fix unhandled Tx done with NAK
In-Reply-To: <20210519074934.20712-1-quan@os.amperecomputing.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
Message-ID: <20210519074934.20712-4-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It is observed that in normal condition, when the last byte sent by
slave, the Tx Done with NAK irq will raise.
But it is also observed that sometimes master issues next transaction
too quick while the slave irq handler is not yet invoked and Tx Done
with NAK irq of last byte of previous READ PROCESSED was not ack'ed.
This Tx Done with NAK irq is raised together with the Slave Match and
Rx Done irq of the next coming transaction from master.
Unfortunately, the current slave irq handler handles the Slave Match and
Rx Done only in higher priority and ignore the Tx Done with NAK, causing
the complain as below:
"aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. expected
0x00000086, but was 0x00000084"

This commit handles this case by emitting a Slave Stop event for the
Tx Done with NAK before processing Slave Match and Rx Done for the
coming transaction from master.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v3:
  + First introduce in v3 [Quan]

 drivers/i2c/busses/i2c-aspeed.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 724bf30600d6..3fb37c3f23d4 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -254,6 +254,11 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 
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
2.28.0

