From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Sun, 26 Mar 2023 16:30:25 +0200
Subject: [PATCH 000/117] media: Convert to platform remove callback returning void
Message-ID: <20230326143224.572654-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series adapts the platform drivers below drivers/pci to use the
.remove_new() callback. Compared to the traditional .remove() callback
.remove_new() returns no value. This is a good thing because the driver core
doesn't (and cannot) cope for errors during remove. The only effect of a
non-zero return value in .remove() is that the driver core emits a warning. The
device is removed anyhow and an early return from .remove() usually yields a
resource leak.

By changing the remove callback to return void driver authors cannot
reasonably assume any more that there is some kind of cleanup later.

Only three drivers needed some preparation first to make sure they
return 0 unconditionally in their remove callback. Then all drivers
could be trivially converted without side effects to .remove_new().

The changes to the individual drivers are all orthogonal. If I need to
resend some patches because of some review feedback, I'd like to only
send the patches that actually needed changes, so please pick up the
remaining patches that don't need changing to reduce the amount of mail.

Best regards
Uwe

Uwe Kleine-K?nig (117):
  media: cec-gpio: Convert to platform remove callback returning void
  media: cros-ec-cec: Don't exit early in .remove() callback
  media: cros-ec-cec: Convert to platform remove callback returning void
  media: ao-cec-g12a: Convert to platform remove callback returning void
  media: ao-cec: Convert to platform remove callback returning void
  media: s5p_cec: Convert to platform remove callback returning void
  media: seco-cec: Convert to platform remove callback returning void
  media: stih-cec: Convert to platform remove callback returning void
  media: stm32-cec: Convert to platform remove callback returning void
  media: tegra_cec: Convert to platform remove callback returning void
  media: rtl2832_sdr: Convert to platform remove callback returning void
  media: zd1301_demod: Convert to platform remove callback returning
    void
  media: allegro-core: Convert to platform remove callback returning
    void
  media: ge2d: Convert to platform remove callback returning void
  media: vpu_core: Convert to platform remove callback returning void
  media: vpu_drv: Convert to platform remove callback returning void
  media: aspeed-video: Convert to platform remove callback returning
    void
  media: atmel-isi: Convert to platform remove callback returning void
  media: cdns-csi2rx: Convert to platform remove callback returning void
  media: cdns-csi2tx: Convert to platform remove callback returning void
  media: coda-common: Convert to platform remove callback returning void
  media: pxa_camera: Convert to platform remove callback returning void
  media: m2m-deinterlace: Convert to platform remove callback returning
    void
  media: marvell: Simplify remove callback
  media: marvell: Convert to platform remove callback returning void
  media: mtk_jpeg_core: Convert to platform remove callback returning
    void
  media: mtk_mdp_core: Convert to platform remove callback returning
    void
  media: mtk-mdp3-core: Convert to platform remove callback returning
    void
  media: mtk_vcodec_dec_drv: Convert to platform remove callback
    returning void
  media: mtk_vcodec_enc_drv: Convert to platform remove callback
    returning void
  media: mtk_vpu: Convert to platform remove callback returning void
  media: microchip-csi2dc: Convert to platform remove callback returning
    void
  media: microchip-sama5d2-isc: Convert to platform remove callback
    returning void
  media: microchip-sama7g5-isc: Convert to platform remove callback
    returning void
  media: vde: Convert to platform remove callback returning void
  media: dw100: Convert to platform remove callback returning void
  media: mxc-jpeg: Convert to platform remove callback returning void
  media: imx-mipi-csis: Convert to platform remove callback returning
    void
  media: imx-pxp: Convert to platform remove callback returning void
  media: imx7-media-csi: Convert to platform remove callback returning
    void
  media: mx2_emmaprp: Convert to platform remove callback returning void
  media: camss: Convert to platform remove callback returning void
  media: venus: Warn only once about problems in .remove()
  media: venus: Convert to platform remove callback returning void
  media: vdec: Convert to platform remove callback returning void
  media: venc: Convert to platform remove callback returning void
  media: rcar-fcp: Convert to platform remove callback returning void
  media: rcar-isp: Convert to platform remove callback returning void
  media: rcar-core: Convert to platform remove callback returning void
  media: rcar-csi2: Convert to platform remove callback returning void
  media: rcar_drif: Convert to platform remove callback returning void
  media: rcar_fdp1: Convert to platform remove callback returning void
  media: rcar_jpu: Convert to platform remove callback returning void
  media: renesas-ceu: Convert to platform remove callback returning void
  media: rzg2l-core: Convert to platform remove callback returning void
  media: rzg2l-csi2: Convert to platform remove callback returning void
  media: sh_vou: Convert to platform remove callback returning void
  media: vsp1_drv: Convert to platform remove callback returning void
  media: rga: Convert to platform remove callback returning void
  media: rkisp1-dev: Convert to platform remove callback returning void
  media: gsc-core: Convert to platform remove callback returning void
  media: fimc-core: Convert to platform remove callback returning void
  media: fimc-is-i2c: Convert to platform remove callback returning void
  media: fimc-is: Convert to platform remove callback returning void
  media: fimc-lite: Convert to platform remove callback returning void
  media: media-dev: Convert to platform remove callback returning void
  media: mipi-csis: Convert to platform remove callback returning void
  media: camif-core: Convert to platform remove callback returning void
  media: g2d: Convert to platform remove callback returning void
  media: jpeg-core: Convert to platform remove callback returning void
  media: s5p_mfc: Convert to platform remove callback returning void
  media: bdisp-v4l2: Convert to platform remove callback returning void
  media: c8sectpfe-core: Convert to platform remove callback returning
    void
  media: delta-v4l2: Convert to platform remove callback returning void
  media: hva-v4l2: Convert to platform remove callback returning void
  media: dma2d: Convert to platform remove callback returning void
  media: stm32-dcmi: Convert to platform remove callback returning void
  media: sun4i_csi: Convert to platform remove callback returning void
  media: sun6i_csi: Convert to platform remove callback returning void
  media: sun6i_mipi_csi2: Convert to platform remove callback returning
    void
  media: sun8i_a83t_mipi_csi2: Convert to platform remove callback
    returning void
  media: sun8i-di: Convert to platform remove callback returning void
  media: sun8i_rotate: Convert to platform remove callback returning
    void
  media: am437x-vpfe: Convert to platform remove callback returning void
  media: cal: Convert to platform remove callback returning void
  media: vpif: Convert to platform remove callback returning void
  media: vpif_capture: Convert to platform remove callback returning
    void
  media: vpif_display: Convert to platform remove callback returning
    void
  media: omap_vout: Convert to platform remove callback returning void
  media: isp: Convert to platform remove callback returning void
  media: vpe: Convert to platform remove callback returning void
  media: hantro_drv: Convert to platform remove callback returning void
  media: via-camera: Convert to platform remove callback returning void
  media: video-mux: Convert to platform remove callback returning void
  media: xilinx-csi2rxss: Convert to platform remove callback returning
    void
  media: xilinx-tpg: Convert to platform remove callback returning void
  media: xilinx-vipp: Convert to platform remove callback returning void
  media: xilinx-vtc: Convert to platform remove callback returning void
  media: radio-si476x: Convert to platform remove callback returning
    void
  media: radio-timb: Convert to platform remove callback returning void
  media: radio-wl1273: Convert to platform remove callback returning
    void
  media: radio-platform-si4713: Convert to platform remove callback
    returning void
  media: gpio-ir-recv: Convert to platform remove callback returning
    void
  media: img-ir-core: Convert to platform remove callback returning void
  media: ir-hix5hd2: Convert to platform remove callback returning void
  media: meson-ir-tx: Convert to platform remove callback returning void
  media: meson-ir: Convert to platform remove callback returning void
  media: mtk-cir: Convert to platform remove callback returning void
  media: st_rc: Convert to platform remove callback returning void
  media: sunxi-cir: Convert to platform remove callback returning void
  media: vicodec-core: Convert to platform remove callback returning
    void
  media: vidtv_bridge: Convert to platform remove callback returning
    void
  media: vim2m: Convert to platform remove callback returning void
  media: vimc-core: Convert to platform remove callback returning void
  media: visl-core: Convert to platform remove callback returning void
  media: vivid-core: Convert to platform remove callback returning void
  media: it913x: Convert to platform remove callback returning void

 drivers/media/cec/platform/cec-gpio/cec-gpio.c   |  5 ++---
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 16 ++++++++--------
 drivers/media/cec/platform/meson/ao-cec-g12a.c   |  6 ++----
 drivers/media/cec/platform/meson/ao-cec.c        |  6 ++----
 drivers/media/cec/platform/s5p/s5p_cec.c         |  5 ++---
 drivers/media/cec/platform/seco/seco-cec.c       |  6 ++----
 drivers/media/cec/platform/sti/stih-cec.c        |  6 ++----
 drivers/media/cec/platform/stm32/stm32-cec.c     |  6 ++----
 drivers/media/cec/platform/tegra/tegra_cec.c     |  6 ++----
 drivers/media/dvb-frontends/rtl2832_sdr.c        |  6 ++----
 drivers/media/dvb-frontends/zd1301_demod.c       |  6 ++----
 .../media/platform/allegro-dvt/allegro-core.c    |  6 ++----
 drivers/media/platform/amlogic/meson-ge2d/ge2d.c |  6 ++----
 drivers/media/platform/amphion/vpu_core.c        |  6 ++----
 drivers/media/platform/amphion/vpu_drv.c         |  6 ++----
 drivers/media/platform/aspeed/aspeed-video.c     |  6 ++----
 drivers/media/platform/atmel/atmel-isi.c         |  6 ++----
 drivers/media/platform/cadence/cdns-csi2rx.c     |  6 ++----
 drivers/media/platform/cadence/cdns-csi2tx.c     |  6 ++----
 drivers/media/platform/chips-media/coda-common.c |  5 ++---
 drivers/media/platform/intel/pxa_camera.c        |  6 ++----
 drivers/media/platform/m2m-deinterlace.c         |  6 ++----
 drivers/media/platform/marvell/mmp-driver.c      | 16 +++-------------
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c |  6 ++----
 .../media/platform/mediatek/mdp/mtk_mdp_core.c   |  5 ++---
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c |  5 ++---
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c         |  5 ++---
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c         |  5 ++---
 drivers/media/platform/mediatek/vpu/mtk_vpu.c    |  6 ++----
 .../media/platform/microchip/microchip-csi2dc.c  |  6 ++----
 .../platform/microchip/microchip-sama5d2-isc.c   |  6 ++----
 .../platform/microchip/microchip-sama7g5-isc.c   |  6 ++----
 drivers/media/platform/nvidia/tegra-vde/vde.c    |  6 ++----
 drivers/media/platform/nxp/dw100/dw100.c         |  6 ++----
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c   |  6 ++----
 drivers/media/platform/nxp/imx-mipi-csis.c       |  6 ++----
 drivers/media/platform/nxp/imx-pxp.c             |  6 ++----
 drivers/media/platform/nxp/imx7-media-csi.c      |  6 ++----
 drivers/media/platform/nxp/mx2_emmaprp.c         |  6 ++----
 drivers/media/platform/qcom/camss/camss.c        |  6 ++----
 drivers/media/platform/qcom/venus/core.c         |  6 ++----
 drivers/media/platform/qcom/venus/vdec.c         |  6 ++----
 drivers/media/platform/qcom/venus/venc.c         |  6 ++----
 drivers/media/platform/renesas/rcar-fcp.c        |  6 ++----
 drivers/media/platform/renesas/rcar-isp.c        |  6 ++----
 .../media/platform/renesas/rcar-vin/rcar-core.c  |  6 ++----
 .../media/platform/renesas/rcar-vin/rcar-csi2.c  |  6 ++----
 drivers/media/platform/renesas/rcar_drif.c       |  8 +++-----
 drivers/media/platform/renesas/rcar_fdp1.c       |  6 ++----
 drivers/media/platform/renesas/rcar_jpu.c        |  6 ++----
 drivers/media/platform/renesas/renesas-ceu.c     |  6 ++----
 .../platform/renesas/rzg2l-cru/rzg2l-core.c      |  6 ++----
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c      |  6 ++----
 drivers/media/platform/renesas/sh_vou.c          |  5 ++---
 drivers/media/platform/renesas/vsp1/vsp1_drv.c   |  6 ++----
 drivers/media/platform/rockchip/rga/rga.c        |  6 ++----
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c  |  6 ++----
 .../media/platform/samsung/exynos-gsc/gsc-core.c |  5 ++---
 .../platform/samsung/exynos4-is/fimc-core.c      |  5 ++---
 .../platform/samsung/exynos4-is/fimc-is-i2c.c    |  6 ++----
 .../media/platform/samsung/exynos4-is/fimc-is.c  |  6 ++----
 .../platform/samsung/exynos4-is/fimc-lite.c      |  5 ++---
 .../platform/samsung/exynos4-is/media-dev.c      |  8 +++-----
 .../platform/samsung/exynos4-is/mipi-csis.c      |  6 ++----
 .../platform/samsung/s3c-camif/camif-core.c      |  6 ++----
 drivers/media/platform/samsung/s5p-g2d/g2d.c     |  5 ++---
 .../media/platform/samsung/s5p-jpeg/jpeg-core.c  |  6 ++----
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c |  5 ++---
 drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c |  6 ++----
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c   |  6 ++----
 drivers/media/platform/st/sti/delta/delta-v4l2.c |  6 ++----
 drivers/media/platform/st/sti/hva/hva-v4l2.c     |  6 ++----
 drivers/media/platform/st/stm32/dma2d/dma2d.c    |  6 ++----
 drivers/media/platform/st/stm32/stm32-dcmi.c     |  6 ++----
 .../media/platform/sunxi/sun4i-csi/sun4i_csi.c   |  6 ++----
 .../media/platform/sunxi/sun6i-csi/sun6i_csi.c   |  6 ++----
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c      |  6 ++----
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c  |  6 ++----
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c |  6 ++----
 .../platform/sunxi/sun8i-rotate/sun8i_rotate.c   |  6 ++----
 drivers/media/platform/ti/am437x/am437x-vpfe.c   |  6 ++----
 drivers/media/platform/ti/cal/cal.c              |  6 ++----
 drivers/media/platform/ti/davinci/vpif.c         |  6 ++----
 drivers/media/platform/ti/davinci/vpif_capture.c |  5 ++---
 drivers/media/platform/ti/davinci/vpif_display.c |  6 ++----
 drivers/media/platform/ti/omap/omap_vout.c       |  5 ++---
 drivers/media/platform/ti/omap3isp/isp.c         |  6 ++----
 drivers/media/platform/ti/vpe/vpe.c              |  6 ++----
 drivers/media/platform/verisilicon/hantro_drv.c  |  5 ++---
 drivers/media/platform/via/via-camera.c          |  5 ++---
 drivers/media/platform/video-mux.c               |  6 ++----
 drivers/media/platform/xilinx/xilinx-csi2rxss.c  |  6 ++----
 drivers/media/platform/xilinx/xilinx-tpg.c       |  6 ++----
 drivers/media/platform/xilinx/xilinx-vipp.c      |  6 ++----
 drivers/media/platform/xilinx/xilinx-vtc.c       |  6 ++----
 drivers/media/radio/radio-si476x.c               |  6 ++----
 drivers/media/radio/radio-timb.c                 |  5 ++---
 drivers/media/radio/radio-wl1273.c               |  6 ++----
 .../media/radio/si4713/radio-platform-si4713.c   |  6 ++----
 drivers/media/rc/gpio-ir-recv.c                  |  6 ++----
 drivers/media/rc/img-ir/img-ir-core.c            |  5 ++---
 drivers/media/rc/ir-hix5hd2.c                    |  5 ++---
 drivers/media/rc/meson-ir-tx.c                   |  6 ++----
 drivers/media/rc/meson-ir.c                      |  6 ++----
 drivers/media/rc/mtk-cir.c                       |  6 ++----
 drivers/media/rc/st_rc.c                         |  5 ++---
 drivers/media/rc/sunxi-cir.c                     |  6 ++----
 .../media/test-drivers/vicodec/vicodec-core.c    |  6 ++----
 drivers/media/test-drivers/vidtv/vidtv_bridge.c  |  6 ++----
 drivers/media/test-drivers/vim2m.c               |  6 ++----
 drivers/media/test-drivers/vimc/vimc-core.c      |  6 ++----
 drivers/media/test-drivers/visl/visl-core.c      |  6 ++----
 drivers/media/test-drivers/vivid/vivid-core.c    |  5 ++---
 drivers/media/tuners/it913x.c                    |  6 ++----
 114 files changed, 237 insertions(+), 449 deletions(-)

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

