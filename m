From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Oct 2022 23:14:43 +0300
Subject: [PATCH v2 27/36] pinctrl: stmfx: Add missed header(s)
In-Reply-To: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20221010201453.77401-28-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/pinctrl-stmfx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index ab4dde40d3ed..1181c4b506b1 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -10,6 +10,8 @@
 #include <linux/mfd/stmfx.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
+
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinmux.h>
 
-- 
2.35.1

