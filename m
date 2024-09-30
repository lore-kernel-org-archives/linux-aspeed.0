From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:07 +0000
Subject: [PATCH 12/45] media: dvb-frontends: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-12-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/dvb-frontends/cx24120.c:456:3-9: opportunity for str_enable_disable(enable)
drivers/media/dvb-frontends/cx24120.c:462:2-8: opportunity for str_enabled_disabled(enable)
drivers/media/dvb-frontends/helene.c:282:4-14: opportunity for str_read_write(write == 0)
drivers/media/dvb-frontends/cxd2841er.c:209:3-13: opportunity for str_read_write(write == 0)
drivers/media/dvb-frontends/drxk_hard.c:6282:22-28: opportunity for str_enable_disable(enable)
drivers/media/dvb-frontends/drxk_hard.c:1071:2-13: opportunity for str_enable_disable(mpeg_enable)
drivers/media/dvb-frontends/sp2.c:135:3-9: opportunity for str_read_write(( read ))
drivers/media/dvb-frontends/horus3a.c:41:3-13: opportunity for str_read_write(write == 0)
drivers/media/dvb-frontends/ascot2e.c:107:3-13: opportunity for str_read_write(write == 0)
drivers/media/usb/dvb-usb/af9005-fe.c:1282:27-31: opportunity for str_high_low(temp)
drivers/media/usb/dvb-usb/af9005-fe.c:790:30-32: opportunity for str_on_off(on)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-frontends/ascot2e.c   | 2 +-
 drivers/media/dvb-frontends/cx24120.c   | 4 ++--
 drivers/media/dvb-frontends/cxd2841er.c | 2 +-
 drivers/media/dvb-frontends/drxk_hard.c | 4 ++--
 drivers/media/dvb-frontends/helene.c    | 2 +-
 drivers/media/dvb-frontends/horus3a.c   | 2 +-
 drivers/media/dvb-frontends/sp2.c       | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/dvb-frontends/ascot2e.c b/drivers/media/dvb-frontends/ascot2e.c
index cf8e5f1bd101..ec7a718428fc 100644
--- a/drivers/media/dvb-frontends/ascot2e.c
+++ b/drivers/media/dvb-frontends/ascot2e.c
@@ -104,7 +104,7 @@ static void ascot2e_i2c_debug(struct ascot2e_priv *priv,
 			      u8 reg, u8 write, const u8 *data, u32 len)
 {
 	dev_dbg(&priv->i2c->dev, "ascot2e: I2C %s reg 0x%02x size %d\n",
-		(write == 0 ? "read" : "write"), reg, len);
+		str_write_read(write), reg, len);
 	print_hex_dump_bytes("ascot2e: I2C data: ",
 		DUMP_PREFIX_OFFSET, data, len);
 }
diff --git a/drivers/media/dvb-frontends/cx24120.c b/drivers/media/dvb-frontends/cx24120.c
index 44515fdbe91d..a02aaebb091a 100644
--- a/drivers/media/dvb-frontends/cx24120.c
+++ b/drivers/media/dvb-frontends/cx24120.c
@@ -453,13 +453,13 @@ static int cx24120_msg_mpeg_output_global_config(struct cx24120_state *state,
 	ret = cx24120_message_send(state, &cmd);
 	if (ret != 0) {
 		dev_dbg(&state->i2c->dev, "failed to %s MPEG output\n",
-			enable ? "enable" : "disable");
+			str_enable_disable(enable));
 		return ret;
 	}
 
 	state->mpeg_enabled = enable;
 	dev_dbg(&state->i2c->dev, "MPEG output %s\n",
-		enable ? "enabled" : "disabled");
+		str_enabled_disabled(enable));
 
 	return 0;
 }
