Return-Path: <linux-aspeed+bounces-725-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB77C021AA
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Feb 2025 13:56:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YvYW83spGz30Yb;
	Sat, 15 Feb 2025 00:56:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.130.132.48
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739541396;
	cv=none; b=KonNWnNa0d7AdQoSnHQJqP5oQyu+QzOXewqth6s0wyCdsvSjQiHfMgLqElnzhJaNlsX+Uoiy1obZQDNQV/POjZe5frKgILtaBDdBOifd7tns+s9VT+FkySdhR8giOvgWOeDBLYvV3pSe6FcIkFhz5Q+F4+E1nrGCJb8juADxig15r8rISlG4DwhtLegJMloy14ACahQqqpw/QybqVNEp6E/50VaCZy1KZRkj/m84kuH3ixWQ+Nso59XCkzbUHWFUtA+zKlcKhXzbFwsdE0Rju0tiLOmMmGFZPzMUGUKduPIER4R98NWVdnM1riOWQSWer2cks4CIAl/ng4c4NWoXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739541396; c=relaxed/relaxed;
	bh=93ulIb07lVRTZ2bnlkiTriMPC+tNo5d60q3YMCPv/Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvZS7xbcHt6cshqxF7m5PeqZb0gozQihZIsYvAcbs5Dw0XgX12XbX384Bw9J2zFe2YczfBTE+mNIIwnsbKRmRLYRBKMGNeucLI0oM2MR26SP+vasL75rXGct+ITUKQyONfwaf8wk153YZOBoGqLzSA+Hsipjx0YqlMPhrvh55TiI79t6/ef/N3+En81T5hBspl7rG1OVUWKyyTzoy6wXuYJepbPLkHc3jckiMQjkEUQBpB9EpyBxFg/Aiew7rKDhZq70MFbksC4kwwbiaQLHeEcV3LnSfLny9TNSm/zvwk5wYqTcXSGtgVAu2+fi38y4WuYQd+W+HBqSkLYToOpOAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=195.130.132.48; helo=cantor.telenet-ops.be; envelope-from=geert@linux-m68k.org; receiver=lists.ozlabs.org) smtp.helo=cantor.telenet-ops.be
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=cantor.telenet-ops.be (client-ip=195.130.132.48; helo=cantor.telenet-ops.be; envelope-from=geert@linux-m68k.org; receiver=lists.ozlabs.org)
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YvYW76RmRz3blK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Feb 2025 00:56:35 +1100 (AEDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4YvYVz5S5dz4x0W8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Feb 2025 14:56:27 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:6395:73cc:7fc4:4cab])
	by albert.telenet-ops.be with cmsmtp
	id DRvu2E00L1MuxXz06RvuVQ; Fri, 14 Feb 2025 14:56:27 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAL-00000006p2f-11yq;
	Fri, 14 Feb 2025 14:55:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tiwAc-00000000qEk-1tKI;
	Fri, 14 Feb 2025 14:55:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH treewide v3 2/4] bitfield: Add non-constant field_{prep,get}() helpers
Date: Fri, 14 Feb 2025 14:55:51 +0100
Message-ID: <2d30e5ffe70ce35f952b7d497d2959391fbf0580.1739540679.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1739540679.git.geert+renesas@glider.be>
References: <cover.1739540679.git.geert+renesas@glider.be>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant.

To avoid this limitation, the AT91 clock driver and several other
drivers already have their own non-const field_{prep,get}() macros.
Make them available for general use by consolidating them in
<linux/bitfield.h>, and improve them slightly:
  1. Avoid evaluating macro parameters more than once,
  2. Replace "ffs() - 1" by "__ffs()",
  3. Support 64-bit use on 32-bit architectures.

This is deliberately not merged into the existing FIELD_{GET,PREP}()
macros, as people expressed the desire to keep stricter variants for
increased safety, or for performance critical paths.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3:
  - Add Acked-by,
  - Drop underscores from macro parameters,
  - Use __auto_type where possible,
  - Correctly cast reg to the mask type,
  - Introduces __val and __reg intermediates to simplify the actual
    operation,
  - Drop unneeded parentheses,
  - Clarify having both FIELD_{GET,PREP}() and field_{get,prep}(),

v2:
  - Cast val resp. reg to the mask type,
  - Fix 64-bit use on 32-bit architectures,
  - Convert new upstream users:
      - drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
      - drivers/gpio/gpio-aspeed.c
      - drivers/iio/temperature/mlx90614.c
      - drivers/pinctrl/nuvoton/pinctrl-ma35.c
      - sound/usb/mixer_quirks.c
  - Convert new user queued in renesas-devel for v6.15:
      - drivers/soc/renesas/rz-sysc.c
