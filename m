From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:12 +0000
Subject: [PATCH 17/45] media: bttv: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-17-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/pci/bt8xx/bttv-driver.c:2988:5-31: opportunity for str_yes_no(dstat & BT848_DSTATUS_HLOC)
drivers/media/pci/bt8xx/bttv-driver.c:2992:5-31: opportunity for str_yes_no(dstat & BT848_DSTATUS_PRES)
drivers/media/pci/bt8xx/bttv-cards.c:3039:13-22: opportunity for str_yes_no(has_radio)
drivers/media/pci/bt8xx/bttv-cards.c:3040:2-12: opportunity for str_yes_no(has_remote)
drivers/media/pci/bt8xx/bttv-cards.c:3043:2-21: opportunity for str_yes_no(has_tda9820_tda9821)
drivers/media/pci/bt8xx/bttv-cards.c:3044:2-17: opportunity for str_yes_no(is_capture_only)
drivers/media/pci/bt8xx/bttv-cards.c:3042:13-20: opportunity for str_yes_no(is_lr90)
drivers/media/pci/bt8xx/bttv-cards.c:4080:8-19: opportunity for str_yes_no(tuner_tv_fm)
drivers/media/pci/bt8xx/bttv-cards.c:3140:24-38: opportunity for str_yes_no(btv -> has_radio)
drivers/media/pci/bt8xx/bttv-cards.c:4081:8-23: opportunity for str_yes_no(btv -> has_remote)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/bt8xx/bttv-cards.c  | 16 ++++++++--------
 drivers/media/pci/bt8xx/bttv-driver.c |  6 ++----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bttv-cards.c b/drivers/media/pci/bt8xx/bttv-cards.c
index 867c1308de23..f989b5ed28fd 100644
--- a/drivers/media/pci/bt8xx/bttv-cards.c
+++ b/drivers/media/pci/bt8xx/bttv-cards.c
@@ -3036,12 +3036,12 @@ static void flyvideo_gpio(struct bttv *btv)
 		tuner_type = TUNER_ABSENT; /* No tuner present */
 
 	pr_info("%d: FlyVideo Radio=%s RemoteControl=%s Tuner=%d gpio=0x%06x\n",
-		btv->c.nr, has_radio ? "yes" : "no",
-		has_remote ? "yes" : "no", tuner_type, gpio);
+		btv->c.nr, str_yes_no(has_radio),
+		str_yes_no(has_remote), tuner_type, gpio);
 	pr_info("%d: FlyVideo  LR90=%s tda9821/tda9820=%s capture_only=%s\n",
-		btv->c.nr, is_lr90 ? "yes" : "no",
-		has_tda9820_tda9821 ? "yes" : "no",
-		is_capture_only ? "yes" : "no");
+		btv->c.nr, str_yes_no(is_lr90),
+		str_yes_no(has_tda9820_tda9821),
+		str_yes_no(is_capture_only));
 
 	if (tuner_type != UNSET) /* only set if known tuner autodetected, else let insmod option through */
 		btv->tuner_type = tuner_type;
@@ -3137,7 +3137,7 @@ static void miro_pinnacle_gpio(struct bttv *btv)
 		if (-1 != msp)
 			btv->c.type = BTTV_BOARD_PINNACLEPRO;
 		pr_info("%d: pinnacle/mt: id=%d info=\"%s\" radio=%s\n",
-			btv->c.nr, id, info, btv->has_radio ? "yes" : "no");
+			btv->c.nr, id, info, str_yes_no(btv->has_radio));
 		btv->tuner_type = TUNER_MT2032;
 	}
 }
@@ -4077,8 +4077,8 @@ static void avermedia_eeprom(struct bttv *btv)
 	} else
 		pr_cont("Unknown type");
 	pr_cont(" radio:%s remote control:%s\n",
-	       tuner_tv_fm     ? "yes" : "no",
-	       btv->has_remote ? "yes" : "no");
+	       str_yes_no(tuner_tv_fm),
+	       str_yes_no(btv->has_remote));
 }
 
 /*
diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 511f013cc338..fdad666d3d0f 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -2985,12 +2985,10 @@ static irqreturn_t bttv_irq(int irq, void *dev_id)
 			bttv_print_irqbits(stat,astat);
 			if (stat & BT848_INT_HLOCK)
 				pr_cont("   HLOC => %s",
-					dstat & BT848_DSTATUS_HLOC
-					? "yes" : "no");
+					str_yes_no(dstat & BT848_DSTATUS_HLOC));
 			if (stat & BT848_INT_VPRES)
 				pr_cont("   PRES => %s",
-					dstat & BT848_DSTATUS_PRES
-					? "yes" : "no");
+					str_yes_no(dstat & BT848_DSTATUS_PRES));
 			if (stat & BT848_INT_FMTCHG)
 				pr_cont("   NUML => %s",
 					dstat & BT848_DSTATUS_NUML

-- 
2.46.1.824.gd892dcdcdd-goog

