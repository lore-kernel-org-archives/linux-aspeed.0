From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Oct 2022 23:14:24 +0300
Subject: [PATCH v2 08/36] pinctrl: bcm: Add missed header(s)
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20221010201453.77401-9-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c   | 13 ++++++++-----
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 12 +++++++-----
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c    |  8 +++++---
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c    |  8 +++++---
 4 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index fd52a83387ef..73dbf29c002f 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -2,16 +2,19 @@
 // Copyright (C) 2013-2017 Broadcom
 
 #include <linux/err.h>
-#include <linux/io.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinmux.h>
-#include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/regmap.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
+
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
 #include "../core.h"
 #include "../pinctrl-utils.h"
 
diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index 52fa2f4cd618..3df56a4ea510 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -16,17 +16,19 @@
  * SoCs IOMUX controller.
  */
 
-#include <linux/kernel.h>
-#include <linux/slab.h>
+#include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/gpio/driver.h>
 #include <linux/ioport.h>
+#include <linux/kernel.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
-#include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinconf.h>
+#include <linux/slab.h>
+
+#include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinctrl.h>
 
 #include "../pinctrl-utils.h"
 
diff --git a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
index 960e253f0be4..04f4fca854cc 100644
--- a/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-ns2-mux.c
@@ -9,12 +9,14 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/pinctrl/pinconf.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
diff --git a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
index db8f79920ff0..eb6298507c1d 100644
--- a/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-nsp-mux.c
@@ -20,12 +20,14 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/pinctrl/pinconf.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
-- 
2.35.1

