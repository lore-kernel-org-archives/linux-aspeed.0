From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:05 +0000
Subject: [PATCH 10/45] media: tuners: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-10-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/tuners/tda18250.c:110:3-12: opportunity for str_true_false(triggered)
drivers/media/tuners/tda9887.c:296:39-54: opportunity for str_high_low(( buf [ 0 ] & 0x20 ))
drivers/media/tuners/tda9887.c:298:39-54: opportunity for str_high_low(( buf [ 0 ] & 0x80 ))
drivers/media/tuners/tda9887.c:294:39-54: opportunity for str_yes_no(( buf [ 0 ] & 0x01 ))
drivers/media/tuners/tda9887.c:347:5-20: opportunity for str_yes_no(( buf [ 1 ] & 0x02 ))
drivers/media/tuners/tda9887.c:353:5-20: opportunity for str_yes_no(( buf [ 1 ] & 0x20 ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/tuners/tda18250.c |  2 +-
 drivers/media/tuners/tda9887.c  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/tuners/tda18250.c b/drivers/media/tuners/tda18250.c
index 68d0275f29e1..853600c80839 100644
--- a/drivers/media/tuners/tda18250.c
+++ b/drivers/media/tuners/tda18250.c
@@ -107,7 +107,7 @@ static int tda18250_wait_for_irq(struct dvb_frontend *fe,
 	dev_dbg(&client->dev, "waited IRQ (0x%02x) %d ms, triggered: %s", irq,
 			jiffies_to_msecs(jiffies) -
 			(jiffies_to_msecs(timeout) - maxwait),
-			triggered ? "true" : "false");
+			str_true_false(triggered));
 
 	if (!triggered)
 		return -ETIMEDOUT;
diff --git a/drivers/media/tuners/tda9887.c b/drivers/media/tuners/tda9887.c
index b2f7054c1832..f403dcf14aa0 100644
--- a/drivers/media/tuners/tda9887.c
+++ b/drivers/media/tuners/tda9887.c
@@ -291,11 +291,11 @@ static void dump_read_message(struct dvb_frontend *fe, unsigned char *buf)
 		"+ 12.5 kHz",
 	};
 	tuner_info("read: 0x%2x\n", buf[0]);
-	tuner_info("  after power on : %s\n", (buf[0] & 0x01) ? "yes" : "no");
+	tuner_info("  after power on : %s\n", str_yes_no(buf[0] & 0x01));
 	tuner_info("  afc            : %s\n", afc[(buf[0] >> 1) & 0x0f]);
-	tuner_info("  fmif level     : %s\n", (buf[0] & 0x20) ? "high" : "low");
+	tuner_info("  fmif level     : %s\n", str_high_low(buf[0] & 0x20));
 	tuner_info("  afc window     : %s\n", (buf[0] & 0x40) ? "in" : "out");
-	tuner_info("  vfi level      : %s\n", (buf[0] & 0x80) ? "high" : "low");
+	tuner_info("  vfi level      : %s\n", str_high_low(buf[0] & 0x80));
 }
 
 static void dump_write_message(struct dvb_frontend *fe, unsigned char *buf)
@@ -344,13 +344,13 @@ static void dump_write_message(struct dvb_frontend *fe, unsigned char *buf)
 	tuner_info("  B0   video mode      : %s\n",
 		   (buf[1] & 0x01) ? "video trap" : "sound trap");
 	tuner_info("  B1   auto mute fm    : %s\n",
-		   (buf[1] & 0x02) ? "yes" : "no");
+		   str_yes_no(buf[1] & 0x02));
 	tuner_info("  B2   carrier mode    : %s\n",
 		   (buf[1] & 0x04) ? "QSS" : "Intercarrier");
 	tuner_info("  B3-4 tv sound/radio  : %s\n",
 		   sound[(buf[1] & 0x18) >> 3]);
 	tuner_info("  B5   force mute audio: %s\n",
-		   (buf[1] & 0x20) ? "yes" : "no");
+		   str_yes_no(buf[1] & 0x20));
 	tuner_info("  B6   output port 1   : %s\n",
 		   (buf[1] & 0x40) ? "high (inactive)" : "low (active)");
 	tuner_info("  B7   output port 2   : %s\n",

-- 
2.46.1.824.gd892dcdcdd-goog

