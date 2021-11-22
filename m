From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:53:56 +0100
Subject: [PATCH/RFC 03/17] soc: renesas: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <c5025ab8336469110c6d3ef7ccb049e60c34ef42.1637592133.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the field_get() helper, instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH] soc: renesas: Consolidate product register
handling"
(https://lore.kernel.org/linux-renesas-soc/057721f46c7499de4133135488f0f3da7fb39265.1636570669.git.geert+renesas at glider.be)

Marked RFC, as this depends on [PATCH 01/17], but follows a different
path to upstream.
---
 drivers/soc/renesas/renesas-soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 97957d5d7dafbe2a..33940258f37eef03 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014-2016 Glider bvba
  */
 
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -434,8 +435,7 @@ static int __init renesas_soc_init(void)
 			eslo = product & 0xf;
 		}
 
-		if (soc->id &&
-		    ((product & id->mask) >> __ffs(id->mask)) != soc->id) {
+		if (soc->id && field_get(id->mask, product) != soc->id) {
 			pr_warn("SoC mismatch (product = 0x%x)\n", product);
 			return -ENODEV;
 		}
-- 
2.25.1

