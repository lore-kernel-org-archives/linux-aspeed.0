From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Oct 2022 23:14:16 +0300
Subject: [rft, PATCH v2 00/36] pinctrl: Clean up and add missed headers
Message-ID: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Currently the header inclusion inside the pinctrl headers seems more arbitrary
than logical. This series is basically out of two parts:
- add missed headers to the pin control drivers / users
- clean up the headers of pin control subsystem

The idea is to have this series to be pulled after -rc1 by the GPIO and
pin control subsystems, so all new drivers will utilize cleaned up headers
of the pin control.

Please, review and comment.

Changelog v2:
- added preparatory patches: all, but last (LKP)
- added missed forward declaration to the last patch (LKP)

Andy Shevchenko (36):
  gpiolib: tegra186: Add missed header(s)
  gpiolib: cdev: Add missed header(s)
  media: c8sectpfe: Add missed header(s)
  pinctrl: actions: Add missed header(s)
  pinctrl: aspeed: Add missed header(s)
  pinctrl: at91: Add missed header(s)
  pinctrl: axp209: Add missed header(s)
  pinctrl: bcm: Add missed header(s)
  pinctrl: cygnus-mux: Add missed header(s)
  pinctrl: imx: Add missed header(s)
  pinctrl: ingenic: Add missed header(s)
  pinctrl: k210: Add missed header(s)
  pinctrl: lochnagar: Add missed header(s)
  pinctrl: mediatek: Add missed header(s)
  pinctrl: mvebu: Add missed header(s)
  pinctrl: npcm7xx: Add missed header(s)
  pinctrl: ocelot: Add missed header(s)
  pinctrl: qcom: Add missed header(s)
  pinctrl: renesas: Add missed header(s)
  pinctrl: samsung: Add missed header(s)
  pinctrl: single: Add missed header(s)
  pinctrl: spear: Add missed header(s)
  pinctrl: sprd: Add missed header(s)
  pinctrl: st: Add missed header(s)
  pinctrl: starfive: Add missed header(s)
  pinctrl: stm32: Add missed header(s)
  pinctrl: stmfx: Add missed header(s)
  pinctrl: tegra: Add missed header(s)
  pinctrl: ti-iodelay: Add missed header(s)
  pinctrl: uniphier: Add missed header(s)
  pinctrl: zynqmp: Add missed header(s)
  pinctrl: cherryview: Add missed header(s)
  pinctrl: lynxpoint: Add missed header(s)
  pinctrl: merrifield: Add missed header(s)
  pinctrl: intel: Add missed header(s)
  pinctrl: Clean up headers

 drivers/gpio/gpio-tegra186.c                  |  3 +-
 drivers/gpio/gpiolib-cdev.c                   |  6 ++--
 .../st/sti/c8sectpfe/c8sectpfe-core.c         |  8 +++--
 drivers/pinctrl/actions/pinctrl-owl.c         | 10 +++---
 drivers/pinctrl/aspeed/pinctrl-aspeed.c       |  1 +
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c        | 13 +++++---
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c      |  9 ++++--
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c      | 12 ++++---
 drivers/pinctrl/bcm/pinctrl-ns2-mux.c         |  8 +++--
 drivers/pinctrl/bcm/pinctrl-nsp-mux.c         |  8 +++--
 drivers/pinctrl/cirrus/pinctrl-lochnagar.c    |  6 ++--
 drivers/pinctrl/core.c                        | 19 ++++++------
 drivers/pinctrl/core.h                        | 12 ++++++-
 drivers/pinctrl/devicetree.h                  |  6 ++++
 drivers/pinctrl/freescale/pinctrl-imx.c       |  8 +++--
 drivers/pinctrl/intel/pinctrl-cherryview.c    |  6 ++--
 drivers/pinctrl/intel/pinctrl-intel.c         |  6 ++--
 drivers/pinctrl/intel/pinctrl-lynxpoint.c     |  6 ++--
 drivers/pinctrl/intel/pinctrl-merrifield.c    |  4 ++-
 drivers/pinctrl/mediatek/pinctrl-moore.c      |  3 ++
 drivers/pinctrl/mediatek/pinctrl-paris.c      |  5 +++
 drivers/pinctrl/mvebu/pinctrl-mvebu.c         | 14 +++++----
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c     | 11 ++++---
 drivers/pinctrl/pinconf.h                     | 10 ++++++
 drivers/pinctrl/pinctrl-at91-pio4.c           | 10 ++++--
 drivers/pinctrl/pinctrl-at91.c                | 16 +++++-----
 drivers/pinctrl/pinctrl-axp209.c              |  8 +++--
 drivers/pinctrl/pinctrl-ingenic.c             | 10 +++---
 drivers/pinctrl/pinctrl-k210.c                | 12 ++++---
 drivers/pinctrl/pinctrl-ocelot.c              | 10 +++---
 drivers/pinctrl/pinctrl-single.c              |  5 ++-
 drivers/pinctrl/pinctrl-st.c                  | 21 ++++++++-----
 drivers/pinctrl/pinctrl-stmfx.c               |  2 ++
 drivers/pinctrl/pinctrl-utils.h               |  5 +++
 drivers/pinctrl/pinctrl-zynqmp.c              |  4 ++-
 drivers/pinctrl/pinmux.c                      | 17 +++++-----
 drivers/pinctrl/pinmux.h                      | 11 +++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      |  8 +++--
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c       |  8 +++--
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  7 +++--
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |  4 ++-
 drivers/pinctrl/renesas/pinctrl.c             |  8 +++--
 drivers/pinctrl/samsung/pinctrl-samsung.c     | 11 ++++---
 drivers/pinctrl/spear/pinctrl-spear.c         |  6 ++--
 drivers/pinctrl/sprd/pinctrl-sprd.c           |  6 ++--
 .../starfive/pinctrl-starfive-jh7100.c        |  2 ++
 drivers/pinctrl/stm32/pinctrl-stm32.c         | 16 +++++-----
 drivers/pinctrl/tegra/pinctrl-tegra.c         |  6 ++--
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c       |  8 +++--
 .../pinctrl/uniphier/pinctrl-uniphier-core.c  |  8 +++--
 include/linux/pinctrl/consumer.h              | 31 +++++++++----------
 include/linux/pinctrl/devinfo.h               |  6 ++--
 include/linux/pinctrl/machine.h               |  8 +++--
 include/linux/pinctrl/pinconf-generic.h       | 23 ++++++++------
 include/linux/pinctrl/pinctrl.h               | 18 +++++------
 include/linux/pinctrl/pinmux.h                |  5 ++-
 56 files changed, 328 insertions(+), 186 deletions(-)


base-commit: 9d157c89c5569f0ef560b7a5b2d7bf59ae98499c
-- 
2.35.1

