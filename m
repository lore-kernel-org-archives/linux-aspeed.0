From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  2 Dec 2022 17:49:15 +0100
Subject: [PATCH 00/11] Fix pca954x i2c-mux node names
Message-ID: <cover.1669999298.git.geert+renesas@glider.be>
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

Please apply where appropriate.
Thanks!

Geert Uytterhoeven (11):
  ARM: dts: ti: Fix pca954x i2c-mux node names
  ARM: dts: aspeed: Fix pca954x i2c-mux node names
  ARM: dts: imx: Fix pca9547 i2c-mux node name
  ARM: dts: nuvoton: Fix pca954x i2c-mux node names
  ARM: dts: socfpga: Fix pca9548 i2c-mux node name
  ARM: dts: vf610: Fix pca9548 i2c-mux node names
  arm64: dts: freescale: Fix pca954x i2c-mux node names
  arm64: dts: marvell: Fix pca954x i2c-mux node names
  arm64: dts: renesas: ulcb-kf: Fix pca9548 i2c-mux node names
  MIPS: mscc: jaguar2: Fix pca9545 i2c-mux node names
  powerpc: dts: fsl: Fix pca954x i2c-mux node names

 arch/arm/boot/dts/am3874-iceboard.dts         |  4 +-
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
 arch/arm/boot/dts/imx53-ppd.dts               |  2 +-
 arch/arm/boot/dts/nuvoton-npcm730-gbs.dts     | 16 +++----
 arch/arm/boot/dts/nuvoton-npcm730-gsj.dts     |  2 +-
 arch/arm/boot/dts/nuvoton-npcm730-kudo.dts    |  8 ++--
 .../dts/nuvoton-npcm750-runbmc-olympus.dts    |  4 +-
 .../boot/dts/socfpga_cyclone5_vining_fpga.dts |  2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts     |  2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts     |  2 +-
 .../boot/dts/freescale/fsl-ls1012a-qds.dts    |  2 +-
 .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  2 +-
 .../boot/dts/freescale/fsl-ls1046a-qds.dts    |  2 +-
 .../boot/dts/freescale/fsl-ls1088a-qds.dts    |  2 +-
 .../boot/dts/freescale/fsl-ls1088a-rdb.dts    |  2 +-
 .../boot/dts/freescale/fsl-ls1088a-ten64.dts  |  2 +-
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi   |  2 +-
 .../boot/dts/freescale/fsl-ls208xa-rdb.dtsi   |  2 +-
 .../boot/dts/freescale/fsl-lx2160a-cex7.dtsi  |  2 +-
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts |  2 +-
 .../boot/dts/freescale/imx8mq-nitrogen.dts    |  4 +-
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  2 +-
 .../boot/dts/marvell/armada-8040-mcbin.dtsi   |  2 +-
 .../dts/marvell/armada-8040-puzzle-m801.dts   |  2 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi      |  4 +-
 arch/mips/boot/dts/mscc/jaguar2_pcb110.dts    |  4 +-
 arch/powerpc/boot/dts/fsl/t1024qds.dts        |  2 +-
 arch/powerpc/boot/dts/fsl/t1024rdb.dts        |  2 +-
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi       |  2 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi       |  2 +-
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi       |  2 +-
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi       |  2 +-
 54 files changed, 182 insertions(+), 182 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
