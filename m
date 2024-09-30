From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:02 +0000
Subject: [PATCH 07/45] media: dvb-usb: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-7-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/usb/dvb-usb/opera1.c:326:26-31: opportunity for str_enable_disable(onoff)
drivers/media/usb/dvb-usb/opera1.c:310:3-8: opportunity for str_on_off(onoff)
drivers/media/usb/dvb-usb/opera1.c:283:19-24: opportunity for str_on_off(onoff)
drivers/media/usb/dvb-usb/opera1.c:296:23-28: opportunity for str_on_off(onoff)
drivers/media/usb/dvb-usb/dvb-usb-dvb.c:49:21-26: opportunity for str_on_off(onoff)
drivers/media/usb/dvb-usb/dvb-usb-dvb.c:47:2-46: opportunity for str_yes_no(adap -> fe_adap [ adap -> active_fe ] . pid_filtering)
drivers/media/usb/dvb-usb/af9005-fe.c:1282:27-31: opportunity for str_high_low(temp)
drivers/media/usb/dvb-usb/af9005-fe.c:790:30-32: opportunity for str_on_off(on)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/dvb-usb/af9005-fe.c   | 4 ++--
 drivers/media/usb/dvb-usb/dvb-usb-dvb.c | 6 +++---
 drivers/media/usb/dvb-usb/opera1.c      | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/af9005-fe.c b/drivers/media/usb/dvb-usb/af9005-fe.c
index 404e56b32145..ea3aaf3a56cb 100644
--- a/drivers/media/usb/dvb-usb/af9005-fe.c
+++ b/drivers/media/usb/dvb-usb/af9005-fe.c
@@ -787,7 +787,7 @@ static int af9005_fe_power(struct dvb_frontend *fe, int on)
 	struct af9005_fe_state *state = fe->demodulator_priv;
 	u8 temp = on;
 	int ret;
-	deb_info("power %s tuner\n", on ? "on" : "off");
+	deb_info("power %s tuner\n", str_on_off(on));
 	ret = af9005_send_command(state->d, 0x03, &temp, 1, NULL, 0);
 	return ret;
 }
@@ -1279,7 +1279,7 @@ static int af9005_fe_get_frontend(struct dvb_frontend *fe,
 	if (ret)
 		return ret;
 	/* if temp is set = high priority */
-	deb_info("PRIORITY %s\n", temp ? "high" : "low");
+	deb_info("PRIORITY %s\n", str_high_low(temp));
 
 	/* high coderate */
 	ret =
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
index 0a7f8ba90992..b663c3dff25c 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-dvb.c
@@ -44,9 +44,9 @@ static int dvb_usb_ctrl_feed(struct dvb_demux_feed *dvbdmxfeed, int onoff)
 
 	/* activate the pid on the device specific pid_filter */
 	deb_ts("setting pid (%s): %5d %04x at index %d '%s'\n",
-		adap->fe_adap[adap->active_fe].pid_filtering ?
-		"yes" : "no", dvbdmxfeed->pid, dvbdmxfeed->pid,
-		dvbdmxfeed->index, onoff ? "on" : "off");
+		str_yes_no(adap->fe_adap[adap->active_fe].pid_filtering),
+		dvbdmxfeed->pid, dvbdmxfeed->pid,
+		dvbdmxfeed->index, str_on_off(onoff));
 	if (adap->props.fe[adap->active_fe].caps & DVB_USB_ADAP_HAS_PID_FILTER &&
 		adap->fe_adap[adap->active_fe].pid_filtering &&
 		adap->props.fe[adap->active_fe].pid_filter != NULL)
diff --git a/drivers/media/usb/dvb-usb/opera1.c b/drivers/media/usb/dvb-usb/opera1.c
index 268f05fc8691..8412b64660d8 100644
--- a/drivers/media/usb/dvb-usb/opera1.c
+++ b/drivers/media/usb/dvb-usb/opera1.c
@@ -280,7 +280,7 @@ static int opera1_power_ctrl(struct dvb_usb_device *d, int onoff)
 	u8 val = onoff ? 0x01 : 0x00;
 
 	if (dvb_usb_opera1_debug)
-		info("power %s", onoff ? "on" : "off");
+		info("power %s", str_on_off(onoff));
 	return opera1_xilinx_rw(d->udev, 0xb7, val,
 				&val, 1, OPERA_WRITE_MSG);
 }
@@ -293,7 +293,7 @@ static int opera1_streaming_ctrl(struct dvb_usb_adapter *adap, int onoff)
 		{.addr = ADDR_B1A6_STREAM_CTRL,.buf = onoff ? buf_start : buf_stop,.len = 2},
 	};
 	if (dvb_usb_opera1_debug)
-		info("streaming %s", onoff ? "on" : "off");
+		info("streaming %s", str_on_off(onoff));
 	i2c_transfer(&adap->dev->i2c_adap, start_tuner, 1);
 	return 0;
 }
@@ -307,7 +307,7 @@ static int opera1_pid_filter(struct dvb_usb_adapter *adap, int index, u16 pid,
 	};
 	if (dvb_usb_opera1_debug)
 		info("pidfilter index: %d pid: %d %s", index, pid,
-			onoff ? "on" : "off");
+			str_on_off(onoff));
 	b_pid[0] = (2 * index) + 4;
 	b_pid[1] = onoff ? (pid & 0xff) : (0x00);
 	b_pid[2] = onoff ? ((pid >> 8) & 0xff) : (0x00);
@@ -323,7 +323,7 @@ static int opera1_pid_filter_control(struct dvb_usb_adapter *adap, int onoff)
 		{.addr = ADDR_B1A6_STREAM_CTRL,.buf = b_pid,.len = 3},
 	};
 	if (dvb_usb_opera1_debug)
-		info("%s hw-pidfilter", onoff ? "enable" : "disable");
+		info("%s hw-pidfilter", str_enable_disable(onoff));
 	for (; u < 0x7e; u += 2) {
 		b_pid[0] = u;
 		b_pid[1] = 0;

-- 
2.46.1.824.gd892dcdcdd-goog

