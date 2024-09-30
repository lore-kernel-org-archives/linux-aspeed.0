From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:03 +0000
Subject: [PATCH 08/45] media: dvb-usb-v2: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-8-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:250:3-22: opportunity for str_yes_no(adap -> pid_filtering)
drivers/media/usb/dvb-usb-v2/dvb_usb_core.c:337:3-22: opportunity for str_yes_no(adap -> pid_filtering)
drivers/media/usb/dvb-usb-v2/az6007.c:82:32-38: opportunity for str_enable_disable(enable)
drivers/media/usb/dvb-usb-v2/az6007.c:192:32-37: opportunity for str_enable_disable(onoff)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/dvb-usb-v2/az6007.c       | 4 ++--
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 2410054ddb2c..1e9f946193a6 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -79,7 +79,7 @@ static int drxk_gate_ctrl(struct dvb_frontend *fe, int enable)
 	struct dvb_usb_adapter *adap = fe->sec_priv;
 	int status = 0;
 
-	pr_debug("%s: %s\n", __func__, enable ? "enable" : "disable");
+	pr_debug("%s: %s\n", __func__, str_enable_disable(enable));
 
 	if (!adap || !st)
 		return -EINVAL;
@@ -189,7 +189,7 @@ static int az6007_streaming_ctrl(struct dvb_frontend *fe, int onoff)
 {
 	struct dvb_usb_device *d = fe_to_d(fe);
 
-	pr_debug("%s: %s\n", __func__, onoff ? "enable" : "disable");
+	pr_debug("%s: %s\n", __func__, str_enable_disable(onoff));
 
 	return az6007_write(d, 0xbc, onoff, 0, NULL, 0);
 }
diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
index f1c79f351ec8..c0a40112d043 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
@@ -247,7 +247,7 @@ static int dvb_usb_start_feed(struct dvb_demux_feed *dvbdmxfeed)
 	dev_dbg(&d->udev->dev,
 			"%s: adap=%d active_fe=%d feed_type=%d setting pid [%s]: %04x (%04d) at index %d\n",
 			__func__, adap->id, adap->active_fe, dvbdmxfeed->type,
-			adap->pid_filtering ? "yes" : "no", dvbdmxfeed->pid,
+			str_yes_no(adap->pid_filtering), dvbdmxfeed->pid,
 			dvbdmxfeed->pid, dvbdmxfeed->index);
 
 	/* wait init is done */
@@ -334,7 +334,7 @@ static int dvb_usb_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 	dev_dbg(&d->udev->dev,
 			"%s: adap=%d active_fe=%d feed_type=%d setting pid [%s]: %04x (%04d) at index %d\n",
 			__func__, adap->id, adap->active_fe, dvbdmxfeed->type,
-			adap->pid_filtering ? "yes" : "no", dvbdmxfeed->pid,
+			str_yes_no(adap->pid_filtering), dvbdmxfeed->pid,
 			dvbdmxfeed->pid, dvbdmxfeed->index);
 
 	if (adap->active_fe == -1)

-- 
2.46.1.824.gd892dcdcdd-goog

