From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:57 -0600
Subject: [PATCH v2 17/23] firmware: Explicitly include correct DT includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-17-d8de2cc88bff@kernel.org>
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

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/firmware/arm_scmi/driver.c | 4 ++--
 drivers/firmware/imx/imx-dsp.c     | 1 -
 drivers/firmware/imx/imx-scu-irq.c | 1 +
 drivers/firmware/imx/imx-scu.c     | 1 +
 drivers/firmware/mtk-adsp-ipc.c    | 1 -
 drivers/firmware/raspberrypi.c     | 1 +
 drivers/firmware/scpi_pm_domain.c  | 3 ++-
 drivers/firmware/stratix10-rsu.c   | 1 -
 drivers/firmware/tegra/bpmp.c      | 3 +--
 drivers/firmware/xilinx/zynqmp.c   | 1 +
 10 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b5957cc12fee..87383c05424b 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -28,8 +28,8 @@
 #include <linux/hashtable.h>
 #include <linux/list.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/processor.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index a6c06d7476c3..3dba590a2a95 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index d9dcc20945c6..a149537e0639 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -10,6 +10,7 @@
 #include <linux/firmware/imx/ipc.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/mailbox_client.h>
+#include <linux/of.h>
 #include <linux/suspend.h>
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 47db49911e7b..2e5914f3a110 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -16,6 +16,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-ipc.c
index 3c071f814455..85e94ddc7204 100644
--- a/drivers/firmware/mtk-adsp-ipc.c
+++ b/drivers/firmware/mtk-adsp-ipc.c
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index c3bc29e0a488..f66efaa5196d 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -10,6 +10,7 @@
 #include <linux/kref.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/firmware/scpi_pm_domain.c b/drivers/firmware/scpi_pm_domain.c
index 800673910b51..2231e6dd2070 100644
--- a/drivers/firmware/scpi_pm_domain.c
+++ b/drivers/firmware/scpi_pm_domain.c
@@ -8,7 +8,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/scpi_protocol.h>
 
diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index e51c95f8d445..ab3074705380 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/firmware/intel/stratix10-svc-client.h>
 #include <linux/string.h>
diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index 17bd3590aaa2..51d062e0c3f1 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -8,8 +8,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/semaphore.h>
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index f8c4eb2b43f8..eb9ad5ae393f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/hashtable.h>

-- 
2.40.1

