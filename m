From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 23 May 2023 17:50:18 +0200
Subject: [PATCH v2 0/3] Fix pca954x i2c-mux node names
Message-ID: <cover.1684856632.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

	Hi all,

According to the I2C bus multiplexer/switch DT bindings, i2c-mux nodes
should be named "i2c-mux" (or something similar).
This patch series renames nodes for pca954x i2c-muxes that are flagged
by

    make dtbs_checK DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml

Changes compared to v1:
  - Add Reviewed-by,
  - Drop applied patches.

Please apply where appropriate.
Thanks!

Geert Uytterhoeven (3):
  ARM: dts: aspeed: Fix pca954x i2c-mux node names
  ARM: dts: nuvoton: Fix pca954x i2c-mux node names
  arm64: dts: marvell: Fix pca954x i2c-mux node names

 .../boot/dts/aspeed-bmc-bytedance-g220a.dts   | 18 ++++----
 .../dts/aspeed-bmc-facebook-cloudripper.dts   | 10 ++--
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 46 +++++++++----------
 .../boot/dts/aspeed-bmc-facebook-elbert.dts   |  4 +-
 .../arm/boot/dts/aspeed-bmc-facebook-fuji.dts | 30 ++++++------
 .../boot/dts/aspeed-bmc-facebook-minipack.dts | 32 ++++++-------
 .../dts/aspeed-bmc-facebook-tiogapass.dts     |  8 ++--
 .../boot/dts/aspeed-bmc-facebook-wedge100.dts |  2 +-
 .../boot/dts/aspeed-bmc-facebook-wedge400.dts |  6 +--
 .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts |  2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  | 18 ++++----
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  |  8 ++--
 .../boot/dts/aspeed-bmc-inspur-fp5280g2.dts   |  4 +-
 .../boot/dts/aspeed-bmc-inspur-nf5280m6.dts   | 12 ++---
 .../dts/aspeed-bmc-inventec-transformers.dts  |  6 +--
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts |  4 +-
 .../boot/dts/aspeed-bmc-lenovo-hr855xg2.dts   |  4 +-
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |  4 +-
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts  |  6 +--
 arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts   | 10 ++--
 arch/arm/boot/dts/aspeed-bmc-vegman-n110.dts  | 14 +++---
 arch/arm/boot/dts/aspeed-bmc-vegman-rx20.dts  | 10 ++--
 arch/arm/boot/dts/aspeed-bmc-vegman-sx20.dts  | 14 +++---
 arch/arm/boot/dts/nuvoton-npcm730-gbs.dts     | 16 +++----
 arch/arm/boot/dts/nuvoton-npcm730-gsj.dts     |  2 +-
 arch/arm/boot/dts/nuvoton-npcm730-kudo.dts    |  8 ++--
 .../dts/nuvoton-npcm750-runbmc-olympus.dts    |  4 +-
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   |  2 +-
 .../dts/marvell/armada-8040-puzzle-m801.dts   |  2 +-
 29 files changed, 153 insertions(+), 153 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
