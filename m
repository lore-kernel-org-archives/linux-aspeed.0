From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:39 -0500
Subject: [PATCH v4 07/40] fsi: core: Add slave error trace
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-8-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Trace out the FSI slave status and interrupt status.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c     |  1 +
 include/trace/events/fsi.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index b3029f9c05e4a..93bbdcf50a89a 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -185,6 +185,7 @@ static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 
 	dev_dbg(&slave->dev, "status: 0x%08x, sisc: 0x%08x\n",
 			be32_to_cpu(stat), be32_to_cpu(irq));
+	trace_fsi_slave_error(slave, be32_to_cpu(irq), be32_to_cpu(stat));
 
 	/* clear interrupts */
 	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SISC,
diff --git a/include/trace/events/fsi.h b/include/trace/events/fsi.h
index fed8835f438e5..5509afc98ee8b 100644
--- a/include/trace/events/fsi.h
+++ b/include/trace/events/fsi.h
@@ -115,6 +115,25 @@ TRACE_EVENT(fsi_master_unregister,
 	TP_printk("fsi%d (%d links)", __entry->master_idx, __entry->n_links)
 );
 
+TRACE_EVENT(fsi_slave_error,
+	TP_PROTO(const struct fsi_slave *slave, uint32_t sisc, uint32_t sstat),
+	TP_ARGS(slave, sisc, sstat),
+	TP_STRUCT__entry(
+		__field(int, master_idx)
+		__field(int, link)
+		__field(uint32_t, sisc)
+		__field(uint32_t, sstat)
+	),
+	TP_fast_assign(
+		__entry->master_idx = slave->master->idx;
+		__entry->link = slave->link;
+		__entry->sisc = sisc;
+		__entry->sstat = sstat;
+	),
+	TP_printk("fsi%d:%02d sisc:%08x sstat:%08x", __entry->master_idx, __entry->link,
+		  __entry->sisc, __entry->sstat)
+);
+
 TRACE_EVENT(fsi_slave_init,
 	TP_PROTO(const struct fsi_slave *slave),
 	TP_ARGS(slave),
-- 
2.39.3

