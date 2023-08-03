From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:56 -0600
Subject: [PATCH v2 16/23] bus: Explicitly include correct DT includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-16-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 1 +
 drivers/bus/fsl-mc/fsl-mc-msi.c | 2 --
 drivers/bus/hisi_lpc.c          | 2 +-
 drivers/bus/omap_l3_smx.c       | 1 -
 drivers/bus/simple-pm-bus.c     | 2 ++
 drivers/bus/sunxi-rsb.c         | 2 +-
 drivers/bus/ti-pwmss.c          | 2 +-
 7 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 4352745a923c..7c57e7d2ff55 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -14,6 +14,7 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/ioport.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/limits.h>
 #include <linux/bitops.h>
diff --git a/drivers/bus/fsl-mc/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
index f3f8af9426c9..82cd69f7884c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -7,8 +7,6 @@
  *
  */
 
-#include <linux/of_device.h>
-#include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 5b65a48f17e7..cdc4e38c113e 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -13,9 +13,9 @@
 #include <linux/logic_pio.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/slab.h>
 
diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index bb1606f5ce2d..9ba18c39c671 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include "omap_l3_smx.h"
 
diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 4da77ca7b75a..aafcc481de91 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -11,6 +11,8 @@
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 2aefd5dde3c9..db0ed4e5d315 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -39,7 +39,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/bus/ti-pwmss.c b/drivers/bus/ti-pwmss.c
index e9c26c94251b..480a4de76cd4 100644
--- a/drivers/bus/ti-pwmss.c
+++ b/drivers/bus/ti-pwmss.c
@@ -10,7 +10,7 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 
 static const struct of_device_id pwmss_of_match[] = {
 	{ .compatible	= "ti,am33xx-pwmss" },

-- 
2.40.1

