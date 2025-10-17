Return-Path: <linux-aspeed+bounces-2495-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1710ECCD19A
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 10:54:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp1t94RkXz3ccS;
	Fri, 17 Oct 2025 21:54:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760698481;
	cv=none; b=lZmGwlemprJBOiO+RcvE9MWP7a01ld2evsahYC3h03y+BXCsbFNjLjtJFpvBi/1FXLBYr4i8Uggw+XH8BFftZJrhEwCqvEgCXRWgWi8ODsPfx97JLO3N4/C1warxbKgOZvBDAk7bFxak4QqtX4psabodWvWePnU9f7bM9FSHVBRwBUqz4qUTP2f3s0CqPeRSQ6OeZfOaoL0YqCmES8Ur36WHRoZH3jKtYqUJSMtBNWh7g9bklw2K3VLaj9nWgs+9EgfFYblOv9N9uuihZbDLnoxEbSRCRIzp36sFC9muTVTWo/sTv90pWoyShTzIEkfCLWexKJwUiXnUm5fVY2ovpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760698481; c=relaxed/relaxed;
	bh=Avg+PvzgJ2ryyS677CJfzcxOpCJhiMuXD395MGs9E+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+Y7DKdxwBF7LX8IdEOB7s48FLLVR7zS10fdWeqq1IHHVvVlZ2Ou+TV3q/f9dvTd3LzBvhk83brNfhi280g4nFa6ozd6lNhlEJ+Z5iU4hKeZlZqDhj2dAydp2J6p9ySyxLufR0Ps+5d1uwXWHvP6c8wcTR83XO7Yw02khR170JwSBi2fYgcP2QSQh/RURlbrk/7UfsUKOd5jqJXHVaOqtIOl5ToZCyar+mp+TkwoLrisYaLrKcw72TmgXtjFhPctwrBdH/FKOJOJI7lkBVCjT1TKnGskvBOCAq3sCYKsqta0JKukTeG0X/RFgba7gJy0S3Yw/JDb+MHjgvvIwffqoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=fde1=42=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=fde1=42=glider.be=geert+renesas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp1t81n5Xz3ccF
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 21:54:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 84EDC642C2;
	Fri, 17 Oct 2025 10:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4B6C4CEE7;
	Fri, 17 Oct 2025 10:54:28 +0000 (UTC)
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
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org,
	qat-linux@intel.com,
	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 0/4] Non-const bitfield helpers
Date: Fri, 17 Oct 2025 12:54:08 +0200
Message-ID: <cover.1760696560.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

<linux/bitfield.h> contains various helpers for accessing bitfields, as
typically used in hardware registers for memory-mapped I/O blocks.
These helpers ensure type safety, and deduce automatically shift values
from mask values, avoiding mistakes due to inconsistent shifts and
masks, and leading to a reduction in source code size.

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant (e.g. it
comes from a table, or is created by shifting a compile-time constant).
To avoid this limitation, the AT91 clock driver introduced its own
field_{prep,get}() macros.  During the past four years, these have been
copied to multiple drivers, and more copies are on their way[1], leading
to the obvious review comment "please move this to <linux/bitfield.h>".

Hence this series makes field_{prep,get}() available for general use
(first two patches), and converts a few Renesas drivers to the existing
FIELD_{GET,PREP}() and the new field_{get,prep}() helpers (last two
patches).

Alternatives would be to use the typed {u*,be*,le*,...}_{get,encode}_bits()
macros instead (which currently do not work with non-constant masks
either, and the first attempt to change that generates much worse code),
or to store the low bit and width of the mask instead (which would
require changing all code that passes masks directly, and also generates
worse code).

Changes compared to v3[2]:
  - Update recently introduced FIELD_MODIFY() macro,
  - Add Acked-by,
  - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
    power management debugfs helper APIs") in v6.17-rc1,
  - Convert more recently introduced upstream copies:
      - drivers/edac/ie31200_edac.c
      - drivers/iio/dac/ad3530r.c

