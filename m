From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 29 Sep 2022 15:03:26 +0700
Subject: [PATCH v9 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <20220929080326.752907-1-quan@os.amperecomputing.com>
References: <20220929080326.752907-1-quan@os.amperecomputing.com>
Message-ID: <20220929080326.752907-4-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On I2C_SLAVE_WRITE_REQUESTED event, Slave already ACK'ed on the address
phase. But as the backend driver is busy and unable to process any
request from Master, issue RxCmdLast for Slave to auto send NACK on
next incoming byte.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
---
v9:
  + Update commit message and add comment to explain
    the effect of issuing RxCmdLast when Slave busy [Quan]

v7 -> v8:
  + None

v6:
  + New introduced in v6                            [Quan]

 drivers/i2c/busses/i2c-aspeed.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 185dedfebbac..3d70f1ce6c6a 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -244,6 +244,7 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 	u32 command, irq_handled = 0;
 	struct i2c_client *slave = bus->slave;
 	u8 value;
+	int ret;
 
 	if (!slave)
 		return 0;
@@ -311,7 +312,13 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		break;
 	case ASPEED_I2C_SLAVE_WRITE_REQUESTED:
 		bus->slave_state = ASPEED_I2C_SLAVE_WRITE_RECEIVED;
-		i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+		ret = i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+		/*
+		 * Slave ACK's on this address phase already but as the backend driver insists it
+		 * is busy, turn on RxCmdLast for Slave to NACK on the next Rx byte.
+		 */
+		if (ret == -EBUSY)
+			writel(ASPEED_I2CD_M_S_RX_CMD_LAST, bus->base + ASPEED_I2C_CMD_REG);
 		break;
 	case ASPEED_I2C_SLAVE_WRITE_RECEIVED:
 		i2c_slave_event(slave, I2C_SLAVE_WRITE_RECEIVED, &value);
-- 
2.35.1

