From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:54:04 +0100
Subject: [PATCH/RFC 11/17] mmc: sdhci-of-aspeed: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <9e5d21f088c3b571d6a6bdeb8899726f51d5bc47.1637592133.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the field_prep() helper, instead open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
Marked RFC, as this depends on [PATCH 01/17], but follows a different
path to upstream.
---
 drivers/mmc/host/sdhci-of-aspeed.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 6e4e132903a6346b..26ac73aafb2ed55d 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2019 ASPEED Technology Inc. */
 /* Copyright (C) 2019 IBM Corp. */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -131,8 +132,8 @@ aspeed_sdc_set_phase_tap(const struct aspeed_sdhci_tap_desc *desc,
 {
 	reg &= ~(desc->enable_mask | desc->tap_mask);
 	if (enable) {
-		reg |= tap << __ffs(desc->tap_mask);
-		reg |= desc->enable_value << __ffs(desc->enable_mask);
+		reg |= field_prep(desc->tap_mask, tap);
+		reg |= field_prep(desc->enable_mask, desc->enable_value);
 	}
 
 	return reg;
-- 
2.25.1

