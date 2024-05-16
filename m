From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:18:44 -0500
Subject: [PATCH v3 17/40] fsi: aspeed: Refactor trace functions
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-18-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove the opb error trace, add a timeout trace, and combine the
read/write traces.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-master-aspeed.c          | 29 +++------
 include/trace/events/fsi_master_aspeed.h | 80 ++++++++----------------
 2 files changed, 34 insertions(+), 75 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 29932037c9866..04aa5cb9b6fad 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -122,16 +122,17 @@ static int __opb_write(struct fsi_master_aspeed *aspeed, u32 addr,
 
 	status = readl(base + OPB0_STATUS);
 
-	trace_fsi_master_aspeed_opb_write(addr, val, transfer_size, status, reg);
-
 	/* Return error when poll timed out */
-	if (ret)
+	if (ret) {
+		trace_fsi_master_aspeed_timeout(reg, status, false);
 		return ret;
+	}
 
 	/* Command failed, master will reset */
 	if (status & STATUS_ERR_ACK)
 		return -EIO;
 
+	trace_fsi_master_aspeed_opb_xfer(addr, transfer_size + 1, val, false);
 	return 0;
 }
 
@@ -175,13 +176,11 @@ static int __opb_read(struct fsi_master_aspeed *aspeed, uint32_t addr,
 
 	result = readl(base + OPB0_FSI_DATA_R);
 
-	trace_fsi_master_aspeed_opb_read(addr, transfer_size, result,
-			readl(base + OPB0_STATUS),
-			reg);
-
 	/* Return error when poll timed out */
-	if (ret)
+	if (ret) {
+		trace_fsi_master_aspeed_timeout(reg, status, true);
 		return ret;
+	}
 
 	/* Command failed, master will reset */
 	if (status & STATUS_ERR_ACK)
@@ -204,6 +203,7 @@ static int __opb_read(struct fsi_master_aspeed *aspeed, uint32_t addr,
 
 	}
 
+	trace_fsi_master_aspeed_opb_xfer(addr, transfer_size + 1, result, true);
 	return 0;
 }
 
@@ -226,19 +226,6 @@ static int check_errors(struct fsi_master_aspeed *aspeed, int err)
 {
 	int ret;
 
-	if (trace_fsi_master_aspeed_opb_error_enabled()) {
-		__be32 mresp0, mstap0, mesrb0;
-
-		opb_readl(aspeed, ctrl_base + FSI_MRESP0, &mresp0);
-		opb_readl(aspeed, ctrl_base + FSI_MSTAP0, &mstap0);
-		opb_readl(aspeed, ctrl_base + FSI_MESRB0, &mesrb0);
-
-		trace_fsi_master_aspeed_opb_error(
-				be32_to_cpu(mresp0),
-				be32_to_cpu(mstap0),
-				be32_to_cpu(mesrb0));
-	}
-
 	if (err == -EIO) {
 		/* Check MAEB (0x70) ? */
 
diff --git a/include/trace/events/fsi_master_aspeed.h b/include/trace/events/fsi_master_aspeed.h
index 0fff873775f19..7eeecbfec7f09 100644
--- a/include/trace/events/fsi_master_aspeed.h
+++ b/include/trace/events/fsi_master_aspeed.h
@@ -8,69 +8,41 @@
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(fsi_master_aspeed_opb_read,
-	TP_PROTO(uint32_t addr, size_t size, uint32_t result, uint32_t status, uint32_t irq_status),
-	TP_ARGS(addr, size, result, status, irq_status),
+TRACE_EVENT(fsi_master_aspeed_opb_xfer,
+	TP_PROTO(uint32_t addr, uint32_t size, uint32_t data, bool read),
+	TP_ARGS(addr, size, data, read),
 	TP_STRUCT__entry(
-		__field(uint32_t,  addr)
-		__field(size_t,    size)
-		__field(uint32_t,  result)
-		__field(uint32_t,  status)
-		__field(uint32_t,  irq_status)
-		),
+		__field(uint32_t, addr)
+		__field(uint32_t, size)
+		__field(uint32_t, data)
+		__field(bool, read)
+	),
 	TP_fast_assign(
 		__entry->addr = addr;
 		__entry->size = size;
-		__entry->result = result;
-		__entry->status = status;
-		__entry->irq_status = irq_status;
-		),
-	TP_printk("addr %08x size %zu: result %08x sts: %08x irq_sts: %08x",
-		__entry->addr, __entry->size, __entry->result,
-		__entry->status, __entry->irq_status
-	   )
+		__entry->data = data;
+		__entry->read = read;
+	),
+	TP_printk("%s addr %08x size %u data %08x", __entry->read ? "read" : "write",
+		  __entry->addr, __entry->size, __entry->data)
 );
 
-TRACE_EVENT(fsi_master_aspeed_opb_write,
-	TP_PROTO(uint32_t addr, uint32_t val, size_t size, uint32_t status, uint32_t irq_status),
-	TP_ARGS(addr, val, size, status, irq_status),
+TRACE_EVENT(fsi_master_aspeed_timeout,
+	TP_PROTO(uint32_t irq, uint32_t status, bool read),
+	TP_ARGS(irq, status, read),
 	TP_STRUCT__entry(
-		__field(uint32_t,    addr)
-		__field(uint32_t,    val)
-		__field(size_t,    size)
-		__field(uint32_t,  status)
-		__field(uint32_t,  irq_status)
-		),
+		__field(uint32_t, irq)
+		__field(uint32_t, status)
+		__field(bool, read)
+	),
 	TP_fast_assign(
-		__entry->addr = addr;
-		__entry->val = val;
-		__entry->size = size;
+		__entry->irq = irq;
 		__entry->status = status;
-		__entry->irq_status = irq_status;
-		),
-	TP_printk("addr %08x val %08x size %zu status: %08x irq_sts: %08x",
-		__entry->addr, __entry->val, __entry->size,
-		__entry->status, __entry->irq_status
-		)
-	);
-
-TRACE_EVENT(fsi_master_aspeed_opb_error,
-	TP_PROTO(uint32_t mresp0, uint32_t mstap0, uint32_t mesrb0),
-	TP_ARGS(mresp0, mstap0, mesrb0),
-	TP_STRUCT__entry(
-		__field(uint32_t,  mresp0)
-		__field(uint32_t,  mstap0)
-		__field(uint32_t,  mesrb0)
-		),
-	TP_fast_assign(
-		__entry->mresp0 = mresp0;
-		__entry->mstap0 = mstap0;
-		__entry->mesrb0 = mesrb0;
-		),
-	TP_printk("mresp0 %08x mstap0 %08x mesrb0 %08x",
-		__entry->mresp0, __entry->mstap0, __entry->mesrb0
-		)
-	);
+		__entry->read = read;
+	),
+	TP_printk("%s irq %08x status %08x", __entry->read ? "read" : "write", __entry->irq,
+		  __entry->status)
+);
 
 TRACE_EVENT(fsi_master_aspeed_cfam_reset,
 	TP_PROTO(bool start),
-- 
2.39.3

