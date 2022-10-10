From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Oct 2022 23:14:40 +0300
Subject: [PATCH v2 24/36] pinctrl: st: Add missed header(s)
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20221010201453.77401-25-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/pinctrl-st.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index cf7f9cbe6044..985dfceb127d 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -5,21 +5,26 @@
  *	Srinivas Kandagatla <srinivas.kandagatla@st.com>
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/gpio/driver.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/string_helpers.h>
+
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/pinctrl/pinconf.h>
-#include <linux/platform_device.h>
+
 #include "core.h"
 
 /* PIO Block registers */
-- 
2.35.1

