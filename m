From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Oct 2022 23:14:36 +0300
Subject: [PATCH v2 20/36] pinctrl: samsung: Add missed header(s)
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20221010201453.77401-21-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Do not imply that some of the generic headers may be always included.
Instead, include explicitly what we are direct user of.

While at it, sort headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index bd13b5ef246d..5736761927cb 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -15,15 +15,16 @@
 // but provides extensions to which platform specific implementation of the gpio
 // and wakeup interrupts can be hooked to.
 
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/property.h>
-#include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irqdomain.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #include "../core.h"
-- 
2.35.1

