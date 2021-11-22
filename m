From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:54:07 +0100
Subject: [PATCH/RFC 14/17] regulator: ti-abb: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <c8508cae36c52c750dbb12493dd44d92fcf51ad4.1637592133.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the field_{get,prep}() helpers, instead of open-coding the same
operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
Marked RFC, as this depends on [PATCH 01/17], but follows a different
path to upstream.
---
 drivers/regulator/ti-abb-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index 2931a0b89bffbf7a..3bc6ca5c382a4273 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -17,6 +17,7 @@
  * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -132,7 +133,7 @@ static inline u32 ti_abb_rmw(u32 mask, u32 value, void __iomem *reg)
 
 	val = readl(reg);
 	val &= ~mask;
-	val |= (value << __ffs(mask)) & mask;
+	val |= field_prep(mask, value);
 	writel(val, reg);
 
 	return val;
@@ -229,7 +230,7 @@ static void ti_abb_program_ldovbb(struct device *dev, const struct ti_abb *abb,
 	case TI_ABB_SLOW_OPP:
 	case TI_ABB_FAST_OPP:
 		val |= abb->ldovbb_override_mask;
-		val |= info->vset << __ffs(abb->ldovbb_vset_mask);
+		val |= field_prep(abb->ldovbb_vset_mask, info->vset);
 		break;
 	}
 
@@ -606,7 +607,7 @@ static int ti_abb_init_table(struct device *dev, struct ti_abb *abb,
 					pname, *volt_table, vset_mask);
 			continue;
 		}
-		info->vset = (efuse_val & vset_mask) >> __ffs(vset_mask);
+		info->vset = field_get(vset_mask, efuse_val);
 		dev_dbg(dev, "[%d]v=%d vset=%x\n", i, *volt_table, info->vset);
 check_abb:
 		switch (info->opp_sel) {
-- 
2.25.1

