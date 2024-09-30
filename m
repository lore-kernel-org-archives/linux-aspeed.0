From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:24 +0000
Subject: [PATCH 29/45] media: siano: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-29-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warning is fixed:
drivers/media/common/siano/sms-cards.c:329:36-41: opportunity for str_enabled_disabled(onoff)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/siano/sms-cards.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/sms-cards.c b/drivers/media/common/siano/sms-cards.c
index d4a116ab6c88..e9aa95233ff1 100644
--- a/drivers/media/common/siano/sms-cards.c
+++ b/drivers/media/common/siano/sms-cards.c
@@ -8,6 +8,7 @@
 #include "sms-cards.h"
 #include "smsir.h"
 #include <linux/module.h>
+#include <linux/string_choices.h>
 
 static struct sms_board sms_boards[] = {
 	[SMS_BOARD_UNKNOWN] = {
@@ -326,7 +327,7 @@ int sms_board_lna_control(struct smscore_device_t *coredev, int onoff)
 	int board_id = smscore_get_board_id(coredev);
 	struct sms_board *board = sms_get_board(board_id);
 
-	pr_debug("%s: LNA %s\n", __func__, onoff ? "enabled" : "disabled");
+	pr_debug("%s: LNA %s\n", __func__, str_enabled_disabled(onoff));
 
 	switch (board_id) {
 	case SMS1XXX_BOARD_HAUPPAUGE_TIGER_MINICARD_R2:

-- 
2.46.1.824.gd892dcdcdd-goog

