From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:29 +0000
Subject: [PATCH 34/45] media: i2c: tda1997x: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-34-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/i2c/tda1997x.c:1976:4-29: opportunity for str_yes_no(tda1997x_detect_tx_5v ( sd ))
drivers/media/i2c/tda1997x.c:1978:4-30: opportunity for str_yes_no(tda1997x_detect_tx_hpd ( sd ))
drivers/media/i2c/tda1997x.c:1972:37-56: opportunity for str_yes_no(state -> edid . present)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/tda1997x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
index 3b7e5ff5b010..867c635fa37f 100644
--- a/drivers/media/i2c/tda1997x.c
+++ b/drivers/media/i2c/tda1997x.c
@@ -1969,13 +1969,13 @@ static int tda1997x_log_status(struct v4l2_subdev *sd)
 	v4l2_info(sd, "-----Chip status-----\n");
 	v4l2_info(sd, "Chip: %s N%d\n", state->info->name,
 		  state->chip_revision + 1);
-	v4l2_info(sd, "EDID Enabled: %s\n", state->edid.present ? "yes" : "no");
+	v4l2_info(sd, "EDID Enabled: %s\n", str_yes_no(state->edid.present));
 
 	v4l2_info(sd, "-----Signal status-----\n");
 	v4l2_info(sd, "Cable detected (+5V power): %s\n",
-		  tda1997x_detect_tx_5v(sd) ? "yes" : "no");
+		  str_yes_no(tda1997x_detect_tx_5v(sd)));
 	v4l2_info(sd, "HPD detected: %s\n",
-		  tda1997x_detect_tx_hpd(sd) ? "yes" : "no");
+		  str_yes_no(tda1997x_detect_tx_hpd(sd)));
 
 	v4l2_info(sd, "-----Video Timings-----\n");
 	switch (tda1997x_detect_std(state, &timings)) {

-- 
2.46.1.824.gd892dcdcdd-goog

