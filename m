From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon,  8 May 2023 22:51:37 +0200
Subject: [PATCH 00/89] i2c: Convert to platform remove callback returning void
Message-ID: <20230508205306.1474415-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series convers the drivers below drivers/i2c to the .remove_new()
callback of struct platform_driver(). The motivation is to make the
remove callback less prone for errors and wrong assumptions. See commit
5c5a7680e67b ("platform: Provide a remove callback that returns no
value") for a more detailed rationale.

All but one driver already returned zero unconditionally in their
.remove() callback, so converting them to .remove_new() is trivial.
i2c-davinci has two patches in this series, first the error path is
improved to not return an error code, then it's converted as the others
drivers are.

The two davinci patches are also the only interdependency in this
series. I was unsure if I should split the series in two, the busses and
the mux changes; if convenient these can be applied independent of each
other.

Best regards
Uwe

Uwe Kleine-K?nig (89):
  i2c: altera: Convert to platform remove callback returning void
  i2c: amd-mp2-plat: Convert to platform remove callback returning void
  i2c: aspeed: Convert to platform remove callback returning void
  i2c: at91-core: Convert to platform remove callback returning void
  i2c: au1550: Convert to platform remove callback returning void
  i2c: axxia: Convert to platform remove callback returning void
  i2c: bcm-iproc: Convert to platform remove callback returning void
  i2c: bcm-kona: Convert to platform remove callback returning void
  i2c: bcm2835: Convert to platform remove callback returning void
  i2c: brcmstb: Convert to platform remove callback returning void
  i2c: cadence: Convert to platform remove callback returning void
  i2c: cbus-gpio: Convert to platform remove callback returning void
  i2c: cht-wc: Convert to platform remove callback returning void
  i2c: cpm: Convert to platform remove callback returning void
  i2c: cros-ec-tunnel: Convert to platform remove callback returning
    void
  i2c: davinci: Improve error reporting for problems during .remove()
  i2c: davinci: Convert to platform remove callback returning void
  i2c: designware-platdrv: Convert to platform remove callback returning
    void
  i2c: digicolor: Convert to platform remove callback returning void
  i2c: dln2: Convert to platform remove callback returning void
  i2c: emev2: Convert to platform remove callback returning void
  i2c: exynos5: Convert to platform remove callback returning void
  i2c: gpio: Convert to platform remove callback returning void
  i2c: gxp: Convert to platform remove callback returning void
  i2c: highlander: Convert to platform remove callback returning void
  i2c: hix5hd2: Convert to platform remove callback returning void
  i2c: ibm_iic: Convert to platform remove callback returning void
  i2c: img-scb: Convert to platform remove callback returning void
  i2c: imx-lpi2c: Convert to platform remove callback returning void
  i2c: imx: Convert to platform remove callback returning void
  i2c: iop3xx: Convert to platform remove callback returning void
  i2c: isch: Convert to platform remove callback returning void
  i2c: jz4780: Convert to platform remove callback returning void
  i2c: kempld: Convert to platform remove callback returning void
  i2c: lpc2k: Convert to platform remove callback returning void
  i2c: meson: Convert to platform remove callback returning void
  i2c: microchip-corei2c: Convert to platform remove callback returning
    void
  i2c: mlxbf: Convert to platform remove callback returning void
  i2c: mlxcpld: Convert to platform remove callback returning void
  i2c: mpc: Convert to platform remove callback returning void
  i2c: mt65xx: Convert to platform remove callback returning void
  i2c: mt7621: Convert to platform remove callback returning void
  i2c: mv64xxx: Convert to platform remove callback returning void
  i2c: mxs: Convert to platform remove callback returning void
  i2c: npcm7xx: Convert to platform remove callback returning void
  i2c: ocores: Convert to platform remove callback returning void
  i2c: octeon-platdrv: Convert to platform remove callback returning
    void
  i2c: omap: Convert to platform remove callback returning void
  i2c: opal: Convert to platform remove callback returning void
  i2c: pasemi-platform: Convert to platform remove callback returning
    void
  i2c: pca-platform: Convert to platform remove callback returning void
  i2c: pnx: Convert to platform remove callback returning void
  i2c: powermac: Convert to platform remove callback returning void
  i2c: pxa: Convert to platform remove callback returning void
  i2c: qcom-cci: Convert to platform remove callback returning void
  i2c: qcom-geni: Convert to platform remove callback returning void
  i2c: qup: Convert to platform remove callback returning void
  i2c: rcar: Convert to platform remove callback returning void
  i2c: riic: Convert to platform remove callback returning void
  i2c: rk3x: Convert to platform remove callback returning void
  i2c: rzv2m: Convert to platform remove callback returning void
  i2c: s3c2410: Convert to platform remove callback returning void
  i2c: scmi: Convert to platform remove callback returning void
  i2c: scx200_acb: Convert to platform remove callback returning void
  i2c: sh7760: Convert to platform remove callback returning void
  i2c: sh_mobile: Convert to platform remove callback returning void
  i2c: simtec: Convert to platform remove callback returning void
  i2c: st: Convert to platform remove callback returning void
  i2c: stm32f4: Convert to platform remove callback returning void
  i2c: stm32f7: Convert to platform remove callback returning void
  i2c: sun6i-p2wi: Convert to platform remove callback returning void
  i2c: synquacer: Convert to platform remove callback returning void
  i2c: tegra-bpmp: Convert to platform remove callback returning void
  i2c: tegra: Convert to platform remove callback returning void
  i2c: uniphier-f: Convert to platform remove callback returning void
  i2c: uniphier: Convert to platform remove callback returning void
  i2c: versatile: Convert to platform remove callback returning void
  i2c: viperboard: Convert to platform remove callback returning void
  i2c: wmt: Convert to platform remove callback returning void
  i2c: xgene-slimpro: Convert to platform remove callback returning void
  i2c: xiic: Convert to platform remove callback returning void
  i2c: xlp9xx: Convert to platform remove callback returning void
  i2c: mux: arb-gpio-challenge: Convert to platform remove callback
    returning void
  i2c: mux: demux-pinctrl: Convert to platform remove callback returning
    void
  i2c: mux: gpio: Convert to platform remove callback returning void
  i2c: mux: gpmux: Convert to platform remove callback returning void
  i2c: mux: mlxcpld: Convert to platform remove callback returning void
  i2c: mux: pinctrl: Convert to platform remove callback returning void
  i2c: mux: reg: Convert to platform remove callback returning void

 drivers/i2c/busses/i2c-altera.c             |  6 ++----
 drivers/i2c/busses/i2c-amd-mp2-plat.c       |  5 ++---
 drivers/i2c/busses/i2c-aspeed.c             |  6 ++----
 drivers/i2c/busses/i2c-at91-core.c          |  6 ++----
 drivers/i2c/busses/i2c-au1550.c             |  5 ++---
 drivers/i2c/busses/i2c-axxia.c              |  6 ++----
 drivers/i2c/busses/i2c-bcm-iproc.c          |  6 ++----
 drivers/i2c/busses/i2c-bcm-kona.c           |  6 ++----
 drivers/i2c/busses/i2c-bcm2835.c            |  6 ++----
 drivers/i2c/busses/i2c-brcmstb.c            |  5 ++---
 drivers/i2c/busses/i2c-cadence.c            |  6 ++----
 drivers/i2c/busses/i2c-cbus-gpio.c          |  6 ++----
 drivers/i2c/busses/i2c-cht-wc.c             |  6 ++----
 drivers/i2c/busses/i2c-cpm.c                |  6 ++----
 drivers/i2c/busses/i2c-cros-ec-tunnel.c     |  6 ++----
 drivers/i2c/busses/i2c-davinci.c            | 14 ++++++--------
 drivers/i2c/busses/i2c-designware-platdrv.c |  6 ++----
 drivers/i2c/busses/i2c-digicolor.c          |  6 ++----
 drivers/i2c/busses/i2c-dln2.c               |  6 ++----
 drivers/i2c/busses/i2c-emev2.c              |  6 ++----
 drivers/i2c/busses/i2c-exynos5.c            |  6 ++----
 drivers/i2c/busses/i2c-gpio.c               |  6 ++----
 drivers/i2c/busses/i2c-gxp.c                |  6 ++----
 drivers/i2c/busses/i2c-highlander.c         |  6 ++----
 drivers/i2c/busses/i2c-hix5hd2.c            |  6 ++----
 drivers/i2c/busses/i2c-ibm_iic.c            |  6 ++----
 drivers/i2c/busses/i2c-img-scb.c            |  6 ++----
 drivers/i2c/busses/i2c-imx-lpi2c.c          |  6 ++----
 drivers/i2c/busses/i2c-imx.c                |  6 ++----
 drivers/i2c/busses/i2c-iop3xx.c             |  6 ++----
 drivers/i2c/busses/i2c-isch.c               |  6 ++----
 drivers/i2c/busses/i2c-jz4780.c             |  5 ++---
 drivers/i2c/busses/i2c-kempld.c             |  6 ++----
 drivers/i2c/busses/i2c-lpc2k.c              |  6 ++----
 drivers/i2c/busses/i2c-meson.c              |  6 ++----
 drivers/i2c/busses/i2c-microchip-corei2c.c  |  6 ++----
 drivers/i2c/busses/i2c-mlxbf.c              |  6 ++----
 drivers/i2c/busses/i2c-mlxcpld.c            |  6 ++----
 drivers/i2c/busses/i2c-mpc.c                |  6 ++----
 drivers/i2c/busses/i2c-mt65xx.c             |  6 ++----
 drivers/i2c/busses/i2c-mt7621.c             |  6 ++----
 drivers/i2c/busses/i2c-mv64xxx.c            |  6 ++----
 drivers/i2c/busses/i2c-mxs.c                |  6 ++----
 drivers/i2c/busses/i2c-npcm7xx.c            |  5 ++---
 drivers/i2c/busses/i2c-ocores.c             |  6 ++----
 drivers/i2c/busses/i2c-octeon-platdrv.c     |  5 ++---
 drivers/i2c/busses/i2c-omap.c               |  6 ++----
 drivers/i2c/busses/i2c-opal.c               |  6 ++----
 drivers/i2c/busses/i2c-pasemi-platform.c    |  5 ++---
 drivers/i2c/busses/i2c-pca-platform.c       |  6 ++----
 drivers/i2c/busses/i2c-pnx.c                |  6 ++----
 drivers/i2c/busses/i2c-powermac.c           |  6 ++----
 drivers/i2c/busses/i2c-pxa.c                |  6 ++----
 drivers/i2c/busses/i2c-qcom-cci.c           |  6 ++----
 drivers/i2c/busses/i2c-qcom-geni.c          |  5 ++---
 drivers/i2c/busses/i2c-qup.c                |  5 ++---
 drivers/i2c/busses/i2c-rcar.c               |  6 ++----
 drivers/i2c/busses/i2c-riic.c               |  6 ++----
 drivers/i2c/busses/i2c-rk3x.c               |  6 ++----
 drivers/i2c/busses/i2c-rzv2m.c              |  6 ++----
 drivers/i2c/busses/i2c-s3c2410.c            |  6 ++----
 drivers/i2c/busses/i2c-scmi.c               |  6 ++----
 drivers/i2c/busses/i2c-sh7760.c             |  6 ++----
 drivers/i2c/busses/i2c-sh_mobile.c          |  5 ++---
 drivers/i2c/busses/i2c-simtec.c             |  6 ++----
 drivers/i2c/busses/i2c-st.c                 |  6 ++----
 drivers/i2c/busses/i2c-stm32f4.c            |  6 ++----
 drivers/i2c/busses/i2c-stm32f7.c            |  6 ++----
 drivers/i2c/busses/i2c-sun6i-p2wi.c         |  6 ++----
 drivers/i2c/busses/i2c-synquacer.c          |  6 ++----
 drivers/i2c/busses/i2c-tegra-bpmp.c         |  6 ++----
 drivers/i2c/busses/i2c-tegra.c              |  6 ++----
 drivers/i2c/busses/i2c-uniphier-f.c         |  6 ++----
 drivers/i2c/busses/i2c-uniphier.c           |  6 ++----
 drivers/i2c/busses/i2c-versatile.c          |  5 ++---
 drivers/i2c/busses/i2c-viperboard.c         |  6 ++----
 drivers/i2c/busses/i2c-wmt.c                |  6 ++----
 drivers/i2c/busses/i2c-xgene-slimpro.c      |  6 ++----
 drivers/i2c/busses/i2c-xiic.c               |  6 ++----
 drivers/i2c/busses/i2c-xlp9xx.c             |  6 ++----
 drivers/i2c/busses/scx200_acb.c             |  6 ++----
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c  |  5 ++---
 drivers/i2c/muxes/i2c-demux-pinctrl.c       |  6 ++----
 drivers/i2c/muxes/i2c-mux-gpio.c            |  6 ++----
 drivers/i2c/muxes/i2c-mux-gpmux.c           |  6 ++----
 drivers/i2c/muxes/i2c-mux-mlxcpld.c         |  5 ++---
 drivers/i2c/muxes/i2c-mux-pinctrl.c         |  6 ++----
 drivers/i2c/muxes/i2c-mux-reg.c             |  6 ++----
 88 files changed, 180 insertions(+), 343 deletions(-)

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

