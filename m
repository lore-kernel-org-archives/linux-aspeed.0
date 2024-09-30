From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:03:59 +0000
Subject: [PATCH 04/45] media: pwc-ctl: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-4-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed:
drivers/media/usb/pwc/pwc-ctrl.c:492:5-10: opportunity for str_on_off(power)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/pwc/pwc-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pwc/pwc-ctrl.c b/drivers/media/usb/pwc/pwc-ctrl.c
index cff64d872058..a1b4eeb41cfe 100644
--- a/drivers/media/usb/pwc/pwc-ctrl.c
+++ b/drivers/media/usb/pwc/pwc-ctrl.c
@@ -489,7 +489,7 @@ void pwc_camera_power(struct pwc_device *pdev, int power)
 		SET_POWER_SAVE_MODE_FORMATTER, pdev->ctrl_buf, 1);
 	if (r < 0)
 		PWC_ERROR("Failed to power %s camera (%d)\n",
-			  power ? "on" : "off", r);
+			  str_on_off(power), r);
 }
 
 int pwc_set_leds(struct pwc_device *pdev, int on_value, int off_value)

-- 
2.46.1.824.gd892dcdcdd-goog