Changes compared to v2[3]:
  - New patch "[PATCH v3 1/4] bitfield: Drop underscores from macro
    parameters",
  - Add Acked-by,
  - Drop underscores from macro parameters,
  - Use __auto_type where possible,
  - Correctly cast reg to the mask type,
  - Introduces __val and __reg intermediates to simplify the actual
    operation,
  - Drop unneeded parentheses,
  - Clarify having both FIELD_{GET,PREP}() and field_{get,prep}(),

Changes compared to v1[4]:
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
  - Drop the last 14 RFC patches.
    They can be updated/resubmitted/applied later.

I plan to take all four patches through the Renesas tree, and provide an
immutable branch + tag with the first two patches, so subsystem
maintainers that want to queue patches that depend on this can easily do
so.  Once that tag has been merged in subsystem trees or upstream, I
plan to update and resend actual conversions (see patches 4-17 in
v1[4]).

Thanks for your comments!

[1] Work-in-progress new copies posted during the last few months (there
    may be more):
      - "[PATCH 10/24] mtd: rawnand: sunxi: cosmetic: move ECC_PAT_FOUND register in SoC caps"
	https://lore.kernel.org/20251016142752.2627710-11-richard.genoud@bootlin.com
      - "[PATCH 12/24] mtd: rawnand: sunxi: cosmetic: move NFC_ECC_MODE offset in SoC caps"
	https://lore.kernel.org/20251016142752.2627710-13-richard.genoud@bootlin.com
      - "[PATCH v2 05/15] mtd: rawnand: sunxi: rework pattern found registers"
	https://lore.kernel.org/20251013152645.1119308-6-richard.genoud@bootlin.com
      - "[PATCH v2 07/15] mtd: rawnand: sunxi: introduce ecc_mode_mask in sunxi_nfc_caps"
	https://lore.kernel.org/20251013152645.1119308-8-richard.genoud@bootlin.com
      - "[PATCH v5 2/2] iio: imu: smi330: Add driver"
	https://lore.kernel.org/20251009153149.5162-3-Jianping.Shen@de.bosch.com
      - "[PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip"
	https://lore.kernel.org/20250923144524.191892-3-biju.das.jz@bp.renesas.com
      - "[PATCH v2 3/3] gpio: gpio-ltc4283: Add support for the LTC4283 Swap Controller"
	https://lore.kernel.org/20250903-ltc4283-support-v2-3-6bce091510bf@analog.com
      - "[PATCH v7 15/24] media: i2c: add Maxim GMSL2/3 serializer and deserializer framework"
	https://lore.kernel.org/20250718152500.2656391-16-demonsingur@gmail.com
[2] "[PATCH v3 0/4] Non-const bitfield helpers"
    https://lore.kernel.org/all/cover.1739540679.git.geert+renesas@glider.be/
[3] "[PATCH v2 0/3] Non-const bitfield helpers"
    https://lore.kernel.org/all/cover.1738329458.git.geert+renesas@glider.be
[4] "[PATCH 00/17] Non-const bitfield helper conversions"
    https://lore.kernel.org/all/cover.1637592133.git.geert+renesas@glider.be

Geert Uytterhoeven (4):
  bitfield: Drop underscores from macro parameters
  bitfield: Add non-constant field_{prep,get}() helpers
  clk: renesas: Use bitfield helpers
  soc: renesas: Use bitfield helpers

 drivers/clk/at91/clk-peripheral.c             |   1 +
 drivers/clk/at91/pmc.h                        |   3 -
 drivers/clk/renesas/clk-div6.c                |   6 +-
 drivers/clk/renesas/rcar-gen3-cpg.c           |  15 +-
 drivers/clk/renesas/rcar-gen4-cpg.c           |   9 +-
 .../intel/qat/qat_common/adf_pm_dbgfs_utils.c |   8 +-
 drivers/edac/ie31200_edac.c                   |   4 +-
 drivers/gpio/gpio-aspeed.c                    |   5 +-
 drivers/iio/dac/ad3530r.c                     |   3 -
 drivers/iio/temperature/mlx90614.c            |   5 +-
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        |   4 -
 drivers/soc/renesas/renesas-soc.c             |   4 +-
 drivers/soc/renesas/rz-sysc.c                 |   3 +-
 include/linux/bitfield.h                      | 142 +++++++++++-------
 sound/usb/mixer_quirks.c                      |   4 -
 15 files changed, 108 insertions(+), 108 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

