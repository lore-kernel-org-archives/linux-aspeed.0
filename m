From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Thu, 16 Jul 2020 16:52:42 -0500
Subject: [PATCH][next] i2c: aspeed: Use fallthrough pseudo-keyword
Message-ID: <20200716215242.GA19193@embeddedor>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/i2c/busses/i2c-aspeed.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index f51702d86a90..31268074c422 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -504,7 +504,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 			goto error_and_stop;
 		}
 		irq_handled |= ASPEED_I2CD_INTR_TX_ACK;
-		/* fall through */
+		fallthrough;
 	case ASPEED_I2C_MASTER_TX_FIRST:
 		if (bus->buf_index < msg->len) {
 			bus->master_state = ASPEED_I2C_MASTER_TX;
@@ -520,7 +520,7 @@ static u32 aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 		/* RX may not have completed yet (only address cycle) */
 		if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE))
 			goto out_no_complete;
-		/* fall through */
+		fallthrough;
 	case ASPEED_I2C_MASTER_RX:
 		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
 			dev_err(bus->dev, "master failed to RX\n");
-- 
2.27.0

