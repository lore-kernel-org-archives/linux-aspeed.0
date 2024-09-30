From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:00 +0000
Subject: [PATCH 05/45] media: pvrusb2:Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-5-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/usb/pvrusb2/pvrusb2-hdw.c:341:11-14: opportunity for str_true_false(val)
drivers/media/usb/pvrusb2/pvrusb2-hdw.c:1727:6-17: opportunity for str_enable_disable(enable_flag)
drivers/media/usb/pvrusb2/pvrusb2-hdw.c:1663:6-14: opportunity for str_on_off(enablefl)
drivers/media/usb/pvrusb2/pvrusb2-encoder.c:265:8-29: opportunity for str_true_false(hdw -> state_encoder_ok)
drivers/media/usb/pvrusb2/pvrusb2-encoder.c:271:9-33: opportunity for str_true_false(hdw -> state_encoder_runok)
drivers/media/usb/pvrusb2/pvrusb2-ctrl.c:524:35-38: opportunity for str_true_false(val)
drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c:475:11-37: opportunity for str_read_write(msgs [ idx ] . flags & I2C_M_RD)
drivers/media/usb/pvrusb2/pvrusb2-debugifc.c:151:4-31: opportunity for str_on_off(pvr2_hdw_get_streaming ( hdw ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-ctrl.c     | 2 +-
 drivers/media/usb/pvrusb2/pvrusb2-debugifc.c | 3 ++-
 drivers/media/usb/pvrusb2/pvrusb2-encoder.c  | 5 ++---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c      | 6 +++---
 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c | 3 +--
 5 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-ctrl.c b/drivers/media/usb/pvrusb2/pvrusb2-ctrl.c
index 8ae3ad80cccb..b6c9bda214c8 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-ctrl.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-ctrl.c
@@ -521,7 +521,7 @@ int pvr2_ctrl_value_to_sym_internal(struct pvr2_ctrl *cptr,
 		*len = scnprintf(buf,maxlen,"%d",val);
 		ret = 0;
 	} else if (cptr->info->type == pvr2_ctl_bool) {
-		*len = scnprintf(buf,maxlen,"%s",val ? "true" : "false");
+		*len = scnprintf(buf, maxlen, "%s", str_true_false(val));
 		ret = 0;
 	} else if (cptr->info->type == pvr2_ctl_enum) {
 		const char * const *names;
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-debugifc.c b/drivers/media/usb/pvrusb2/pvrusb2-debugifc.c
index 81d711269ab5..9e4eb03133c9 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-debugifc.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-debugifc.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include "pvrusb2-debugifc.h"
 #include "pvrusb2-hdw.h"
 #include "pvrusb2-debug.h"
@@ -148,7 +149,7 @@ int pvr2_debugifc_print_status(struct pvr2_hdw *hdw,
 	bcnt += ccnt; acnt -= ccnt; buf += ccnt;
 
 	ccnt = scnprintf(buf,acnt,"Streaming is %s\n",
-			 pvr2_hdw_get_streaming(hdw) ? "on" : "off");
+			 str_on_off(pvr2_hdw_get_streaming(hdw)));
 	bcnt += ccnt; acnt -= ccnt; buf += ccnt;
 
 
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-encoder.c b/drivers/media/usb/pvrusb2/pvrusb2-encoder.c
index c8102772344b..8a2464744e5b 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-encoder.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-encoder.c
@@ -262,14 +262,13 @@ rdData[0]);
 			pvr2_trace(PVR2_TRACE_STBITS,
 				   "State bit %s <-- %s",
 				   "state_encoder_ok",
-				   (hdw->state_encoder_ok ? "true" : "false"));
+				   str_true_false(hdw->state_encoder_ok));
 			if (hdw->state_encoder_runok) {
 				hdw->state_encoder_runok = 0;
 				pvr2_trace(PVR2_TRACE_STBITS,
 				   "State bit %s <-- %s",
 					   "state_encoder_runok",
-					   (hdw->state_encoder_runok ?
-					    "true" : "false"));
+					   str_true_false(hdw->state_encoder_runok));
 			}
 			pvr2_trace(
 				PVR2_TRACE_ERROR_LEGS,
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 29cc207194b9..761d718478ca 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -338,7 +338,7 @@ static void trace_stbit(const char *name,int val)
 {
 	pvr2_trace(PVR2_TRACE_STBITS,
 		   "State bit %s <-- %s",
-		   name,(val ? "true" : "false"));
+		   name, str_true_false(val));
 }
 
 static int ctrl_channelfreq_get(struct pvr2_ctrl *cptr,int *vp)
@@ -1660,7 +1660,7 @@ static int pvr2_decoder_enable(struct pvr2_hdw *hdw,int enablefl)
 	   anyway, just in case somebody else wants to hear the
 	   command... */
 	pvr2_trace(PVR2_TRACE_CHIPS, "subdev v4l2 stream=%s",
-		   (enablefl ? "on" : "off"));
+		   str_on_off(enablefl));
 	v4l2_device_call_all(&hdw->v4l2_dev, 0, video, s_stream, enablefl);
 	v4l2_device_call_all(&hdw->v4l2_dev, 0, audio, s_stream, enablefl);
 	if (hdw->decoder_client_id) {
@@ -1724,7 +1724,7 @@ int pvr2_hdw_set_streaming(struct pvr2_hdw *hdw,int enable_flag)
 		hdw->state_pipeline_req = enable_flag != 0;
 		pvr2_trace(PVR2_TRACE_START_STOP,
 			   "/*--TRACE_STREAM--*/ %s",
-			   enable_flag ? "enable" : "disable");
+			   str_enable_disable(enable_flag));
 	}
 	pvr2_hdw_state_sched(hdw);
 	LOCK_GIVE(hdw->big_lock);
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
index 63db04fe12d3..60a0df018334 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
@@ -472,8 +472,7 @@ static int pvr2_i2c_xfer(struct i2c_adapter *i2c_adap,
 			       idx+1,num,
 			       msgs[idx].addr,
 			       cnt,
-			       (msgs[idx].flags & I2C_M_RD ?
-				"read" : "write"));
+			       str_read_write(msgs[idx].flags & I2C_M_RD));
 			if ((ret > 0) || !(msgs[idx].flags & I2C_M_RD)) {
 				if (cnt > 8) cnt = 8;
 				pr_cont(" [");

-- 
2.46.1.824.gd892dcdcdd-goog

