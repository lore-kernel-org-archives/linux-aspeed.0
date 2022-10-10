From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Oct 2022 23:14:46 +0300
Subject: [PATCH v2 30/36] pinctrl: uniphier: Add missed header(s)
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20221010201453.77401-31-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index ade348b49b31..18d3a4f69e63 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -6,12 +6,14 @@
 #include <linux/list.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
-#include <linux/pinctrl/pinconf.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/seq_file.h>
+
 #include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
 
 #include "../core.h"
 #include "../pinctrl-utils.h"
-- 
2.35.1

