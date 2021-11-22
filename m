From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:53:58 +0100
Subject: [PATCH/RFC 05/17] bus: omap_l3_noc: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <8f5ac0ff643fcfe29ba671b434c57d88524f0450.1637592133.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the field_get() bitfield helper, instead of open-coding the same
operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
Marked RFC, as this depends on [PATCH 01/17], but follows a different
path to upstream.
---
 drivers/bus/omap_l3_noc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index dcfb32ee5cb60239..1a692c86d085f43e 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -14,6 +14,7 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/bitfield.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -118,8 +119,7 @@ static int l3_handle_target(struct omap_l3 *l3, void __iomem *base,
 	}
 
 	/* STDERRLOG_MSTADDR Stores the NTTP master address. */
-	masterid = (readl_relaxed(l3_targ_mstaddr) &
-		    l3->mst_addr_mask) >> __ffs(l3->mst_addr_mask);
+	masterid = field_get(l3->mst_addr_mask, readl_relaxed(l3_targ_mstaddr));
 
 	for (k = 0, master = l3->l3_masters; k < l3->num_masters;
 	     k++, master++) {
-- 
2.25.1

