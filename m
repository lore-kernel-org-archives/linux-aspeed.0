From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:23:03 -0500
Subject: [PATCH v4 31/40] i2c: fsi: Add boolean for skip stop command on abort
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-32-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In preparation for interrupt support, store whether to skip the
final stop command during the abort procedure instead of checking
the previously read status register in the abort function.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 022f1287aa0e3..614d830419bb8 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -116,6 +116,9 @@
 #define I2C_STAT_ANY_RESP	(I2C_STAT_ERR |				\
 				 I2C_STAT_DAT_REQ |			\
 				 I2C_STAT_CMD_COMP)
+#define I2C_STAT_SKIP_STOP	(I2C_STAT_PARITY |			\
+				 I2C_STAT_LOST_ARB |			\
+				 I2C_STAT_STOP_ERR)
 
 /* extended status register */
 #define I2C_ESTAT_FIFO_SZ	GENMASK(31, 24)
@@ -150,6 +153,7 @@ struct fsi_i2c_master {
 	struct mutex		lock;
 	u32			clock_div;
 	u8			fifo_size;
+	bool			skip_stop;
 };
 
 struct fsi_i2c_port {
@@ -459,31 +463,30 @@ static int fsi_i2c_reset_engine(struct fsi_i2c_master *i2c, u16 port)
 	return 0;
 }
 
-static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
+static int fsi_i2c_abort(struct fsi_i2c_port *port)
 {
 	struct fsi_i2c_master *i2c = port->master;
 	u32 cmd = I2C_CMD_WITH_STOP;
 	unsigned long start;
-	u32 stat;
+	u32 status;
 	int rc;
 
 	rc = fsi_i2c_reset_engine(i2c, port->port);
 	if (rc)
 		return rc;
 
-	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &stat);
+	rc = fsi_i2c_read_reg(i2c->fsi, I2C_FSI_STAT, &status);
 	if (rc)
 		return rc;
 
 	/* if sda is low, peform full bus reset */
-	if (!(stat & I2C_STAT_SDA_IN)) {
+	if (!(status & I2C_STAT_SDA_IN)) {
 		rc = fsi_i2c_reset_bus(i2c, port);
 		if (rc)
 			return rc;
 	}
 
-	/* skip final stop command for these errors */
-	if (status & (I2C_STAT_PARITY | I2C_STAT_LOST_ARB | I2C_STAT_STOP_ERR))
+	if (i2c->skip_stop)
 		return 0;
 
 	/* write stop command */
@@ -534,7 +537,8 @@ static int fsi_i2c_handle_status(struct fsi_i2c_port *port,
 	int rc;
 
 	if (status & I2C_STAT_ERR) {
-		rc = fsi_i2c_abort(port, status);
+		port->master->skip_stop = status & I2C_STAT_SKIP_STOP;
+		rc = fsi_i2c_abort(port);
 		if (rc)
 			return rc;
 
-- 
2.39.3

