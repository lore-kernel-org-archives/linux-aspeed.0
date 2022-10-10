From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Oct 2022 23:14:30 +0300
Subject: [PATCH v2 14/36] pinctrl: mediatek: Add missed header(s)
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20221010201453.77401-15-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/mediatek/pinctrl-moore.c | 3 +++
 drivers/pinctrl/mediatek/pinctrl-paris.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 526faaebaf77..9474ada5addb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -9,6 +9,9 @@
  */
 
 #include <linux/gpio/driver.h>
+
+#include <linux/pinctrl/consumer.h>
+
 #include "pinctrl-moore.h"
 
 #define PINCTRL_PINCTRL_DEV		KBUILD_MODNAME
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 74517e810958..475f4172d508 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -11,7 +11,12 @@
 
 #include <linux/gpio/driver.h>
 #include <linux/module.h>
+#include <linux/seq_file.h>
+
+#include <linux/pinctrl/consumer.h>
+
 #include <dt-bindings/pinctrl/mt65xx.h>
+
 #include "pinctrl-paris.h"
 
 #define PINCTRL_PINCTRL_DEV	KBUILD_MODNAME
-- 
2.35.1

