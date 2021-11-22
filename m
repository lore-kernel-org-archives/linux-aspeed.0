From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:54:09 +0100
Subject: [PATCH/RFC 16/17] ALSA: ice1724: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <45fa162856814176045ffbb49ee64cf0ea7e00bc.1637592133.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the field_{get,prep}() helpers, instead of open-coding the same
operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
Marked RFC, as this depends on [PATCH 01/17], but follows a different
path to upstream.
---
 sound/pci/ice1712/wm8766.c | 14 +++++++-------
 sound/pci/ice1712/wm8776.c | 14 +++++++-------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/pci/ice1712/wm8766.c b/sound/pci/ice1712/wm8766.c
index fe3e243b38549035..3e4d7f8f692785b0 100644
--- a/sound/pci/ice1712/wm8766.c
+++ b/sound/pci/ice1712/wm8766.c
@@ -7,6 +7,7 @@
  *	Copyright (c) 2012 Ondrej Zary <linux@rainbow-software.org>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -212,11 +213,10 @@ static int snd_wm8766_ctl_get(struct snd_kcontrol *kcontrol,
 	if (wm->ctl[n].get)
 		wm->ctl[n].get(wm, &val1, &val2);
 	else {
-		val1 = wm->regs[wm->ctl[n].reg1] & wm->ctl[n].mask1;
-		val1 >>= __ffs(wm->ctl[n].mask1);
+		val1 = field_get(wm->ctl[n].mask1, wm->regs[wm->ctl[n].reg1]);
 		if (wm->ctl[n].flags & WM8766_FLAG_STEREO) {
-			val2 = wm->regs[wm->ctl[n].reg2] & wm->ctl[n].mask2;
-			val2 >>= __ffs(wm->ctl[n].mask2);
+			val2 = field_get(wm->ctl[n].mask2,
+					 wm->regs[wm->ctl[n].reg2]);
 			if (wm->ctl[n].flags & WM8766_FLAG_VOL_UPDATE)
 				val2 &= ~WM8766_VOL_UPDATE;
 		}
@@ -251,19 +251,19 @@ static int snd_wm8766_ctl_put(struct snd_kcontrol *kcontrol,
 		wm->ctl[n].set(wm, regval1, regval2);
 	else {
 		val = wm->regs[wm->ctl[n].reg1] & ~wm->ctl[n].mask1;
-		val |= regval1 << __ffs(wm->ctl[n].mask1);
+		val |= field_prep(wm->ctl[n].mask1, regval1);
 		/* both stereo controls in one register */
 		if (wm->ctl[n].flags & WM8766_FLAG_STEREO &&
 				wm->ctl[n].reg1 == wm->ctl[n].reg2) {
 			val &= ~wm->ctl[n].mask2;
-			val |= regval2 << __ffs(wm->ctl[n].mask2);
+			val |= field_prep(wm->ctl[n].mask2, regval2);
 		}
 		snd_wm8766_write(wm, wm->ctl[n].reg1, val);
 		/* stereo controls in different registers */
 		if (wm->ctl[n].flags & WM8766_FLAG_STEREO &&
 				wm->ctl[n].reg1 != wm->ctl[n].reg2) {
 			val = wm->regs[wm->ctl[n].reg2] & ~wm->ctl[n].mask2;
-			val |= regval2 << __ffs(wm->ctl[n].mask2);
+			val |= field_prep(wm->ctl[n].mask2, regval2);
 			if (wm->ctl[n].flags & WM8766_FLAG_VOL_UPDATE)
 				val |= WM8766_VOL_UPDATE;
 			snd_wm8766_write(wm, wm->ctl[n].reg2, val);
diff --git a/sound/pci/ice1712/wm8776.c b/sound/pci/ice1712/wm8776.c
index 6eda86119dff60b3..b4edf8a03c342351 100644
--- a/sound/pci/ice1712/wm8776.c
+++ b/sound/pci/ice1712/wm8776.c
@@ -7,6 +7,7 @@
  *	Copyright (c) 2012 Ondrej Zary <linux@rainbow-software.org>
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -486,11 +487,10 @@ static int snd_wm8776_ctl_get(struct snd_kcontrol *kcontrol,
 	if (wm->ctl[n].get)
 		wm->ctl[n].get(wm, &val1, &val2);
 	else {
-		val1 = wm->regs[wm->ctl[n].reg1] & wm->ctl[n].mask1;
-		val1 >>= __ffs(wm->ctl[n].mask1);
+		val1 = field_get(wm->ctl[n].mask1, wm->regs[wm->ctl[n].reg1]);
 		if (wm->ctl[n].flags & WM8776_FLAG_STEREO) {
-			val2 = wm->regs[wm->ctl[n].reg2] & wm->ctl[n].mask2;
-			val2 >>= __ffs(wm->ctl[n].mask2);
+			val2 = field_get(wm->ctl[n].mask2,
+					 wm->regs[wm->ctl[n].reg2]);
 			if (wm->ctl[n].flags & WM8776_FLAG_VOL_UPDATE)
 				val2 &= ~WM8776_VOL_UPDATE;
 		}
@@ -525,19 +525,19 @@ static int snd_wm8776_ctl_put(struct snd_kcontrol *kcontrol,
 		wm->ctl[n].set(wm, regval1, regval2);
 	else {
 		val = wm->regs[wm->ctl[n].reg1] & ~wm->ctl[n].mask1;
-		val |= regval1 << __ffs(wm->ctl[n].mask1);
+		val |= field_prep(wm->ctl[n].mask1, regval1);
 		/* both stereo controls in one register */
 		if (wm->ctl[n].flags & WM8776_FLAG_STEREO &&
 				wm->ctl[n].reg1 == wm->ctl[n].reg2) {
 			val &= ~wm->ctl[n].mask2;
-			val |= regval2 << __ffs(wm->ctl[n].mask2);
+			val |= field_prep(wm->ctl[n].mask2, regval2);
 		}
 		snd_wm8776_write(wm, wm->ctl[n].reg1, val);
 		/* stereo controls in different registers */
 		if (wm->ctl[n].flags & WM8776_FLAG_STEREO &&
 				wm->ctl[n].reg1 != wm->ctl[n].reg2) {
 			val = wm->regs[wm->ctl[n].reg2] & ~wm->ctl[n].mask2;
-			val |= regval2 << __ffs(wm->ctl[n].mask2);
+			val |= field_prep(wm->ctl[n].mask2, regval2);
 			if (wm->ctl[n].flags & WM8776_FLAG_VOL_UPDATE)
 				val |= WM8776_VOL_UPDATE;
 			snd_wm8776_write(wm, wm->ctl[n].reg2, val);
-- 
2.25.1

