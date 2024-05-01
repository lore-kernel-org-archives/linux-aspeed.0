From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
Date: Wed, 01 May 2024 12:48:49 -0000
Subject: [PATCH 00/21] pinctrl: Use scope based of_node_put() cleanups
Message-ID: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use scope based of_node_put() to simplify code. It reduces the chance
of forgetting of_node_put(), and also simplifies error handling path.
I not able to test the changes on all the hardwares, so driver owners,
please help review when you have time.

This patchset was inspired from Dan's comments on pinctrl-scmi-imx.c,
thanks.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (21):
      pinctrl: ti: iodelay: Use scope based of_node_put() cleanups
      pinctrl: tegra: Use scope based of_node_put() cleanups
      pinctrl: sunplus: Use scope based of_node_put() cleanups
      pinctrl: stm32: Use scope based of_node_put() cleanups
      pinctrl: starfive: Use scope based of_node_put() cleanups
      pinctrl: sprd: Use scope based of_node_put() cleanups
      pinctrl: spear: Use scope based of_node_put() cleanups
      pinctrl: samsung: Use scope based of_node_put() cleanups
      pinctrl: renesas: Use scope based of_node_put() cleanups
      pinctrl: st: Use scope based of_node_put() cleanups
      pinctrl: rockchip: Use scope based of_node_put() cleanups
      pinctrl: k210: Use scope based of_node_put() cleanups
      pinctrl: equilibrium: Use scope based of_node_put() cleanups
      pinctrl: at91: Use scope based of_node_put() cleanups
      pinctrl: s32cc: Use scope based of_node_put() cleanups
      pinctrl: nomadik: Use scope based of_node_put() cleanups
      pinctrl: mediatek: Use scope based of_node_put() cleanups
      pinctrl: freescale: Use scope based of_node_put() cleanups
      pinctrl: bcm: bcm63xx: Use scope based of_node_put() cleanups
      pinctrl: aspeed: g5: Use scope based of_node_put() cleanups
      pinctrl: pinconf-generic: Use scope based of_node_put() cleanups

 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         |  6 ++--
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c              |  4 +--
 drivers/pinctrl/freescale/pinctrl-imx.c            | 31 +++++------------
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      | 19 ++++------
 drivers/pinctrl/freescale/pinctrl-mxs.c            | 24 +++++--------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  4 +--
 drivers/pinctrl/mediatek/pinctrl-paris.c           |  4 +--
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |  4 +--
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |  4 +--
 drivers/pinctrl/nxp/pinctrl-s32cc.c                | 31 ++++++-----------
 drivers/pinctrl/pinconf-generic.c                  |  7 ++--
 drivers/pinctrl/pinctrl-at91-pio4.c                |  7 ++--
 drivers/pinctrl/pinctrl-at91.c                     | 17 +++------
 drivers/pinctrl/pinctrl-equilibrium.c              | 21 +++---------
 drivers/pinctrl/pinctrl-k210.c                     |  7 ++--
 drivers/pinctrl/pinctrl-rockchip.c                 | 14 +++-----
 drivers/pinctrl/pinctrl-st.c                       | 40 +++++++---------------
 drivers/pinctrl/renesas/pinctrl-rza1.c             | 14 +++-----
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            | 10 ++----
 drivers/pinctrl/renesas/pinctrl-rzn1.c             | 23 ++++---------
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |  7 ++--
 drivers/pinctrl/renesas/pinctrl.c                  |  7 ++--
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       |  3 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 16 +++------
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |  8 ++---
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 26 ++++----------
 drivers/pinctrl/spear/pinctrl-spear.c              | 13 +++----
 drivers/pinctrl/sprd/pinctrl-sprd.c                | 14 +++-----
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c | 27 ++++++---------
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 18 +++++-----
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  7 ++--
 drivers/pinctrl/sunplus/sppctl.c                   |  4 +--
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         |  7 ++--
 drivers/pinctrl/tegra/pinctrl-tegra.c              | 10 ++----
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            | 37 ++++++++------------
 35 files changed, 154 insertions(+), 341 deletions(-)
---
base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
change-id: 20240429-pinctrl-cleanup-e4d461c32648

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

