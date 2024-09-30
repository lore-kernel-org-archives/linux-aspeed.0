From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:06 +0000
Subject: [PATCH 11/45] media: rc: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-11-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/rc/mceusb.c:1130:2-8: opportunity for str_enable_disable(enable)
drivers/media/rc/ene_ir.c:1121:22-28: opportunity for str_enabled_disabled(enable)
drivers/media/rc/serial_ir.c:591:4-9: opportunity for str_low_high(sense)
drivers/media/rc/serial_ir.c:594:4-9: opportunity for str_low_high(sense)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/rc/ene_ir.c    | 3 ++-
 drivers/media/rc/mceusb.c    | 3 ++-
 drivers/media/rc/serial_ir.c | 5 +++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/rc/ene_ir.c b/drivers/media/rc/ene_ir.c
index 67722e2e47ff..90bee860a8a1 100644
--- a/drivers/media/rc/ene_ir.c
+++ b/drivers/media/rc/ene_ir.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <media/rc-core.h>
 #include "ene_ir.h"
 
@@ -1118,7 +1119,7 @@ static void ene_remove(struct pnp_dev *pnp_dev)
 /* enable wake on IR (wakes on specific button on original remote) */
 static void ene_enable_wake(struct ene_device *dev, bool enable)
 {
-	dbg("wake on IR %s", enable ? "enabled" : "disabled");
+	dbg("wake on IR %s", str_enabled_disabled(enable));
 	ene_set_clear_reg_mask(dev, ENE_FW1, ENE_FW1_WAKE, enable);
 }
 
diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index cd7af4d88b7f..7f932f0f5750 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -25,6 +25,7 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/workqueue.h>
 #include <linux/usb.h>
 #include <linux/usb/input.h>
@@ -1127,7 +1128,7 @@ static int mceusb_set_rx_carrier_report(struct rc_dev *dev, int enable)
 				    MCE_CMD_SETIRRXPORTEN, 0x00 };
 
 	dev_dbg(ir->dev, "%s short-range receiver carrier reporting",
-		enable ? "enable" : "disable");
+		str_enable_disable(enable));
 	if (enable) {
 		ir->carrier_report_enabled = true;
 		if (!ir->learning_active) {
diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index fc5fd3927177..f9ec2f043529 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <media/rc-core.h>
 
 struct serial_ir_hw {
@@ -588,10 +589,10 @@ static int serial_ir_probe(struct platform_device *dev)
 		}
 		sense = nlow >= nhigh ? 1 : 0;
 		dev_info(&dev->dev, "auto-detected active %s receiver\n",
-			 sense ? "low" : "high");
+			 str_low_high(sense));
 	} else
 		dev_info(&dev->dev, "Manually using active %s receiver\n",
-			 sense ? "low" : "high");
+			 str_low_high(sense));
 
 	dev_dbg(&dev->dev, "Interrupt %d, port %04x obtained\n", irq, io);
 

-- 
2.46.1.824.gd892dcdcdd-goog

