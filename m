From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:38 +0000
Subject: [PATCH 43/45] media: i2c: adv7842: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-43-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/i2c/adv7842.c:2761:5-29: opportunity for str_true_false(io_read ( sd , 0x6f ) & 0x01)
drivers/media/i2c/adv7842.c:2754:5-29: opportunity for str_true_false(io_read ( sd , 0x6f ) & 0x02)
drivers/media/i2c/adv7842.c:2821:3-31: opportunity for str_true_false(( hdmi_read ( sd , 0x05 ) & 0x40 ))
drivers/media/i2c/adv7842.c:2763:5-31: opportunity for str_true_false(( io_read ( sd , 0x6a ) & 0x01 ))
drivers/media/i2c/adv7842.c:2756:5-31: opportunity for str_true_false(( io_read ( sd , 0x6a ) & 0x02 ))
drivers/media/i2c/adv7842.c:2765:5-31: opportunity for str_true_false(( io_read ( sd , 0x6a ) & 0x10 ))
drivers/media/i2c/adv7842.c:2758:5-31: opportunity for str_true_false(( io_read ( sd , 0x6a ) & 0x20 ))
drivers/media/i2c/adv7842.c:2736:4-22: opportunity for str_enabled_disabled(reg_io_0x21 & 0x01)
drivers/media/i2c/adv7842.c:2735:4-22: opportunity for str_enabled_disabled(reg_io_0x21 & 0x02)
drivers/media/i2c/adv7842.c:2737:28-51: opportunity for str_enabled_disabled(state -> cec_enabled_adap)
drivers/media/i2c/adv7842.c:2812:4-24: opportunity for str_enabled_disabled(( reg_io_0x02 & 0x08 ))
drivers/media/i2c/adv7842.c:2679:3-30: opportunity for str_enabled_disabled(( sdp_read ( sd , 0x12 ) & 0x08 ))
drivers/media/i2c/adv7842.c:2730:4-52: opportunity for str_enabled_disabled(( ( reg_rep_0x7d & 0x04 ) && ( reg_rep_0x77 & 0x04 ) ))
drivers/media/i2c/adv7842.c:2732:4-52: opportunity for str_enabled_disabled(( ( reg_rep_0x7d & 0x08 ) && ( reg_rep_0x77 & 0x08 ) ))
drivers/media/i2c/adv7842.c:2768:5-33: opportunity for str_on_off(! ! ( cp_read ( sd , 0xff ) & 0x10 ))
drivers/media/i2c/adv7842.c:2843:3-31: opportunity for str_on_off(( hdmi_read ( sd , 0x04 ) & 0x40 ))
drivers/media/i2c/adv7842.c:2654:2-29: opportunity for str_on_off(( sdp_read ( sd , 0x56 ) & 0x01 ))
drivers/media/i2c/adv7842.c:2823:3-31: opportunity for str_yes_no(( hdmi_read ( sd , 0x04 ) & 0x20 ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/adv7842.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index 014fc913225c..a43479c3ff03 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -2651,7 +2651,7 @@ static int adv7842_sdp_log_status(struct v4l2_subdev *sd)
 		  io_read(sd, 0x01) & 0x0f, io_read(sd, 0x00) & 0x3f);
 
 	v4l2_info(sd, "SDP: free run: %s\n",
-		(sdp_read(sd, 0x56) & 0x01) ? "on" : "off");
+		str_on_off(sdp_read(sd, 0x56) & 0x01));
 	v4l2_info(sd, "SDP: %s\n", sdp_signal_detected ?
 		"valid SD/PR signal detected" : "invalid/no signal");
 	if (sdp_signal_detected) {
@@ -2676,7 +2676,7 @@ static int adv7842_sdp_log_status(struct v4l2_subdev *sd)
 		v4l2_info(sd, "SDP: %s\n",
 			(sdp_read(sd, 0x57) & 0x08) ? "Interlaced" : "Progressive");
 		v4l2_info(sd, "SDP: deinterlacer %s\n",
-			(sdp_read(sd, 0x12) & 0x08) ? "enabled" : "disabled");
+			str_enabled_disabled(sdp_read(sd, 0x12) & 0x08));
 		v4l2_info(sd, "SDP: csc %s mode\n",
 			(sdp_io_read(sd, 0xe0) & 0x40) ? "auto" : "manual");
 	}
