From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 25 Sep 2023 11:54:51 +0200
Subject: [PATCH 00/40] soc: Convert to platform remove callback returning void
Message-ID: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series converts all platform drivers below drivers/soc to use
.remove_new(). The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

As there is no single maintainer team for drivers/soc, I suggest the
individual maintainers to pick up "their" patches. There are no
interdependencies between the patches, so that should work fine. As
there are still quite a few drivers to convert in other areas than
drivers/soc, I'm happy about every patch that makes it in and there is
no need for further coordination.  So even if there is a merge conflict
with one patch until you apply or a subject prefix is suboptimal, please
don't let you stop by negative feedback for other patches (unless it
applies to "your" patches, too, of course).

Best regards and thanks for considering,
Uwe

Uwe Kleine-K?nig (40):
  soc/aspeed: aspeed-lpc-ctrl: Convert to platform remove callback
    returning void
  soc/aspeed: aspeed-lpc-snoop: Convert to platform remove callback
    returning void
  soc/aspeed: aspeed-p2a-ctrl: Convert to platform remove callback
    returning void
  soc/aspeed: aspeed-uart-routing: Convert to platform remove callback
    returning void
  soc/fsl: dpaa2-console: Convert to platform remove callback returning
    void
  soc/fsl: cpm: qmc: Convert to platform remove callback returning void
  soc/fsl: cpm: tsa: Convert to platform remove callback returning void
  soc/fujitsu: a64fx-diag: Convert to platform remove callback returning
    void
  soc/hisilicon: kunpeng_hccs: Convert to platform remove callback
    returning void
  soc/ixp4xx: ixp4xx-npe: Convert to platform remove callback returning
    void
  soc/ixp4xx: ixp4xx-qmgr: Convert to platform remove callback returning
    void
  soc/litex: litex_soc_ctrl: Convert to platform remove callback
    returning void
  soc/loongson: loongson2_guts: Convert to platform remove callback
    returning void
  soc/mediatek: mtk-devapc: Convert to platform remove callback
    returning void
  soc/mediatek: mtk-mmsys: Convert to platform remove callback returning
    void
  soc/microchip: mpfs-sys-controller: Convert to platform remove
    callback returning void
  soc/pxa: ssp: Convert to platform remove callback returning void
  soc/qcom: icc-bwmon: Convert to platform remove callback returning
    void
  soc/qcom: llcc-qcom: Convert to platform remove callback returning
    void
  soc/qcom: ocmem: Convert to platform remove callback returning void
  soc/qcom: pmic_glink: Convert to platform remove callback returning
    void
  soc/qcom: qcom_aoss: Convert to platform remove callback returning
    void
  soc/qcom: qcom_gsbi: Convert to platform remove callback returning
    void
  soc/qcom: qcom_stats: Convert to platform remove callback returning
    void
  soc/qcom: rmtfs_mem: Convert to platform remove callback returning
    void
  soc/qcom: smem: Convert to platform remove callback returning void
  soc/qcom: smp2p: Convert to platform remove callback returning void
  soc/qcom: smsm: Convert to platform remove callback returning void
  soc/qcom: socinfo: Convert to platform remove callback returning void
  soc/rockchip: io-domain: Convert to platform remove callback returning
    void
  soc/samsung: exynos-chipid: Convert to platform remove callback
    returning void
  soc/tegra: cbb: tegra194-cbb: Convert to platform remove callback
    returning void
  soc/ti: k3-ringacc: Convert to platform remove callback returning void
  soc/ti: knav_dma: Convert to platform remove callback returning void
  soc/ti: knav_qmss_queue: Convert to platform remove callback returning
    void
  soc/ti: pm33xx: Convert to platform remove callback returning void
  soc/ti: pruss: Convert to platform remove callback returning void
  soc/ti: smartreflex: Convert to platform remove callback returning
    void
  soc/ti: wkup_m3_ipc: Convert to platform remove callback returning
    void
  soc/xilinx: zynqmp_power: Convert to platform remove callback
    returning void

 drivers/soc/aspeed/aspeed-lpc-ctrl.c        | 6 ++----
 drivers/soc/aspeed/aspeed-lpc-snoop.c       | 6 ++----
 drivers/soc/aspeed/aspeed-p2a-ctrl.c        | 6 ++----
 drivers/soc/aspeed/aspeed-uart-routing.c    | 6 ++----
 drivers/soc/fsl/dpaa2-console.c             | 6 ++----
 drivers/soc/fsl/qe/qmc.c                    | 6 ++----
 drivers/soc/fsl/qe/tsa.c                    | 5 ++---
 drivers/soc/fujitsu/a64fx-diag.c            | 6 ++----
 drivers/soc/hisilicon/kunpeng_hccs.c        | 6 ++----
 drivers/soc/ixp4xx/ixp4xx-npe.c             | 6 ++----
 drivers/soc/ixp4xx/ixp4xx-qmgr.c            | 5 ++---
 drivers/soc/litex/litex_soc_ctrl.c          | 5 ++---
 drivers/soc/loongson/loongson2_guts.c       | 6 ++----
 drivers/soc/mediatek/mtk-devapc.c           | 6 ++----
 drivers/soc/mediatek/mtk-mmsys.c            | 6 ++----
 drivers/soc/microchip/mpfs-sys-controller.c | 6 ++----
 drivers/soc/pxa/ssp.c                       | 6 ++----
 drivers/soc/qcom/icc-bwmon.c                | 6 ++----
 drivers/soc/qcom/llcc-qcom.c                | 5 ++---
 drivers/soc/qcom/ocmem.c                    | 6 ++----
 drivers/soc/qcom/pmic_glink.c               | 6 ++----
 drivers/soc/qcom/qcom_aoss.c                | 6 ++----
 drivers/soc/qcom/qcom_gsbi.c                | 6 ++----
 drivers/soc/qcom/qcom_stats.c               | 6 ++----
 drivers/soc/qcom/rmtfs_mem.c                | 6 ++----
 drivers/soc/qcom/smem.c                     | 6 ++----
 drivers/soc/qcom/smp2p.c                    | 6 ++----
 drivers/soc/qcom/smsm.c                     | 6 ++----
 drivers/soc/qcom/socinfo.c                  | 6 ++----
 drivers/soc/rockchip/io-domain.c            | 6 ++----
 drivers/soc/samsung/exynos-chipid.c         | 6 ++----
 drivers/soc/tegra/cbb/tegra194-cbb.c        | 6 ++----
 drivers/soc/ti/k3-ringacc.c                 | 5 ++---
 drivers/soc/ti/knav_dma.c                   | 6 ++----
 drivers/soc/ti/knav_qmss_queue.c            | 5 ++---
 drivers/soc/ti/pm33xx.c                     | 5 ++---
 drivers/soc/ti/pruss.c                      | 6 ++----
 drivers/soc/ti/smartreflex.c                | 5 ++---
 drivers/soc/ti/wkup_m3_ipc.c                | 6 ++----
 drivers/soc/xilinx/zynqmp_power.c           | 6 ++----
 40 files changed, 80 insertions(+), 152 deletions(-)

base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
-- 
2.40.1