diff --git a/drivers/media/dvb-frontends/cxd2841er.c b/drivers/media/dvb-frontends/cxd2841er.c
index d925ca24183b..d1b84cd9c510 100644
--- a/drivers/media/dvb-frontends/cxd2841er.c
+++ b/drivers/media/dvb-frontends/cxd2841er.c
@@ -206,7 +206,7 @@ static void cxd2841er_i2c_debug(struct cxd2841er_priv *priv,
 {
 	dev_dbg(&priv->i2c->dev,
 		"cxd2841er: I2C %s addr %02x reg 0x%02x size %d data %*ph\n",
-		(write == 0 ? "read" : "write"), addr, reg, len, len, data);
+		str_write_read(write), addr, reg, len, len, data);
 }
 
 static int cxd2841er_write_regs(struct cxd2841er_priv *priv,
diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 87f3d4f0eb8c..cbb1ba0f1323 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -1068,7 +1068,7 @@ static int mpegts_configure_pins(struct drxk_state *state, bool mpeg_enable)
 	u16 err_cfg = 0;
 
 	dprintk(1, ": mpeg %s, %s mode\n",
-		mpeg_enable ? "enable" : "disable",
+		str_enable_disable(mpeg_enable),
 		state->m_enable_parallel ? "parallel" : "serial");
 
 	/* stop lock indicator process */
@@ -6279,7 +6279,7 @@ static int drxk_gate_ctrl(struct dvb_frontend *fe, int enable)
 {
 	struct drxk_state *state = fe->demodulator_priv;
 
-	dprintk(1, ": %s\n", enable ? "enable" : "disable");
+	dprintk(1, ": %s\n", str_enable_disable(enable));
 
 	if (state->m_drxk_state == DRXK_NO_DEV)
 		return -ENODEV;
diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-frontends/helene.c
index f127adee3ebb..b4527c141d9c 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -279,7 +279,7 @@ static void helene_i2c_debug(struct helene_priv *priv,
 		u8 reg, u8 write, const u8 *data, u32 len)
 {
 	dev_dbg(&priv->i2c->dev, "helene: I2C %s reg 0x%02x size %d\n",
-			(write == 0 ? "read" : "write"), reg, len);
+			str_write_read(write), reg, len);
 	print_hex_dump_bytes("helene: I2C data: ",
 			DUMP_PREFIX_OFFSET, data, len);
 }
diff --git a/drivers/media/dvb-frontends/horus3a.c b/drivers/media/dvb-frontends/horus3a.c
index 0330b78a5b3f..10300ebf3ca0 100644
--- a/drivers/media/dvb-frontends/horus3a.c
+++ b/drivers/media/dvb-frontends/horus3a.c
@@ -38,7 +38,7 @@ static void horus3a_i2c_debug(struct horus3a_priv *priv,
 			      u8 reg, u8 write, const u8 *data, u32 len)
 {
 	dev_dbg(&priv->i2c->dev, "horus3a: I2C %s reg 0x%02x size %d\n",
-		(write == 0 ? "read" : "write"), reg, len);
+		str_write_read(write), reg, len);
 	print_hex_dump_bytes("horus3a: I2C data: ",
 		DUMP_PREFIX_OFFSET, data, len);
 }
diff --git a/drivers/media/dvb-frontends/sp2.c b/drivers/media/dvb-frontends/sp2.c
index 75adf2a4589f..0332e3c312c6 100644
--- a/drivers/media/dvb-frontends/sp2.c
+++ b/drivers/media/dvb-frontends/sp2.c
@@ -132,7 +132,7 @@ static int sp2_ci_op_cam(struct dvb_ca_en50221 *en50221, int slot, u8 acs,
 		return ret;
 
 	dev_dbg(&s->client->dev, "%s: slot=%d, addr=0x%04x, %s, data=%x",
-			(read) ? "read" : "write", slot, addr,
+			str_read_write(read), slot, addr,
 			(acs == SP2_CI_ATTR_ACS) ? "attr" : "io",
 			(read) ? mem : data);
 

-- 
2.46.1.824.gd892dcdcdd-goog

