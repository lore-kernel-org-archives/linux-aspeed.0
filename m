From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:30 +0000
Subject: [PATCH 35/45] media: i2c: tc358743: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-35-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/i2c/tc358743.c:370:46-52: opportunity for str_enable_disable(enable)
drivers/media/i2c/tc358743.c:1325:32-63: opportunity for str_on_off(hdmi_sys_status & MASK_S_AVMUTE)
drivers/media/i2c/tc358743.c:1264:35-54: opportunity for str_on_off(sysctl & MASK_SLEEP)
drivers/media/i2c/tc358743.c:1187:14-19: opportunity for str_yes_no(tx_5v)
drivers/media/i2c/tc358743.c:1266:3-33: opportunity for str_yes_no(hdmi_sys_status & MASK_S_DDC5V)
drivers/media/i2c/tc358743.c:1319:3-32: opportunity for str_yes_no(hdmi_sys_status & MASK_S_HDCP)
drivers/media/i2c/tc358743.c:1281:3-35: opportunity for str_yes_no(hdmi_sys_status & MASK_S_PHY_PLL)
drivers/media/i2c/tc358743.c:1283:3-36: opportunity for str_yes_no(hdmi_sys_status & MASK_S_PHY_SCDT)
drivers/media/i2c/tc358743.c:1279:3-32: opportunity for str_yes_no(hdmi_sys_status & MASK_S_SYNC)
drivers/media/i2c/tc358743.c:1277:3-32: opportunity for str_yes_no(hdmi_sys_status & MASK_S_TMDS)
drivers/media/i2c/tc358743.c:1274:3-37: opportunity for str_yes_no(( i2c_rd16 ( sd , CECEN ) & MASK_CECEN ))
drivers/media/i2c/tc358743.c:1309:3-42: opportunity for str_yes_no(( i2c_rd16 ( sd , CSI_STATUS ) & MASK_S_HLT ))
drivers/media/i2c/tc358743.c:1306:3-44: opportunity for str_yes_no(( i2c_rd16 ( sd , CSI_STATUS ) & MASK_S_RXACT ))
drivers/media/i2c/tc358743.c:1303:3-44: opportunity for str_yes_no(( i2c_rd16 ( sd , CSI_STATUS ) & MASK_S_TXACT ))
drivers/media/i2c/tc358743.c:1300:3-44: opportunity for str_yes_no(( i2c_rd16 ( sd , CSI_STATUS ) & MASK_S_WSYNC ))
drivers/media/i2c/tc358743.c:1268:3-50: opportunity for str_yes_no(( i2c_rd8 ( sd , EDID_MODE ) & MASK_EDID_MODE_E_DDC ))
drivers/media/i2c/tc358743.c:1271:3-41: opportunity for str_yes_no(( i2c_rd8 ( sd , HPD_CTL ) & MASK_HPD_OUT0 ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/tc358743.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index 65d58ddf0287..f2e1e55ae190 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -367,8 +367,8 @@ static void tc358743_delayed_work_enable_hotplug(struct work_struct *work)
 
 static void tc358743_set_hdmi_hdcp(struct v4l2_subdev *sd, bool enable)
 {
-	v4l2_dbg(2, debug, sd, "%s: %s\n", __func__, enable ?
-				"enable" : "disable");
+	v4l2_dbg(2, debug, sd, "%s: %s\n", __func__,
+		 str_enable_disable(enable));
 
 	if (enable) {
 		i2c_wr8_and_or(sd, HDCP_REG3, ~KEY_RD_CMD, KEY_RD_CMD);
@@ -1184,7 +1184,7 @@ static void tc358743_hdmi_sys_int_handler(struct v4l2_subdev *sd, bool *handled)
 		bool tx_5v = tx_5v_power_present(sd);
 
 		v4l2_dbg(1, debug, sd, "%s: Tx 5V power present: %s\n",
-				__func__, tx_5v ?  "yes" : "no");
+				__func__, str_yes_no(tx_5v));
 
 		if (tx_5v) {
 			tc358743_enable_edid(sd);
@@ -1261,26 +1261,24 @@ static int tc358743_log_status(struct v4l2_subdev *sd)
 			!!(sysctl & MASK_CECRST),
 			!!(sysctl & MASK_CTXRST),
 			!!(sysctl & MASK_HDMIRST));
-	v4l2_info(sd, "Sleep mode: %s\n", sysctl & MASK_SLEEP ? "on" : "off");
+	v4l2_info(sd, "Sleep mode: %s\n", str_on_off(sysctl & MASK_SLEEP));
 	v4l2_info(sd, "Cable detected (+5V power): %s\n",
-			hdmi_sys_status & MASK_S_DDC5V ? "yes" : "no");
+			str_yes_no(hdmi_sys_status & MASK_S_DDC5V));
 	v4l2_info(sd, "DDC lines enabled: %s\n",
-			(i2c_rd8(sd, EDID_MODE) & MASK_EDID_MODE_E_DDC) ?
-			"yes" : "no");
+			str_yes_no(i2c_rd8(sd, EDID_MODE) & MASK_EDID_MODE_E_DDC));
 	v4l2_info(sd, "Hotplug enabled: %s\n",
-			(i2c_rd8(sd, HPD_CTL) & MASK_HPD_OUT0) ?
-			"yes" : "no");
+			str_yes_no(i2c_rd8(sd, HPD_CTL) & MASK_HPD_OUT0));
 	v4l2_info(sd, "CEC enabled: %s\n",
-			(i2c_rd16(sd, CECEN) & MASK_CECEN) ?  "yes" : "no");
+			str_yes_no(i2c_rd16(sd, CECEN) & MASK_CECEN));
 	v4l2_info(sd, "-----Signal status-----\n");
 	v4l2_info(sd, "TMDS signal detected: %s\n",
-			hdmi_sys_status & MASK_S_TMDS ? "yes" : "no");
+			str_yes_no(hdmi_sys_status & MASK_S_TMDS));
 	v4l2_info(sd, "Stable sync signal: %s\n",
-			hdmi_sys_status & MASK_S_SYNC ? "yes" : "no");
+			str_yes_no(hdmi_sys_status & MASK_S_SYNC));
 	v4l2_info(sd, "PHY PLL locked: %s\n",
-			hdmi_sys_status & MASK_S_PHY_PLL ? "yes" : "no");
+			str_yes_no(hdmi_sys_status & MASK_S_PHY_PLL));
 	v4l2_info(sd, "PHY DE detected: %s\n",
-			hdmi_sys_status & MASK_S_PHY_SCDT ? "yes" : "no");
+			str_yes_no(hdmi_sys_status & MASK_S_PHY_SCDT));
 
 	if (tc358743_get_detected_timings(sd, &timings)) {
 		v4l2_info(sd, "No video detected\n");
@@ -1297,17 +1295,13 @@ static int tc358743_log_status(struct v4l2_subdev *sd)
 	v4l2_info(sd, "Lanes in use: %d\n",
 			state->csi_lanes_in_use);
 	v4l2_info(sd, "Waiting for particular sync signal: %s\n",
-			(i2c_rd16(sd, CSI_STATUS) & MASK_S_WSYNC) ?
-			"yes" : "no");
+			str_yes_no(i2c_rd16(sd, CSI_STATUS) & MASK_S_WSYNC));
 	v4l2_info(sd, "Transmit mode: %s\n",
-			(i2c_rd16(sd, CSI_STATUS) & MASK_S_TXACT) ?
-			"yes" : "no");
+			str_yes_no(i2c_rd16(sd, CSI_STATUS) & MASK_S_TXACT));
 	v4l2_info(sd, "Receive mode: %s\n",
-			(i2c_rd16(sd, CSI_STATUS) & MASK_S_RXACT) ?
-			"yes" : "no");
+			str_yes_no(i2c_rd16(sd, CSI_STATUS) & MASK_S_RXACT));
 	v4l2_info(sd, "Stopped: %s\n",
-			(i2c_rd16(sd, CSI_STATUS) & MASK_S_HLT) ?
-			"yes" : "no");
+			str_yes_no(i2c_rd16(sd, CSI_STATUS) & MASK_S_HLT));
 	v4l2_info(sd, "Color space: %s\n",
 			state->mbus_fmt_code == MEDIA_BUS_FMT_UYVY8_1X16 ?
 			"YCbCr 422 16-bit" :
@@ -1316,14 +1310,14 @@ static int tc358743_log_status(struct v4l2_subdev *sd)
 
 	v4l2_info(sd, "-----%s status-----\n", is_hdmi(sd) ? "HDMI" : "DVI-D");
 	v4l2_info(sd, "HDCP encrypted content: %s\n",
-			hdmi_sys_status & MASK_S_HDCP ? "yes" : "no");
+			str_yes_no(hdmi_sys_status & MASK_S_HDCP));
 	v4l2_info(sd, "Input color space: %s %s range\n",
 			input_color_space[(vi_status3 & MASK_S_V_COLOR) >> 1],
 			(vi_status3 & MASK_LIMITED) ? "limited" : "full");
 	if (!is_hdmi(sd))
 		return 0;
-	v4l2_info(sd, "AV Mute: %s\n", hdmi_sys_status & MASK_S_AVMUTE ? "on" :
-			"off");
+	v4l2_info(sd, "AV Mute: %s\n",
+		  str_on_off(hdmi_sys_status & MASK_S_AVMUTE));
 	v4l2_info(sd, "Deep color mode: %d-bits per channel\n",
 			deep_color_mode[(i2c_rd8(sd, VI_STATUS1) &
 				MASK_S_DEEPCOLOR) >> 2]);

-- 
2.46.1.824.gd892dcdcdd-goog

