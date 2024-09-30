From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:39 +0000
Subject: [PATCH 44/45] media: i2c: adv76xx: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-44-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/i2c/adv7604.c:2641:3-31: opportunity for str_true_false(( hdmi_read ( sd , 0x05 ) & 0x40 ))
drivers/media/i2c/adv7604.c:2595:34-48: opportunity for str_false_true(no_lock_cp ( sd ))
drivers/media/i2c/adv7604.c:2593:36-52: opportunity for str_false_true(no_lock_sspd ( sd ))
drivers/media/i2c/adv7604.c:2594:36-52: opportunity for str_false_true(no_lock_stdi ( sd ))
drivers/media/i2c/adv7604.c:2592:3-19: opportunity for str_false_true(no_lock_tmds ( sd ))
drivers/media/i2c/adv7604.c:2590:3-21: opportunity for str_false_true(no_signal_tmds ( sd ))
drivers/media/i2c/adv7604.c:2568:28-51: opportunity for str_enabled_disabled(state -> cec_enabled_adap)
drivers/media/i2c/adv7604.c:2630:3-23: opportunity for str_enabled_disabled(( reg_io_0x02 & 0x08 ))
drivers/media/i2c/adv7604.c:2597:3-20: opportunity for str_on_off(( in_free_run ( sd ) ))
drivers/media/i2c/adv7604.c:2664:33-61: opportunity for str_on_off(( hdmi_read ( sd , 0x04 ) & 0x40 ))
drivers/media/i2c/adv7604.c:2643:3-31: opportunity for str_yes_no(( hdmi_read ( sd , 0x04 ) & 0x20 ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/adv7604.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 48230d5109f0..fb74f2947413 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -2565,8 +2565,8 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
 			((edid_enabled & 0x02) ? "Yes" : "No"),
 			((edid_enabled & 0x04) ? "Yes" : "No"),
 			((edid_enabled & 0x08) ? "Yes" : "No"));
-	v4l2_info(sd, "CEC: %s\n", state->cec_enabled_adap ?
-			"enabled" : "disabled");
+	v4l2_info(sd, "CEC: %s\n",
+		  str_enabled_disabled(state->cec_enabled_adap));
 	if (state->cec_enabled_adap) {
 		int i;
 
@@ -2587,14 +2587,14 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
 			((cable_det & 0x04) ? "Yes" : "No"),
 			((cable_det & 0x08) ? "Yes" : "No"));
 	v4l2_info(sd, "TMDS signal detected: %s\n",
-			no_signal_tmds(sd) ? "false" : "true");
+			str_false_true(no_signal_tmds(sd)));
 	v4l2_info(sd, "TMDS signal locked: %s\n",
-			no_lock_tmds(sd) ? "false" : "true");
-	v4l2_info(sd, "SSPD locked: %s\n", no_lock_sspd(sd) ? "false" : "true");
-	v4l2_info(sd, "STDI locked: %s\n", no_lock_stdi(sd) ? "false" : "true");
-	v4l2_info(sd, "CP locked: %s\n", no_lock_cp(sd) ? "false" : "true");
+			str_false_true(no_lock_tmds(sd)));
+	v4l2_info(sd, "SSPD locked: %s\n", str_false_true(no_lock_sspd(sd)));
+	v4l2_info(sd, "STDI locked: %s\n", str_false_true(no_lock_stdi(sd)));
+	v4l2_info(sd, "CP locked: %s\n", str_false_true(no_lock_cp(sd)));
 	v4l2_info(sd, "CP free run: %s\n",
-			(in_free_run(sd)) ? "on" : "off");
+			str_on_off(in_free_run(sd)));
 	v4l2_info(sd, "Prim-mode = 0x%x, video std = 0x%x, v_freq = 0x%x\n",
 			io_read(sd, 0x01) & 0x0f, io_read(sd, 0x00) & 0x3f,
 			(io_read(sd, 0x01) & 0x70) >> 4);
@@ -2627,7 +2627,7 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
 			(reg_io_0x02 & 0x02) ? "RGB" : "YCbCr",
 			(((reg_io_0x02 >> 2) & 0x01) ^ (reg_io_0x02 & 0x01)) ?
 				"(16-235)" : "(0-255)",
-			(reg_io_0x02 & 0x08) ? "enabled" : "disabled");
+			str_enabled_disabled(reg_io_0x02 & 0x08));
 	v4l2_info(sd, "Color space conversion: %s\n",
 			csc_coeff_sel_rb[cp_read(sd, info->cp_csc) >> 4]);
 
@@ -2638,9 +2638,9 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
 	v4l2_info(sd, "Digital video port selected: %c\n",
 			(hdmi_read(sd, 0x00) & 0x03) + 'A');
 	v4l2_info(sd, "HDCP encrypted content: %s\n",
-			(hdmi_read(sd, 0x05) & 0x40) ? "true" : "false");
+			str_true_false(hdmi_read(sd, 0x05) & 0x40));
 	v4l2_info(sd, "HDCP keys read: %s%s\n",
-			(hdmi_read(sd, 0x04) & 0x20) ? "yes" : "no",
+			str_yes_no(hdmi_read(sd, 0x04) & 0x20),
 			(hdmi_read(sd, 0x04) & 0x10) ? "ERROR" : "");
 	if (is_hdmi(sd)) {
 		bool audio_pll_locked = hdmi_read(sd, 0x04) & 0x01;
@@ -2661,7 +2661,8 @@ static int adv76xx_log_status(struct v4l2_subdev *sd)
 		v4l2_info(sd, "Audio N: %u\n", ((hdmi_read(sd, 0x5d) & 0x0f) << 16) +
 				(hdmi_read(sd, 0x5e) << 8) +
 				hdmi_read(sd, 0x5f));
-		v4l2_info(sd, "AV Mute: %s\n", (hdmi_read(sd, 0x04) & 0x40) ? "on" : "off");
+		v4l2_info(sd, "AV Mute: %s\n",
+			  str_on_off(hdmi_read(sd, 0x04) & 0x40));
 
 		v4l2_info(sd, "Deep color mode: %s\n", deep_color_mode_txt[(hdmi_read(sd, 0x0b) & 0x60) >> 5]);
 		v4l2_info(sd, "HDMI colorspace: %s\n", hdmi_color_space_txt[hdmi_read(sd, 0x53) & 0xf]);

-- 
2.46.1.824.gd892dcdcdd-goog

