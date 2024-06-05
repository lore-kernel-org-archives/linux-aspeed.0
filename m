From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:45 -0500
Subject: [PATCH v4 13/40] fsi: core: Disable relative addressing during scan
In-Reply-To: <20240605212312.349188-1-eajames@linux.ibm.com>
References: <20240605212312.349188-1-eajames@linux.ibm.com>
Message-ID: <20240605212312.349188-14-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Relative addressing is not allowed during slave ID initialization, so
turn it off during the FSI scan procedure.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index bfb147de90efc..8b402149acbe9 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1223,8 +1223,20 @@ static int fsi_master_break(struct fsi_master *master, int link)
 
 static int fsi_master_scan(struct fsi_master *master)
 {
+	bool set_mmode = false;
 	int link, rc;
 
+	/* relative addressing is not allowed during slave ID initialization */
+	if (master->map && (master->flags & FSI_MASTER_FLAG_RELA)) {
+		u32 mmode = master->mmode & ~FSI_MMODE_RELA;
+
+		rc = regmap_write(master->map, FSI_MMODE, mmode);
+		if (rc)
+			return rc;
+
+		set_mmode = true;
+	}
+
 	trace_fsi_master_scan(master, true);
 	for (link = 0; link < master->n_links; link++) {
 		rc = _fsi_master_link_enable(master, link);
@@ -1246,6 +1258,12 @@ static int fsi_master_scan(struct fsi_master *master)
 			fsi_master_link_disable(master, link);
 	}
 
+	if (set_mmode) {
+		rc = regmap_write(master->map, FSI_MMODE, master->mmode);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
-- 
2.39.3

