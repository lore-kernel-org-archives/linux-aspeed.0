From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat,  5 Nov 2022 12:09:34 +0100
Subject: [PATCH] watchdog: Include <linux/kstrtox.h> when appropriate
Message-ID: <08fd5512e569558231247515c04c8596a1d11004.1667646547.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The kstrto<something>() functions have been moved from kernel.h to
kstrtox.h.

So, in order to eventually remove <linux/kernel.h> from <linux/watchdog.h>,
include the latter directly in the appropriate files.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/watchdog/aspeed_wdt.c   | 1 +
 drivers/watchdog/watchdog_dev.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 0cff2adfbfc9..10863d2ef924 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 55574ed42504..f31608f3e324 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -35,6 +35,7 @@
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/hrtimer.h>	/* For hrtimers */
 #include <linux/kernel.h>	/* For printk/panic/... */
+#include <linux/kstrtox.h>	/* For kstrto* */
 #include <linux/kthread.h>	/* For kthread_work */
 #include <linux/miscdevice.h>	/* For handling misc devices */
 #include <linux/module.h>	/* For module stuff/... */
-- 
2.34.1

