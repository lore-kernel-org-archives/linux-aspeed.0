From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:35 +0000
Subject: [PATCH 40/45] media: i2c: saa7127: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-40-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/i2c/saa7127.c:678:33-49: opportunity for str_enabled_disabled(state -> cc_enable)
drivers/media/i2c/saa7127.c:677:33-50: opportunity for str_enabled_disabled(state -> vps_enable)
drivers/media/i2c/saa7127.c:379:19-25: opportunity for str_on_off(enable)
drivers/media/i2c/saa7127.c:346:49-55: opportunity for str_on_off(enable)
drivers/media/i2c/saa7127.c:430:42-48: opportunity for str_on_off(enable)
drivers/media/i2c/saa7127.c:405:42-48: opportunity for str_on_off(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/saa7127.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/saa7127.c b/drivers/media/i2c/saa7127.c
index 818ed19cf37b..1ea5e4b9019d 100644
--- a/drivers/media/i2c/saa7127.c
+++ b/drivers/media/i2c/saa7127.c
@@ -343,7 +343,8 @@ static int saa7127_set_vps(struct v4l2_subdev *sd, const struct v4l2_sliced_vbi_
 	if (enable && (data->field != 0 || data->line != 16))
 		return -EINVAL;
 	if (state->vps_enable != enable) {
-		v4l2_dbg(1, debug, sd, "Turn VPS Signal %s\n", enable ? "on" : "off");
+		v4l2_dbg(1, debug, sd, "Turn VPS Signal %s\n",
+			 str_on_off(enable));
 		saa7127_write(sd, 0x54, enable << 7);
 		state->vps_enable = enable;
 	}
@@ -376,7 +377,7 @@ static int saa7127_set_cc(struct v4l2_subdev *sd, const struct v4l2_sliced_vbi_d
 		return -EINVAL;
 	if (state->cc_enable != enable) {
 		v4l2_dbg(1, debug, sd,
-			"Turn CC %s\n", enable ? "on" : "off");
+			"Turn CC %s\n", str_on_off(enable));
 		saa7127_write(sd, SAA7127_REG_CLOSED_CAPTION,
 			(state->xds_enable << 7) | (enable << 6) | 0x11);
 		state->cc_enable = enable;
@@ -402,7 +403,7 @@ static int saa7127_set_xds(struct v4l2_subdev *sd, const struct v4l2_sliced_vbi_
 	if (enable && (data->field != 1 || data->line != 21))
 		return -EINVAL;
 	if (state->xds_enable != enable) {
-		v4l2_dbg(1, debug, sd, "Turn XDS %s\n", enable ? "on" : "off");
+		v4l2_dbg(1, debug, sd, "Turn XDS %s\n", str_on_off(enable));
 		saa7127_write(sd, SAA7127_REG_CLOSED_CAPTION,
 				(enable << 7) | (state->cc_enable << 6) | 0x11);
 		state->xds_enable = enable;
@@ -427,7 +428,7 @@ static int saa7127_set_wss(struct v4l2_subdev *sd, const struct v4l2_sliced_vbi_
 	if (enable && (data->field != 0 || data->line != 23))
 		return -EINVAL;
 	if (state->wss_enable != enable) {
-		v4l2_dbg(1, debug, sd, "Turn WSS %s\n", enable ? "on" : "off");
+		v4l2_dbg(1, debug, sd, "Turn WSS %s\n", str_on_off(enable));
 		saa7127_write(sd, 0x27, enable << 7);
 		state->wss_enable = enable;
 	}
@@ -674,8 +675,10 @@ static int saa7127_log_status(struct v4l2_subdev *sd)
 			output_strs[state->output_type] : "disabled");
 	v4l2_info(sd, "WSS:      %s\n", state->wss_enable ?
 			wss_strs[state->wss_mode] : "disabled");
-	v4l2_info(sd, "VPS:      %s\n", state->vps_enable ? "enabled" : "disabled");
-	v4l2_info(sd, "CC:       %s\n", state->cc_enable ? "enabled" : "disabled");
+	v4l2_info(sd, "VPS:      %s\n",
+		  str_enabled_disabled(state->vps_enable));
+	v4l2_info(sd, "CC:       %s\n",
+		  str_enabled_disabled(state->cc_enable));
 	return 0;
 }
 

-- 
2.46.1.824.gd892dcdcdd-goog