---
 drivers/clk/at91/clk-peripheral.c             |  1 +
 drivers/clk/at91/pmc.h                        |  3 --
 .../qat/qat_common/adf_gen4_pm_debugfs.c      |  8 +----
 drivers/gpio/gpio-aspeed.c                    |  5 +--
 drivers/iio/temperature/mlx90614.c            |  5 +--
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        |  4 ---
 drivers/soc/renesas/rz-sysc.c                 |  3 +-
 include/linux/bitfield.h                      | 36 +++++++++++++++++++
 sound/usb/mixer_quirks.c                      |  4 ---
 9 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index c173a44c800aa8cc..60208bdc3fe4797e 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2013 Boris BREZILLON <b.brezillon@overkiz.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 4fb29ca111f7d427..3838e4f7df2d4a70 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -116,9 +116,6 @@ struct at91_clk_pms {
 	unsigned int parent;
 };
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define ndck(a, s) (a[s - 1].id + 1)
 #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
index 2e4095c4c12c94f9..ebaa59e934178309 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2023 Intel Corporation */
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/string_helpers.h>
@@ -11,13 +12,6 @@
 #include "adf_gen4_pm.h"
 #include "icp_qat_fw_init_admin.h"
 
-/*
- * This is needed because a variable is used to index the mask at
- * pm_scnprint_table(), making it not compile time constant, so the compile
- * asserts from FIELD_GET() or u32_get_bits() won't be fulfilled.
- */
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 #define PM_INFO_MEMBER_OFF(member)	\
 	(offsetof(struct icp_qat_fw_init_admin_pm_info, member) / sizeof(u32))
 
diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 40c1bd80f8b0434d..b45e4dd8d8e4f00a 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -5,6 +5,7 @@
  * Joel Stanley <joel@jms.id.au>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/gpio/aspeed.h>
 #include <linux/gpio/driver.h>
@@ -30,10 +31,6 @@
 #include <linux/gpio/consumer.h>
 #include "gpiolib.h"
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define GPIO_G7_IRQ_STS_BASE 0x100
 #define GPIO_G7_IRQ_STS_OFFSET(x) (GPIO_G7_IRQ_STS_BASE + (x) * 0x4)
 #define GPIO_G7_CTRL_REG_BASE 0x180
diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 740018d4b3dfb35e..c58dc59d4f570831 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -22,6 +22,7 @@
  * the "wakeup" GPIO is not given, power management will be disabled.
  */
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
@@ -68,10 +69,6 @@
 #define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
 #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
-
 struct mlx_chip_info {
 	/* EEPROM offsets with 16-bit data, MSB first */
 	/* emissivity correction coefficient */
diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index 59c4e7c6cddea127..3ba28faa8e1418a9 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -81,10 +81,6 @@
 #define MVOLT_1800			0
 #define MVOLT_3300			1
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
-
 static const char * const gpio_group_name[] = {
 	"gpioa", "gpiob", "gpioc", "gpiod", "gpioe", "gpiof", "gpiog",
 	"gpioh", "gpioi", "gpioj", "gpiok", "gpiol", "gpiom", "gpion",
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 1c98da37b7d18745..917a029d849585cd 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -12,8 +13,6 @@
 
 #include "rz-sysc.h"
 
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 /**
  * struct rz_sysc - RZ SYSC private data structure
  * @base: SYSC base address
diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index e8269f23b824c4a9..4f43b00cc93d2f4f 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -203,4 +203,40 @@ __MAKE_OP(64)
 #undef __MAKE_OP
 #undef ____MAKE_OP
 
+/**
+ * field_prep() - prepare a bitfield element
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
+ *
+ * field_prep() masks and shifts up the value.  The result should be
+ * combined with other fields of the bitfield using logical OR.
+ * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
+ */
+#define field_prep(mask, val)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(mask) __val = (val);				\
+		unsigned int __shift = sizeof(mask) <= 4 ?		\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__val << __shift) & __mask;	\
+	})
+
+/**
+ * field_get() - extract a bitfield element
+ * @mask: shifted mask defining the field's length and position
+ * @reg:  value of entire bitfield
+ *
+ * field_get() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
+ * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
+ */
+#define field_get(mask, reg)						\
+	({								\
+		__auto_type __mask = (mask);				\
+		typeof(mask) __reg =  (reg);				\
+		unsigned int __shift = sizeof(mask) <= 4 ?		\
+				       __ffs(__mask) : __ffs64(__mask);	\
+		(__reg & __mask) >> __shift;	\
+	})
+
 #endif
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index ed6127b0389fff39..5899576c915b0a7e 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3110,10 +3110,6 @@ static int snd_bbfpro_controls_create(struct usb_mixer_interface *mixer)
 #define RME_DIGIFACE_REGISTER(reg, mask) (((reg) << 16) | (mask))
 #define RME_DIGIFACE_INVERT BIT(31)
 
-/* Nonconst helpers */
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 static int snd_rme_digiface_write_reg(struct snd_kcontrol *kcontrol, int item, u16 mask, u16 val)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
-- 
2.43.0


