From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:54:08 +0100
Subject: [PATCH/RFC 15/17] thermal/ti-soc-thermal: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <37efc6013a24653e316215424b160d613f42dcd5.1637592133.git.geert+renesas@glider.be>
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
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index ea0603b59309f5f0..83a34d698414b177 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -9,6 +9,7 @@
  *   Eduardo Valentin <eduardo.valentin@ti.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/cpu_pm.h>
 #include <linux/device.h>
@@ -80,10 +81,10 @@ do {								\
 	struct temp_sensor_registers *t;			\
 	u32 r;							\
 								\
-	t = bgp->conf->sensors[(id)].registers;		\
+	t = bgp->conf->sensors[(id)].registers;			\
 	r = ti_bandgap_readl(bgp, t->reg);			\
 	r &= ~t->mask;						\
-	r |= (val) << __ffs(t->mask);				\
+	r |= field_prep(t->mask, val);				\
 	ti_bandgap_writel(bgp, r, t->reg);			\
 } while (0)
 
@@ -342,8 +343,7 @@ static void ti_bandgap_read_counter(struct ti_bandgap *bgp, int id,
 
 	tsr = bgp->conf->sensors[id].registers;
 	time = ti_bandgap_readl(bgp, tsr->bgap_counter);
-	time = (time & tsr->counter_mask) >>
-					__ffs(tsr->counter_mask);
+	time = field_get(tsr->counter_mask, time);
 	time = time * 1000 / bgp->clk_rate;
 	*interval = time;
 }
@@ -363,8 +363,7 @@ static void ti_bandgap_read_counter_delay(struct ti_bandgap *bgp, int id,
 	tsr = bgp->conf->sensors[id].registers;
 
 	reg_val = ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
-	reg_val = (reg_val & tsr->mask_counter_delay_mask) >>
-				__ffs(tsr->mask_counter_delay_mask);
+	reg_val = field_get(tsr->mask_counter_delay_mask, reg_val);
 	switch (reg_val) {
 	case 0:
 		*interval = 0;
-- 
2.25.1

