From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Oct 2022 23:14:29 +0300
Subject: [PATCH v2 13/36] pinctrl: lochnagar: Add missed header(s)
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20221010201453.77401-14-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
index 3fda4446d70b..0b78cf611afe 100644
--- a/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
+++ b/drivers/pinctrl/cirrus/pinctrl-lochnagar.c
@@ -15,10 +15,12 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/pinconf-generic.h>
 
 #include <linux/mfd/lochnagar.h>
 #include <linux/mfd/lochnagar1_regs.h>
-- 
2.35.1

