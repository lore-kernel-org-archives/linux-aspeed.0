From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:53:54 +0100
Subject: [PATCH 01/17] bitfield: Add non-constant field_{prep,get}() helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <3a54a6703879d10f08cf0275a2a69297ebd2b1d4.1637592133.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver already has its own
field_{prep,get}() macros.  Make them available for general use by
moving them to <linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()", as the latter operates on
     "unsigned long", just like BIT() and GENMASK().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Using __ffs() actually reduces code size (16 bytes for each of
drivers/clk/at91/clk-{generated,peripheral}.o), as __ffs() doesn't
need to verify that the value passed is non-zero.
---
 drivers/clk/at91/clk-peripheral.c |  1 +
 drivers/clk/at91/pmc.h            |  3 ---
 include/linux/bitfield.h          | 30 ++++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index e14fa5ac734cead7..e2f33498139a1b8c 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 3a1bf6194c287d09..1256e1ab91526a25 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -114,9 +114,6 @@ struct at91_clk_pms {
 	unsigned int parent;
 };
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define ndck(a, s) (a[s - 1].id + 1)
 #define nck(a) (a[ARRAY_SIZE@ - 1].id + 1)
 struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 4e035aca6f7e6000..f03b0712e4babec1 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -156,4 +156,34 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+/**
+ * field_prep() - prepare a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @_mask is not limited to a compile-time constant.
+ */
+#define field_prep(_mask, _val)						\
+	({								\
+		typeof(_mask) ___mask = (_mask);			\
+		(((_val) << __ffs(___mask)) & (___mask));		\
+	})
+
+/**
+ * field_get() - extract a bitfield element
+ * @_mask: shifted mask defining the field's length and position
+ * @_reg:  value of entire bitfield
+ *
+ * field_get() extracts the field specified by @_mask from the
+ * bitfield passed in as @_reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @_mask is not limited to a compile-time constant.
+ */
+#define field_get(_mask, _reg)						\
+	({								\
+		typeof(_mask) ___mask = _mask;				\
+		(((_reg) & (___mask)) >> __ffs(___mask));		\
+	})
+
 #endif
-- 
2.25.1

