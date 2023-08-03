From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:40 -0600
Subject: [PATCH v2 00/23] ARM: DT include cleanups
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Arnd, This is all the remaining ARM and SoC related patches of DT 
include cleanups which have not be applied by sub-arch maintainers.

A few of these are v2, but most are just resends of v1.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (23):
      ARM: l2x0: Add explicit includes for init and types
      ARM: sti: Drop unused includes
      ARM: alpine: Drop unused includes
      ARM: berlin: Drop unused includes
      ARM: dove: Drop unused includes
      ARM: hpe: Drop unused includes
      ARM: mmp: Drop unused includes
      ARM: nomadik: Drop unused includes
      ARM: npcm: Drop unused includes
      ARM: nspire: Drop unused includes
      ARM: pxa: Drop unused includes
      ARM: rockchip: Drop unused includes
      ARM: versatile: Drop unused includes
      ARM: mvebu: Explicitly include correct DT includes
      ARM: spear: Explicitly include correct DT includes
      bus: Explicitly include correct DT includes
      firmware: Explicitly include correct DT includes
      soc: aspeed: Explicitly include correct DT includes
      soc: mediatek: Explicitly include correct DT includes
      soc: rockchip: Explicitly include correct DT includes
      soc: sunxi: Explicitly include correct DT includes
      soc: xilinx: Explicitly include correct DT includes
      soc: fsl: Explicitly include correct DT includes

 arch/arm/include/asm/hardware/cache-l2x0.h |  2 ++
 arch/arm/mach-alpine/alpine_machine.c      |  2 --
 arch/arm/mach-berlin/berlin.c              |  5 -----
 arch/arm/mach-dove/common.c                |  2 --
 arch/arm/mach-hpe/gxp.c                    |  1 -
 arch/arm/mach-mmp/mmp-dt.c                 |  3 ---
 arch/arm/mach-mmp/mmp2-dt.c                |  4 ----
 arch/arm/mach-mmp/mmp3.c                   |  4 ----
 arch/arm/mach-mvebu/kirkwood.c             |  1 +
 arch/arm/mach-mvebu/pmsu.c                 |  2 +-
 arch/arm/mach-nomadik/cpu-8815.c           | 13 -------------
 arch/arm/mach-npcm/platsmp.c               |  3 ---
 arch/arm/mach-nspire/nspire.c              |  9 +--------
 arch/arm/mach-pxa/pxa-dt.c                 |  6 ------
 arch/arm/mach-rockchip/rockchip.c          |  6 +-----
 arch/arm/mach-spear/spear1340.c            |  2 +-
 arch/arm/mach-sti/board-dt.c               |  2 --
 arch/arm/mach-versatile/realview.c         |  2 --
 drivers/bus/fsl-mc/fsl-mc-bus.c            |  1 +
 drivers/bus/fsl-mc/fsl-mc-msi.c            |  2 --
 drivers/bus/hisi_lpc.c                     |  2 +-
 drivers/bus/omap_l3_smx.c                  |  1 -
 drivers/bus/simple-pm-bus.c                |  2 ++
 drivers/bus/sunxi-rsb.c                    |  2 +-
 drivers/bus/ti-pwmss.c                     |  2 +-
 drivers/firmware/arm_scmi/driver.c         |  4 ++--
 drivers/firmware/imx/imx-dsp.c             |  1 -
 drivers/firmware/imx/imx-scu-irq.c         |  1 +
 drivers/firmware/imx/imx-scu.c             |  1 +
 drivers/firmware/mtk-adsp-ipc.c            |  1 -
 drivers/firmware/raspberrypi.c             |  1 +
 drivers/firmware/scpi_pm_domain.c          |  3 ++-
 drivers/firmware/stratix10-rsu.c           |  1 -
 drivers/firmware/tegra/bpmp.c              |  3 +--
 drivers/firmware/xilinx/zynqmp.c           |  1 +
 drivers/soc/aspeed/aspeed-lpc-snoop.c      |  1 -
 drivers/soc/aspeed/aspeed-p2a-ctrl.c       |  2 +-
 drivers/soc/aspeed/aspeed-uart-routing.c   |  3 +--
 drivers/soc/fsl/dpaa2-console.c            |  3 ++-
 drivers/soc/fsl/qe/qe.c                    |  3 ++-
 drivers/soc/fsl/qe/qe_common.c             |  1 -
 drivers/soc/fsl/qe/qe_tdm.c                |  4 +---
 drivers/soc/mediatek/mtk-cmdq-helper.c     |  1 +
 drivers/soc/mediatek/mtk-devapc.c          |  2 +-
 drivers/soc/mediatek/mtk-mmsys.c           |  2 +-
 drivers/soc/mediatek/mtk-mutex.c           |  3 +--
 drivers/soc/mediatek/mtk-pmic-wrap.c       |  3 ++-
 drivers/soc/rockchip/grf.c                 |  2 +-
 drivers/soc/sunxi/sunxi_sram.c             |  2 +-
 drivers/soc/xilinx/zynqmp_power.c          |  1 +
 50 files changed, 38 insertions(+), 93 deletions(-)
---
base-commit: fb4327106e5250ee360d0d8b056c1eef7eeb9a98
change-id: 20230803-dt-header-cleanups-for-soc-cf95dbe606bd

Best regards,
-- 
Rob Herring <robh@kernel.org>

