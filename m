From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Jun 2018 14:31:22 +1000
Subject: [RFC PATCH 02/14] fsi: Move code around to avoid forward declaration
In-Reply-To: <20180622043134.18238-1-benh@kernel.crashing.org>
References: <20180622043134.18238-1-benh@kernel.crashing.org>
Message-ID: <20180622043134.18238-3-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Move fsi_slave_set_smode() and its helpers to before it's
first user and remove the corresponding forward declaration.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-core.c | 94 +++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 565218872635..2f6f9b8c75e4 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -215,7 +215,52 @@ static int fsi_slave_report_and_clear_errors(struct fsi_slave *slave)
 			&irq, sizeof(irq));
 }
 
-static int fsi_slave_set_smode(struct fsi_master *master, int link, int id);
+/* Encode slave local bus echo delay */
+static inline uint32_t fsi_smode_echodly(int x)
+{
+	return (x & FSI_SMODE_ED_MASK) << FSI_SMODE_ED_SHIFT;
+}
+
+/* Encode slave local bus send delay */
+static inline uint32_t fsi_smode_senddly(int x)
+{
+	return (x & FSI_SMODE_SD_MASK) << FSI_SMODE_SD_SHIFT;
+}
+
+/* Encode slave local bus clock rate ratio */
+static inline uint32_t fsi_smode_lbcrr(int x)
+{
+	return (x & FSI_SMODE_LBCRR_MASK) << FSI_SMODE_LBCRR_SHIFT;
+}
+
+/* Encode slave ID */
+static inline uint32_t fsi_smode_sid(int x)
+{
+	return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
+}
+
+static uint32_t fsi_slave_smode(int id)
+{
+	return FSI_SMODE_WSC | FSI_SMODE_ECRC
+		| fsi_smode_sid(id)
+		| fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
+		| fsi_smode_lbcrr(0x8);
+}
+
+static int fsi_slave_set_smode(struct fsi_master *master, int link, int id)
+{
+	uint32_t smode;
+	__be32 data;
+
+	/* set our smode register with the slave ID field to 0; this enables
+	 * extended slave addressing
+	 */
+	smode = fsi_slave_smode(id);
+	data = cpu_to_be32(smode);
+
+	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SMODE,
+			&data, sizeof(data));
+}
 
 static int fsi_slave_handle_error(struct fsi_slave *slave, bool write,
 				  uint32_t addr, size_t size)
@@ -569,53 +614,6 @@ static const struct bin_attribute fsi_slave_term_attr = {
 	.write = fsi_slave_sysfs_term_write,
 };
 
-/* Encode slave local bus echo delay */
-static inline uint32_t fsi_smode_echodly(int x)
-{
-	return (x & FSI_SMODE_ED_MASK) << FSI_SMODE_ED_SHIFT;
-}
-
-/* Encode slave local bus send delay */
-static inline uint32_t fsi_smode_senddly(int x)
-{
-	return (x & FSI_SMODE_SD_MASK) << FSI_SMODE_SD_SHIFT;
-}
-
-/* Encode slave local bus clock rate ratio */
-static inline uint32_t fsi_smode_lbcrr(int x)
-{
-	return (x & FSI_SMODE_LBCRR_MASK) << FSI_SMODE_LBCRR_SHIFT;
-}
-
-/* Encode slave ID */
-static inline uint32_t fsi_smode_sid(int x)
-{
-	return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
-}
-
-static uint32_t fsi_slave_smode(int id)
-{
-	return FSI_SMODE_WSC | FSI_SMODE_ECRC
-		| fsi_smode_sid(id)
-		| fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
-		| fsi_smode_lbcrr(0x8);
-}
-
-static int fsi_slave_set_smode(struct fsi_master *master, int link, int id)
-{
-	uint32_t smode;
-	__be32 data;
-
-	/* set our smode register with the slave ID field to 0; this enables
-	 * extended slave addressing
-	 */
-	smode = fsi_slave_smode(id);
-	data = cpu_to_be32(smode);
-
-	return fsi_master_write(master, link, id, FSI_SLAVE_BASE + FSI_SMODE,
-			&data, sizeof(data));
-}
-
 static void fsi_slave_release(struct device *dev)
 {
 	struct fsi_slave *slave = to_fsi_slave(dev);
-- 
2.17.1

