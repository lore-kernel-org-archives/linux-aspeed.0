From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:09 +0000
Subject: [PATCH 14/45] media: saa7134: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-14-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/pci/saa7134/saa7134-cards.c:7984:7-16: opportunity for str_yes_no(( 1 == rc ))
drivers/media/pci/saa7134/saa7134-dvb.c:93:31-33: opportunity for str_on_off(ok)
drivers/media/pci/saa7134/saa7134-input.c:919:3-12: opportunity for str_yes_no(( rc == 1 ))
drivers/media/pci/saa7134/saa7134-input.c:898:3-12: opportunity for str_yes_no(( 1 == rc ))
drivers/media/pci/saa7134/saa7134-input.c:934:3-12: opportunity for str_yes_no(( 1 == rc ))
drivers/media/pci/saa7134/saa7134-video.c:622:10-15: opportunity for str_enabled_disabled(flags)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/saa7134/saa7134-cards.c | 2 +-
 drivers/media/pci/saa7134/saa7134-dvb.c   | 2 +-
 drivers/media/pci/saa7134/saa7134-input.c | 6 +++---
 drivers/media/pci/saa7134/saa7134-video.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-cards.c b/drivers/media/pci/saa7134/saa7134-cards.c
index e80fb4ebfda6..79cd61fb0205 100644
--- a/drivers/media/pci/saa7134/saa7134-cards.c
+++ b/drivers/media/pci/saa7134/saa7134-cards.c
@@ -7981,7 +7981,7 @@ int saa7134_board_init2(struct saa7134_dev *dev)
 			rc = i2c_transfer(&dev->i2c_adap, &msg, 1);
 			pr_info("%s: probe IR chip @ i2c 0x%02x: %s\n",
 				   dev->name, msg.addr,
-				   (1 == rc) ? "yes" : "no");
+				   str_yes_no(rc == 1));
 			if (rc == 1)
 				dev->has_remote = SAA7134_REMOTE_I2C;
 		}
diff --git a/drivers/media/pci/saa7134/saa7134-dvb.c b/drivers/media/pci/saa7134/saa7134-dvb.c
index 6de8a02314af..d0e58a0156f7 100644
--- a/drivers/media/pci/saa7134/saa7134-dvb.c
+++ b/drivers/media/pci/saa7134/saa7134-dvb.c
@@ -90,7 +90,7 @@ static int pinnacle_antenna_pwr(struct saa7134_dev *dev, int on)
 	saa_setl(SAA7134_GPIO_GPSTATUS0 >> 2,   (1 << 28));
 	udelay(10);
 	ok = saa_readl(SAA7134_GPIO_GPSTATUS0) & (1 << 27);
-	pr_debug("%s %s\n", __func__, ok ? "on" : "off");
+	pr_debug("%s %s\n", __func__, str_on_off(ok));
 
 	if (!ok)
 		saa_clearl(SAA7134_GPIO_GPSTATUS0 >> 2,   (1 << 26));
diff --git a/drivers/media/pci/saa7134/saa7134-input.c b/drivers/media/pci/saa7134/saa7134-input.c
index 8610eb473b39..239f0b9d080a 100644
--- a/drivers/media/pci/saa7134/saa7134-input.c
+++ b/drivers/media/pci/saa7134/saa7134-input.c
@@ -895,7 +895,7 @@ void saa7134_probe_i2c_ir(struct saa7134_dev *dev)
 		rc = i2c_transfer(&dev->i2c_adap, &msg_msi, 1);
 		input_dbg("probe 0x%02x @ %s: %s\n",
 			msg_msi.addr, dev->i2c_adap.name,
-			(1 == rc) ? "yes" : "no");
+			str_yes_no(rc == 1));
 		break;
 	case SAA7134_BOARD_SNAZIO_TVPVR_PRO:
 		dev->init_data.name = "SnaZio* TVPVR PRO";
@@ -916,7 +916,7 @@ void saa7134_probe_i2c_ir(struct saa7134_dev *dev)
 		rc = i2c_transfer(&dev->i2c_adap, &msg_msi, 1);
 		input_dbg("probe 0x%02x @ %s: %s\n",
 			msg_msi.addr, dev->i2c_adap.name,
-			(rc == 1) ? "yes" : "no");
+			str_yes_no(rc == 1));
 		break;
 	case SAA7134_BOARD_KWORLD_PC150U:
 		/* copied and modified from MSI TV at nywhere Plus */
@@ -931,7 +931,7 @@ void saa7134_probe_i2c_ir(struct saa7134_dev *dev)
 		rc = i2c_transfer(&dev->i2c_adap, &msg_msi, 1);
 		input_dbg("probe 0x%02x @ %s: %s\n",
 			msg_msi.addr, dev->i2c_adap.name,
-			(1 == rc) ? "yes" : "no");
+			str_yes_no(rc == 1));
 		break;
 	case SAA7134_BOARD_HAUPPAUGE_HVR1110:
 		dev->init_data.name = saa7134_boards[dev->board].name;
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 56b4481a40e6..1c02fb04abdf 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -619,7 +619,7 @@ static int saa7134_enable_analog_tuner(struct saa7134_dev *dev)
 		if (ret) {
 			pr_err("Couldn't change link %s->%s to %s. Error %d\n",
 			       source->name, sink->name,
-			       flags ? "enabled" : "disabled",
+			       str_enabled_disabled(flags),
 			       ret);
 			return ret;
 		}

-- 
2.46.1.824.gd892dcdcdd-goog

