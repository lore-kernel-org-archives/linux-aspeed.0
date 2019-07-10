From: Joe Perches <joe@perches.com>
Date: Tue,  9 Jul 2019 22:04:13 -0700
Subject: [PATCH 00/12] treewide: Fix GENMASK misuses
Message-ID: <cover.1562734889.git.joe@perches.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These GENMASK uses are inverted argument order and the
actual masks produced are incorrect.  Fix them.

Add checkpatch tests to help avoid more misuses too.

Joe Perches (12):
  checkpatch: Add GENMASK tests
  clocksource/drivers/npcm: Fix misuse of GENMASK macro
  drm: aspeed_gfx: Fix misuse of GENMASK macro
  iio: adc: max9611: Fix misuse of GENMASK macro
  irqchip/gic-v3-its: Fix misuse of GENMASK macro
  mmc: meson-mx-sdio: Fix misuse of GENMASK macro
  net: ethernet: mediatek: Fix misuses of GENMASK macro
  net: stmmac: Fix misuses of GENMASK macro
  rtw88: Fix misuse of GENMASK macro
  phy: amlogic: G12A: Fix misuse of GENMASK macro
  staging: media: cedrus: Fix misuse of GENMASK macro
  ASoC: wcd9335: Fix misuse of GENMASK macro

 drivers/clocksource/timer-npcm7xx.c               |  2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx.h               |  2 +-
 drivers/iio/adc/max9611.c                         |  2 +-
 drivers/irqchip/irq-gic-v3-its.c                  |  2 +-
 drivers/mmc/host/meson-mx-sdio.c                  |  2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.h       |  2 +-
 drivers/net/ethernet/mediatek/mtk_sgmii.c         |  2 +-
 drivers/net/ethernet/stmicro/stmmac/descs.h       |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8822b.c     |  2 +-
 drivers/phy/amlogic/phy-meson-g12a-usb2.c         |  2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_regs.h  |  2 +-
 scripts/checkpatch.pl                             | 15 +++++++++++++++
 sound/soc/codecs/wcd-clsh-v2.c                    |  2 +-
 14 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.15.0

