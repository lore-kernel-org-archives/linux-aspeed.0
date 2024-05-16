From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:18:57 -0500
Subject: [PATCH v3 30/40] i2c: fsi: Define a function to check status error bits
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-31-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This will be used more than once with interrupt support, so split
the error bit checks into a function.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/i2c/busses/i2c-fsi.c | 38 ++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
index f3b97bf88d0f9..022f1287aa0e3 100644
--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -507,6 +507,26 @@ static int fsi_i2c_abort(struct fsi_i2c_port *port, u32 status)
 	return -ETIMEDOUT;
 }
 
+static int fsi_i2c_error_status_to_rc(u32 status)
+{
+	if (status & I2C_STAT_INV_CMD)
+		return -EINVAL;
+
+	if (status & (I2C_STAT_PARITY | I2C_STAT_BE_OVERRUN | I2C_STAT_BE_ACCESS))
+		return -EPROTO;
+
+	if (status & I2C_STAT_NACK)
+		return -ENXIO;
+
+	if (status & I2C_STAT_LOST_ARB)
+		return -EAGAIN;
+
+	if (status & I2C_STAT_STOP_ERR)
+		return -EBADMSG;
+
+	return -EIO;
+}
+
 static int fsi_i2c_handle_status(struct fsi_i2c_port *port,
 				 struct i2c_msg *msg, u32 status)
 {
@@ -518,23 +538,7 @@ static int fsi_i2c_handle_status(struct fsi_i2c_port *port,
 		if (rc)
 			return rc;
 
-		if (status & I2C_STAT_INV_CMD)
-			return -EINVAL;
-
-		if (status & (I2C_STAT_PARITY | I2C_STAT_BE_OVERRUN |
-		    I2C_STAT_BE_ACCESS))
-			return -EPROTO;
-
-		if (status & I2C_STAT_NACK)
-			return -ENXIO;
-
-		if (status & I2C_STAT_LOST_ARB)
-			return -EAGAIN;
-
-		if (status & I2C_STAT_STOP_ERR)
-			return -EBADMSG;
-
-		return -EIO;
+		return fsi_i2c_error_status_to_rc(status);
 	}
 
 	if (status & I2C_STAT_DAT_REQ) {
-- 
2.39.3

