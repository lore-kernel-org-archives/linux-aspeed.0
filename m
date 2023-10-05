From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed,  4 Oct 2023 20:08:50 -0700
Subject: [PATCH v2] pinctrl: aspeed: Allow changing SPI mode from hardware strap defaults
Message-ID: <20231005030849.11352-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some platforms unfortunately have their SPI mode selection bits
strapped incorrectly (such as being configured for passthrough mode
when master mode is in fact the only useful configuration for it) and
thus require correction in software.  Add the SPI mode bits to the
GPIO passthrough bits as the exceptions to the read-only rule for the
hardware strap register so that the pinctrl subsystem can be used for
such corrections.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

Changes since v1 [1]:
 - Refined to an additional per-bit exception instead of allowing
   arbitrary strap register alterations [Andrew]

[1] https://lore.kernel.org/lkml/20231004071605.21323-2-zev at bewilderbeest.net/

 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 19 ++++++++++++-------
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 19 ++++++++++++-------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index bfed0e274643..774f8d05142f 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -2563,15 +2563,20 @@ static int aspeed_g4_sig_expr_set(struct aspeed_pinmux_data *ctx,
 		 * deconfigured and is the reason we re-evaluate after writing
 		 * all descriptor bits.
 		 *
-		 * Port D and port E GPIO loopback modes are the only exception
-		 * as those are commonly used with front-panel buttons to allow
-		 * normal operation of the host when the BMC is powered off or
-		 * fails to boot. Once the BMC has booted, the loopback mode
-		 * must be disabled for the BMC to control host power-on and
-		 * reset.
+		 * We make two exceptions to the read-only rule:
+		 *
+		 * - The passthrough mode of GPIO ports D and E are commonly
+		 *   used with front-panel buttons to allow normal operation
+		 *   of the host if the BMC is powered off or fails to boot.
+		 *   Once the BMC has booted, the loopback mode must be
+		 *   disabled for the BMC to control host power-on and reset.
+		 *
+		 * - The operating mode of the SPI1 interface is simply
+		 *   strapped incorrectly on some systems and requires a
+		 *   software fixup, which we allow to be done via pinctrl.
 		 */
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1 &&
-		    !(desc->mask & (BIT(21) | BIT(22))))
+		    !(desc->mask & (BIT(22) | BIT(21) | BIT(13) | BIT(12))))
 			continue;
 
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 4c0d26606b6c..5bb8fd0d1e41 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2742,15 +2742,20 @@ static int aspeed_g5_sig_expr_set(struct aspeed_pinmux_data *ctx,
 		 * deconfigured and is the reason we re-evaluate after writing
 		 * all descriptor bits.
 		 *
-		 * Port D and port E GPIO loopback modes are the only exception
-		 * as those are commonly used with front-panel buttons to allow
-		 * normal operation of the host when the BMC is powered off or
-		 * fails to boot. Once the BMC has booted, the loopback mode
-		 * must be disabled for the BMC to control host power-on and
-		 * reset.
+		 * We make two exceptions to the read-only rule:
+		 *
+		 * - The passthrough mode of GPIO ports D and E are commonly
+		 *   used with front-panel buttons to allow normal operation
+		 *   of the host if the BMC is powered off or fails to boot.
+		 *   Once the BMC has booted, the loopback mode must be
+		 *   disabled for the BMC to control host power-on and reset.
+		 *
+		 * - The operating mode of the SPI1 interface is simply
+		 *   strapped incorrectly on some systems and requires a
+		 *   software fixup, which we allow to be done via pinctrl.
 		 */
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1 &&
-		    !(desc->mask & (BIT(21) | BIT(22))))
+		    !(desc->mask & (BIT(22) | BIT(21) | BIT(13) | BIT(12))))
 			continue;
 
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
-- 
2.42.0

