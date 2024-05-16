From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:18:55 -0500
Subject: [PATCH v3 28/40] i2c: fsi: Change fsi_i2c_write_reg to accept data instead of a pointer
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-29-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There's no use passing a pointer here.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 47 +++++++++++++++---------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index 8fb5b51b74a4d..44aa750278100 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -177,9 +177,9 @@ static int fsi_i2c_read_reg(struct fsi_device *fsi, unsigned int reg,
 }
 
 static int fsi_i2c_write_reg(struct fsi_device *fsi, unsigned int reg,
-			     u32 *data)
+			     u32 data)
 {
-	__be32 data_be = cpu_to_be32p(data);
+	__be32 data_be = cpu_to_be32(data);
 
 	return fsi_device_write(fsi, reg, &data_be, sizeof(data_be));
 }
@@ -188,17 +188,16 @@ static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
 {
 	u32 mode = I2C_MODE_ENHANCED;
 	u32 extended_status;
-	u32 interrupt = 0;
 	u32 watermark;
 	int rc;
 
 	/* since we use polling, disable interrupts */
-	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_INT_MASK, &interrupt);
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_INT_MASK, 0);
 	if (rc)
 		return rc;
 
 	mode |= FIELD_PREP(I2C_MODE_CLKDIV, i2c->clock_div);
-	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, mode);
 	if (rc)
 		return rc;
 
@@ -211,13 +210,12 @@ static int fsi_i2c_dev_init(struct fsi_i2c_master *i2c)
 			       i2c->fifo_size - I2C_FIFO_HI_LVL);
 	watermark |= FIELD_PREP(I2C_WATERMARK_LO, I2C_FIFO_LO_LVL);
 
-	return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_WATER_MARK, &watermark);
+	return fsi_i2c_write_reg(i2c->fsi, I2C_FSI_WATER_MARK, watermark);
 }
 
 static int fsi_i2c_set_port(struct fsi_i2c_port *port)
 {
 	struct fsi_device *fsi = port->master->fsi;
-	u32 dummy = 0;
 	u32 mode;
 	int rc;
 
@@ -229,12 +227,12 @@ static int fsi_i2c_set_port(struct fsi_i2c_port *port)
 		return 0;
 
 	mode = (mode & ~I2C_MODE_PORT) | FIELD_PREP(I2C_MODE_PORT, port->port);
-	rc = fsi_i2c_write_reg(fsi, I2C_FSI_MODE, &mode);
+	rc = fsi_i2c_write_reg(fsi, I2C_FSI_MODE, mode);
 	if (rc)
 		return rc;
 
 	/* reset engine when port is changed */
-	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, &dummy);
+	return fsi_i2c_write_reg(fsi, I2C_FSI_RESET_ERR, 0);
 }
 
 static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
@@ -253,7 +251,7 @@ static int fsi_i2c_start(struct fsi_i2c_port *port, struct i2c_msg *msg,
 	cmd |= FIELD_PREP(I2C_CMD_ADDR, msg->addr);
 	cmd |= FIELD_PREP(I2C_CMD_LEN, msg->len);
 
-	return fsi_i2c_write_reg(port->master->fsi, I2C_FSI_CMD, &cmd);
+	return fsi_i2c_write_reg(port->master->fsi, I2C_FSI_CMD, cmd);
 }
 
 static int fsi_i2c_get_op_bytes(int op_bytes)
@@ -340,12 +338,11 @@ static int fsi_i2c_get_scl(struct i2c_adapter *adap)
 static void fsi_i2c_set_scl(struct i2c_adapter *adap, int val)
 {
 	struct fsi_i2c_port *port = adap->algo_data;
-	u32 dummy = 0;
 
 	if (val)
-		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_SET_SCL, &dummy);
+		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_SET_SCL, 0);
 	else
-		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_RESET_SCL, &dummy);
+		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_RESET_SCL, 0);
 }
 
 static int fsi_i2c_get_sda(struct i2c_adapter *adap)
@@ -361,12 +358,11 @@ static int fsi_i2c_get_sda(struct i2c_adapter *adap)
 static void fsi_i2c_set_sda(struct i2c_adapter *adap, int val)
 {
 	struct fsi_i2c_port *port = adap->algo_data;
-	u32 dummy = 0;
 
 	if (val)
-		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_SET_SDA, &dummy);
+		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_SET_SDA, 0);
 	else
-		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_RESET_SDA, &dummy);
+		fsi_i2c_write_reg(port->master->fsi, I2C_FSI_RESET_SDA, 0);
 }
 
 static void fsi_i2c_prepare_recovery(struct i2c_adapter *adap)
@@ -380,7 +376,7 @@ static void fsi_i2c_prepare_recovery(struct i2c_adapter *adap)
 		return;
 
 	mode |= I2C_MODE_DIAG;
-	fsi_i2c_write_reg(port->master->fsi, I2C_FSI_MODE, &mode);
+	fsi_i2c_write_reg(port->master->fsi, I2C_FSI_MODE, mode);
 }
 
 static void fsi_i2c_unprepare_recovery(struct i2c_adapter *adap)
@@ -394,13 +390,12 @@ static void fsi_i2c_unprepare_recovery(struct i2c_adapter *adap)
 		return;
 
 	mode &= ~I2C_MODE_DIAG;
-	fsi_i2c_write_reg(port->master->fsi, I2C_FSI_MODE, &mode);
+	fsi_i2c_write_reg(port->master->fsi, I2C_FSI_MODE, mode);
 }
 
 static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c,
 			     struct fsi_i2c_port *port)
 {
-	u32 dummy = 0;
 	u32 stat;
 	int rc;
 
@@ -408,7 +403,7 @@ static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c,
 	i2c_recover_bus(&port->adapter);
 
 	/* reset errors */
-	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, &dummy);
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_ERR, 0);
 	if (rc)
 		return rc;
 
@@ -423,7 +418,7 @@ static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c,
 		return 0;
 
 	/* failed to get command complete; reset engine again */
-	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, &dummy);
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, 0);
 	if (rc)
 		return rc;
 
@@ -433,12 +428,11 @@ static int fsi_i2c_reset_bus(struct fsi_i2c_master *i2c,
 
 static int fsi_i2c_reset_engine(struct fsi_i2c_master *i2c, u16 port)
 {
-	u32 dummy = 0;
 	u32 mode;
 	int rc;
 
 	/* reset engine */
-	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, &dummy);
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_RESET_I2C, 0);
 	if (rc)
 		return rc;
 
@@ -455,14 +449,13 @@ static int fsi_i2c_reset_engine(struct fsi_i2c_master *i2c, u16 port)
 	if (port) {
 		mode &= ~I2C_MODE_PORT;
 		mode |= FIELD_PREP(I2C_MODE_PORT, port);
-		rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, &mode);
+		rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_MODE, mode);
 		if (rc)
 			return rc;
 	}
 
 	/* reset busy register; hw workaround */
-	dummy = I2C_PORT_BUSY_RESET;
-	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_PORT_BUSY, &dummy);
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_PORT_BUSY, I2C_PORT_BUSY_RESET);
 	if (rc)
 		return rc;
 
@@ -497,7 +490,7 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
 		return 0;
 
 	/* write stop command */
-	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_CMD, &cmd);
+	rc = fsi_i2c_write_reg(i2c->fsi, I2C_FSI_CMD, cmd);
 	if (rc)
 		return rc;
 
-- 
2.39.3

