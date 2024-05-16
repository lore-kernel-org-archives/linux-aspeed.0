From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:18:29 -0500
Subject: [PATCH v3 02/40] fsi: Move slave definitions to fsi-slave.h
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-3-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Master drivers may need access to the slave definitions.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c  | 35 -----------------
 drivers/fsi/fsi-slave.h | 84 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 35 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 097d5a780264c..7bf0c96fc0172 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -45,41 +45,6 @@
 
 static const int engine_page_size = 0x400;
 
-#define FSI_SLAVE_BASE			0x800
-
-/*
- * FSI slave engine control register offsets
- */
-#define FSI_SMODE		0x0	/* R/W: Mode register */
-#define FSI_SISC		0x8	/* R/W: Interrupt condition */
-#define FSI_SSTAT		0x14	/* R  : Slave status */
-#define FSI_SLBUS		0x30	/* W  : LBUS Ownership */
-#define FSI_LLMODE		0x100	/* R/W: Link layer mode register */
-
-/*
- * SMODE fields
- */
-#define FSI_SMODE_WSC		0x80000000	/* Warm start done */
-#define FSI_SMODE_ECRC		0x20000000	/* Hw CRC check */
-#define FSI_SMODE_SID_SHIFT	24		/* ID shift */
-#define FSI_SMODE_SID_MASK	3		/* ID Mask */
-#define FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
-#define FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
-#define FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
-#define FSI_SMODE_SD_MASK	0xf		/* Send delay mask */
-#define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
-#define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
-
-/*
- * SLBUS fields
- */
-#define FSI_SLBUS_FORCE		0x80000000	/* Force LBUS ownership */
-
-/*
- * LLMODE fields
- */
-#define FSI_LLMODE_ASYNC	0x1
-
 #define FSI_SLAVE_SIZE_23b		0x800000
 
 static DEFINE_IDA(master_ida);
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index 1d63a585829dd..dba65bd4e083f 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -7,6 +7,90 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 
+#define FSI_SLAVE_BASE			0x800
+
+/*
+ * FSI slave engine control register offsets
+ */
+#define FSI_SMODE		0x0	/* R/W: Mode register */
+#define FSI_SISC		0x8	/* R  : Interrupt condition */
+#define FSI_SCISC		0x8	/* C  : Clear interrupt condition */
+#define FSI_SISM		0xc	/* R/W: Interrupt mask */
+#define FSI_SISS		0x10	/* R  : Interrupt status */
+#define FSI_SSISM		0x10	/* S  : Set interrupt mask */
+#define FSI_SCISM		0x14	/* C  : Clear interrupt mask */
+#define FSI_SSTAT		0x14	/* R  : Slave status */
+#define FSI_SI1S		0x1c	/* R  : Slave interrupt 1 status */
+#define FSI_SSI1M		0x1c	/* S  : Set slave interrupt 1 mask */
+#define FSI_SCI1M		0x20	/* C  : Clear slave interrupt 1 mask */
+#define FSI_SLBUS		0x30	/* W  : LBUS Ownership */
+#define FSI_SRSIC0		0x68	/* C  : Clear remote interrupt condition */
+#define FSI_SRSIC4		0x6c	/* C  : Clear remote interrupt condition */
+#define FSI_SRSIM0		0x70	/* R/W: Remote interrupt mask */
+#define FSI_SRSIM4		0x74	/* R/W: Remote interrupt mask */
+#define FSI_SRSIS0		0x78	/* R  : Remote interrupt status */
+#define FSI_SRSIS4		0x7c	/* R  : Remote interrupt status */
+#define FSI_LLMODE		0x100	/* R/W: Link layer mode register */
+
+/*
+ * SMODE fields
+ */
+#define FSI_SMODE_WSC		0x80000000	/* Warm start done */
+#define FSI_SMODE_ECRC		0x20000000	/* Hw CRC check */
+#define FSI_SMODE_SID_SHIFT	24		/* ID shift */
+#define FSI_SMODE_SID_MASK	3		/* ID Mask */
+#define FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
+#define FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
+#define FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
+#define FSI_SMODE_SD_MASK	0xf		/* Send delay mask */
+#define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
+#define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
+
+/*
+ * SISS fields
+ */
+#define FSI_SISS_CRC_ERROR		BIT(31)
+#define FSI_SISS_PROTO_ERROR		BIT(30)
+#define FSI_SISS_LBUS_PARITY_ERROR	BIT(29)
+#define FSI_SISS_LBUS_PROTO_ERROR	BIT(28)
+#define FSI_SISS_ACCESS_ERROR		BIT(27)
+#define FSI_SISS_LBUS_OWNERSHIP_ERROR	BIT(26)
+#define FSI_SISS_LBUS_OWNERSHIP_CHANGE	BIT(25)
+#define FSI_SISS_ASYNC_MODE_ERROR	BIT(14)
+#define FSI_SISS_OPB_ACCESS_ERROR	BIT(13)
+#define FSI_SISS_OPB_FENCED		BIT(12)
+#define FSI_SISS_OPB_PARITY_ERROR	BIT(11)
+#define FSI_SISS_OPB_PROTO_ERROR	BIT(10)
+#define FSI_SISS_OPB_TIMEOUT		BIT(9)
+#define FSI_SISS_OPB_ERROR_ACK		BIT(8)
+#define FSI_SISS_MFSI_MASTER_ERROR	BIT(3)
+#define FSI_SISS_MFSI_PORT_ERROR	BIT(2)
+#define FSI_SISS_MFSI_HP		BIT(1)
+#define FSI_SISS_MFSI_CR_PARITY_ERROR	BIT(0)
+#define FSI_SISS_ALL			0xfe007f00
+
+/*
+ * SI1S fields
+ */
+#define FSI_SI1S_SLAVE_BIT	31
+#define FSI_SI1S_SHIFT_BIT	30
+#define FSI_SI1S_SCOM_BIT	29
+#define FSI_SI1S_SCRATCH_BIT	28
+#define FSI_SI1S_I2C_BIT	27
+#define FSI_SI1S_SPI_BIT	26
+#define FSI_SI1S_SBEFIFO_BIT	25
+#define FSI_SI1S_MBOX_BIT	24
+
+/*
+ * SLBUS fields
+ */
+#define FSI_SLBUS_FORCE		0x80000000	/* Force LBUS ownership */
+
+/*
+ * LLMODE fields
+ */
+#define FSI_LLMODE_ASYNC	0x1
+
 struct fsi_master;
 
 struct fsi_slave {
-- 
2.39.3

