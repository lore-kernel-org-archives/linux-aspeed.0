From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed,  4 Oct 2023 00:16:06 -0700
Subject: [PATCH] pinctrl: aspeed: Allow changing hardware strap defaults
Message-ID: <20231004071605.21323-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Previously we've generally assumed that the defaults in the hardware
strapping register are in fact appropriate for the system and thus
have avoided making any changes to its contents (with the exception of
the bits controlling the GPIO passthrough feature).

Unfortunately, on some platforms corrections from software are
required as the hardware strapping is simply incorrect for the system
(such as the SPI1 interface being configured for passthrough mode when
master mode is in fact the only useful configuration for it).  We thus
remove the checks preventing changes to the strap register so that the
pinctrl subsystem can be used for such corrections.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 21 ---------------------
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 21 ---------------------
 drivers/pinctrl/aspeed/pinmux-aspeed.h     |  3 ---
 3 files changed, 45 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index bfed0e274643..7ecfe3e4280e 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -2556,27 +2556,6 @@ static int aspeed_g4_sig_expr_set(struct aspeed_pinmux_data *ctx,
 		if (!ctx->maps[desc->ip])
 			return -ENODEV;
 
-		/*
-		 * Strap registers are configured in hardware or by early-boot
-		 * firmware. Treat them as read-only despite that we can write
-		 * them. This may mean that certain functions cannot be
-		 * deconfigured and is the reason we re-evaluate after writing
-		 * all descriptor bits.
-		 *
-		 * Port D and port E GPIO loopback modes are the only exception
-		 * as those are commonly used with front-panel buttons to allow
-		 * normal operation of the host when the BMC is powered off or
-		 * fails to boot. Once the BMC has booted, the loopback mode
-		 * must be disabled for the BMC to control host power-on and
-		 * reset.
-		 */
-		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1 &&
-		    !(desc->mask & (BIT(21) | BIT(22))))
-			continue;
-
-		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
-			continue;
-
 		ret = regmap_update_bits(ctx->maps[desc->ip], desc->reg,
 					 desc->mask, val);
 
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 4c0d26606b6c..3e57e76c2eb7 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2735,27 +2735,6 @@ static int aspeed_g5_sig_expr_set(struct aspeed_pinmux_data *ctx,
 			return PTR_ERR(map);
 		}
 
-		/*
-		 * Strap registers are configured in hardware or by early-boot
-		 * firmware. Treat them as read-only despite that we can write
-		 * them. This may mean that certain functions cannot be
-		 * deconfigured and is the reason we re-evaluate after writing
-		 * all descriptor bits.
-		 *
-		 * Port D and port E GPIO loopback modes are the only exception
-		 * as those are commonly used with front-panel buttons to allow
-		 * normal operation of the host when the BMC is powered off or
-		 * fails to boot. Once the BMC has booted, the loopback mode
-		 * must be disabled for the BMC to control host power-on and
-		 * reset.
-		 */
-		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1 &&
-		    !(desc->mask & (BIT(21) | BIT(22))))
-			continue;
-
-		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
-			continue;
-
 		/* On AST2500, Set bits in SCU70 are cleared from SCU7C */
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1) {
 			u32 value = ~val & desc->mask;
diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index aaa78a613196..e9068acd5879 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -16,9 +16,6 @@
  * bits. Some difficulty arises as the pin's function bit masks for each
  * priority level are frequently not the same (i.e. cannot just flip a bit to
  * change from a high to low priority signal), or even in the same register.
- * Further, not all signals can be unmuxed, as some expressions depend on
- * values in the hardware strapping register (which may be treated as
- * read-only).
  *
  * SoC Multi-function Pin Expression Examples
  * ------------------------------------------
-- 
2.42.0

