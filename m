From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:18:35 -0500
Subject: [PATCH v3 08/40] fsi: core: Reset errors instead of clearing interrupts
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-9-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The proper way to clear error conditions is to use the SRES
register rather than simple clearing SISC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c  | 9 +++++----
 drivers/fsi/fsi-slave.h | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 93bbdcf50a89a..ce9762d1bd8b0 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -166,7 +166,7 @@ static int fsi_slave_calc_addr(struct fsi_slave *slave, uint32_t *addrp,
 static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 {
 	struct fsi_master *master = slave->master;
-	__be32 irq, stat;
+	__be32 irq, reset, stat;
 	int rc, link;
 	uint8_t id;
 
@@ -187,9 +187,10 @@ static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 			be32_to_cpu(stat), be32_to_cpu(irq));
 	trace_fsi_slave_error(slave, be32_to_cpu(irq), be32_to_cpu(stat));
 
-	/* clear interrupts */
-	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SISC,
-			&irq, sizeof(irq));
+	/* reset errors */
+	reset = cpu_to_be32(FSI_SRES_ERRS);
+	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SRES, &reset,
+				sizeof(reset));
 }
 
 /* Encode slave local bus echo delay */
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index fabc0b66d5bf3..e9fd4be6f3760 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -24,6 +24,7 @@
 #define FSI_SSI1M		0x1c	/* S  : Set slave interrupt 1 mask */
 #define FSI_SCI1M		0x20	/* C  : Clear slave interrupt 1 mask */
 #define FSI_SLBUS		0x30	/* W  : LBUS Ownership */
+#define FSI_SRES		0x34	/* W  : Reset */
 #define FSI_SRSIC0		0x68	/* C  : Clear remote interrupt condition */
 #define FSI_SRSIC4		0x6c	/* C  : Clear remote interrupt condition */
 #define FSI_SRSIM0		0x70	/* R/W: Remote interrupt mask */
@@ -90,6 +91,11 @@
  */
 #define FSI_SLBUS_FORCE		0x80000000	/* Force LBUS ownership */
 
+/*
+ * SRES fields
+ */
+#define FSI_SRES_ERRS		0x40000000	/* Reset FSI slave errors */
+
 /*
  * LLMODE fields
  */
-- 
2.39.3