@@ -2727,15 +2727,13 @@ static int adv7842_cp_log_status(struct v4l2_subdev *sd)
 	v4l2_info(sd, "HDMI/DVI-D port selected: %s\n",
 			state->hdmi_port_a ? "A" : "B");
 	v4l2_info(sd, "EDID A %s, B %s\n",
-		  ((reg_rep_0x7d & 0x04) && (reg_rep_0x77 & 0x04)) ?
-		  "enabled" : "disabled",
-		  ((reg_rep_0x7d & 0x08) && (reg_rep_0x77 & 0x08)) ?
-		  "enabled" : "disabled");
+		  str_enabled_disabled((reg_rep_0x7d & 0x04) && (reg_rep_0x77 & 0x04)),
+		  str_enabled_disabled((reg_rep_0x7d & 0x08) && (reg_rep_0x77 & 0x08)));
 	v4l2_info(sd, "HPD A %s, B %s\n",
-		  reg_io_0x21 & 0x02 ? "enabled" : "disabled",
-		  reg_io_0x21 & 0x01 ? "enabled" : "disabled");
-	v4l2_info(sd, "CEC: %s\n", state->cec_enabled_adap ?
-			"enabled" : "disabled");
+		  str_enabled_disabled(reg_io_0x21 & 0x02),
+		  str_enabled_disabled(reg_io_0x21 & 0x01));
+	v4l2_info(sd, "CEC: %s\n",
+		  str_enabled_disabled(state->cec_enabled_adap));
 	if (state->cec_enabled_adap) {
 		int i;
 
@@ -2751,21 +2749,21 @@ static int adv7842_cp_log_status(struct v4l2_subdev *sd)
 	v4l2_info(sd, "-----Signal status-----\n");
 	if (state->hdmi_port_a) {
 		v4l2_info(sd, "Cable detected (+5V power): %s\n",
-			  io_read(sd, 0x6f) & 0x02 ? "true" : "false");
+			  str_true_false(io_read(sd, 0x6f) & 0x02));
 		v4l2_info(sd, "TMDS signal detected: %s\n",
-			  (io_read(sd, 0x6a) & 0x02) ? "true" : "false");
+			  str_true_false(io_read(sd, 0x6a) & 0x02));
 		v4l2_info(sd, "TMDS signal locked: %s\n",
-			  (io_read(sd, 0x6a) & 0x20) ? "true" : "false");
+			  str_true_false(io_read(sd, 0x6a) & 0x20));
 	} else {
 		v4l2_info(sd, "Cable detected (+5V power):%s\n",
-			  io_read(sd, 0x6f) & 0x01 ? "true" : "false");
+			  str_true_false(io_read(sd, 0x6f) & 0x01));
 		v4l2_info(sd, "TMDS signal detected: %s\n",
-			  (io_read(sd, 0x6a) & 0x01) ? "true" : "false");
+			  str_true_false(io_read(sd, 0x6a) & 0x01));
 		v4l2_info(sd, "TMDS signal locked: %s\n",
-			  (io_read(sd, 0x6a) & 0x10) ? "true" : "false");
+			  str_true_false(io_read(sd, 0x6a) & 0x10));
 	}
 	v4l2_info(sd, "CP free run: %s\n",
-		  (!!(cp_read(sd, 0xff) & 0x10) ? "on" : "off"));
+		  str_on_off(cp_read(sd, 0xff) & 0x10));
 	v4l2_info(sd, "Prim-mode = 0x%x, video std = 0x%x, v_freq = 0x%x\n",
 		  io_read(sd, 0x01) & 0x0f, io_read(sd, 0x00) & 0x3f,
 		  (io_read(sd, 0x01) & 0x70) >> 4);
@@ -2809,7 +2807,7 @@ static int adv7842_cp_log_status(struct v4l2_subdev *sd)
 		  (reg_io_0x02 & 0x02) ? "RGB" : "YCbCr",
 		  (((reg_io_0x02 >> 2) & 0x01) ^ (reg_io_0x02 & 0x01)) ?
 			"(16-235)" : "(0-255)",
-		  (reg_io_0x02 & 0x08) ? "enabled" : "disabled");
+		  str_enabled_disabled(reg_io_0x02 & 0x08));
 	v4l2_info(sd, "Color space conversion: %s\n",
 		  csc_coeff_sel_rb[cp_read(sd, 0xf4) >> 4]);
 
@@ -2818,9 +2816,9 @@ static int adv7842_cp_log_status(struct v4l2_subdev *sd)
 
 	v4l2_info(sd, "-----%s status-----\n", is_hdmi(sd) ? "HDMI" : "DVI-D");
 	v4l2_info(sd, "HDCP encrypted content: %s\n",
-			(hdmi_read(sd, 0x05) & 0x40) ? "true" : "false");
+			str_true_false(hdmi_read(sd, 0x05) & 0x40));
 	v4l2_info(sd, "HDCP keys read: %s%s\n",
-			(hdmi_read(sd, 0x04) & 0x20) ? "yes" : "no",
+			str_yes_no(hdmi_read(sd, 0x04) & 0x20),
 			(hdmi_read(sd, 0x04) & 0x10) ? "ERROR" : "");
 	if (!is_hdmi(sd))
 		return 0;
@@ -2840,7 +2838,7 @@ static int adv7842_cp_log_status(struct v4l2_subdev *sd)
 			(hdmi_read(sd, 0x5e) << 8) +
 			hdmi_read(sd, 0x5f));
 	v4l2_info(sd, "AV Mute: %s\n",
-			(hdmi_read(sd, 0x04) & 0x40) ? "on" : "off");
+			str_on_off(hdmi_read(sd, 0x04) & 0x40));
 	v4l2_info(sd, "Deep color mode: %s\n",
 			deep_color_mode_txt[hdmi_read(sd, 0x0b) >> 6]);
 

-- 
2.46.1.824.gd892dcdcdd-goog

