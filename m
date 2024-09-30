From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:22 +0000
Subject: [PATCH 27/45] media: cec: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-27-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/cec/usb/pulse8/pulse8-cec.c:698:2-9: opportunity for str_on_off(data [ 0 ])
drivers/media/cec/usb/pulse8/pulse8-cec.c:705:4-11: opportunity for str_on_off(data [ 0 ])
drivers/media/cec/platform/cec-gpio/cec-gpio.c:138:6-22: opportunity for str_high_low(cec -> hpd_is_high)
drivers/media/cec/platform/cec-gpio/cec-gpio.c:141:6-21: opportunity for str_high_low(cec -> v5_is_high)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/cec/platform/cec-gpio/cec-gpio.c | 4 ++--
 drivers/media/cec/usb/pulse8/pulse8-cec.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/cec/platform/cec-gpio/cec-gpio.c b/drivers/media/cec/platform/cec-gpio/cec-gpio.c
index 98dacb0919b6..49160a15272b 100644
--- a/drivers/media/cec/platform/cec-gpio/cec-gpio.c
+++ b/drivers/media/cec/platform/cec-gpio/cec-gpio.c
@@ -135,10 +135,10 @@ static void cec_gpio_status(struct cec_adapter *adap, struct seq_file *file)
 	seq_printf(file, "using irq: %d\n", cec->cec_irq);
 	if (cec->hpd_gpio)
 		seq_printf(file, "hpd: %s\n",
-			   cec->hpd_is_high ? "high" : "low");
+			   str_high_low(cec->hpd_is_high));
 	if (cec->v5_gpio)
 		seq_printf(file, "5V: %s\n",
-			   cec->v5_is_high ? "high" : "low");
+			   str_high_low(cec->v5_is_high));
 }
 
 static int cec_gpio_read_hpd(struct cec_adapter *adap)
diff --git a/drivers/media/cec/usb/pulse8/pulse8-cec.c b/drivers/media/cec/usb/pulse8/pulse8-cec.c
index ba67587bd43e..0167f21cb116 100644
--- a/drivers/media/cec/usb/pulse8/pulse8-cec.c
+++ b/drivers/media/cec/usb/pulse8/pulse8-cec.c
@@ -695,14 +695,14 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
 		return err;
 	pulse8->autonomous = data[0];
 	dev_dbg(pulse8->dev, "Autonomous mode: %s",
-		data[0] ? "on" : "off");
+		str_on_off(data[0]));
 
 	if (pulse8->vers >= 10) {
 		cmd[0] = MSGCODE_GET_AUTO_POWER_ON;
 		err = pulse8_send_and_wait(pulse8, cmd, 1, cmd[0], 1);
 		if (!err)
 			dev_dbg(pulse8->dev, "Auto Power On: %s",
-				data[0] ? "on" : "off");
+				str_on_off(data[0]));
 	}
 
 	cmd[0] = MSGCODE_GET_DEVICE_TYPE;

-- 
2.46.1.824.gd892dcdcdd-goog

