From: Inki Dae <daeinki@gmail.com>
Date: Mon, 15 May 2023 16:50:57 +0900
Subject: [PATCH 00/53] drm: Convert to platform remove callback returning void
In-Reply-To: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
References: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
Message-ID: <CAAQKjZP5jhwFg9sNndpa6_7G6HoV76heQbt=knoOEZZskexrhg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

2023? 5? 8? (?) ?? 1:32, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>?? ??:
>
> Hello,
>
> this patch series adapts the platform drivers below drivers/gpu/drm
> to use the .remove_new() callback. Compared to the traditional .remove()
> callback .remove_new() returns no value. This is a good thing because

First of all, I apologize for the delay in providing my review comments.

Not related to this patch but seems that the "remove_new" callback
naming implicitly implies that there is no need to return anything
since its return type is void. To help users understand the intended
behavior based on the callback name, how about considering a modified
naming convention like "remove_no_return" or something similar?

The relevant patch has already been merged as outlined below,
author Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> 2022-12-09
16:09:14 +0100
committer Greg Kroah-Hartman <gregkh@linuxfoundation.org> 2023-01-17
19:04:17 +0100
commit 5c5a7680e67ba6fbbb5f4d79fa41485450c1985c (patch)
tree 0b6dbc003a6bb4a3f7fb084d31326bbfa3ba3f7c
parent 7bbb89b420d9e290cb34864832de8fcdf2c140dc (diff)
download linux-5c5a7680e67ba6fbbb5f4d79fa41485450c1985c.tar.gz
platform: Provide a remove callback that returns no value

Maybe a trivial thing but how about renaming it? I think the postfix,
'new', is a very generic word. I think you could introduce another
patch for it if you think it's reasonable.

Thanks,
Inki Dae

> the driver core doesn't (and cannot) cope for errors during remove. The
> only effect of a non-zero return value in .remove() is that the driver
> core emits a warning. The device is removed anyhow and an early return
> from .remove() usually yields a resource leak.
>
> By changing the remove callback to return void driver authors cannot
> reasonably (but wrongly) assume any more that there happens some kind of
> cleanup later.
>
> Best regards
> Uwe
>
> Uwe Kleine-K?nig (53):
>   drm/komeda: Convert to platform remove callback returning void
>   drm/arm/hdlcd: Convert to platform remove callback returning void
>   drm/arm/malidp: Convert to platform remove callback returning void
>   drm/armada: Convert to platform remove callback returning void
>   drm/aspeed: Convert to platform remove callback returning void
>   drm/atmel-hlcdc: Convert to platform remove callback returning void
>   drm/bridge: cdns-dsi: Convert to platform remove callback returning
>     void
>   drm/bridge: display-connector: Convert to platform remove callback
>     returning void
>   drm/bridge: fsl-ldb: Convert to platform remove callback returning
>     void
>   drm/imx/imx8*: Convert to platform remove callback returning void
>   drm/bridge: lvds-codec: Convert to platform remove callback returning
>     void
>   drm/bridge: nwl-dsi: Convert to platform remove callback returning
>     void
>   drm/bridge: simple-bridge: Convert to platform remove callback
>     returning void
>   drm/bridge: synopsys: Convert to platform remove callback returning
>     void
>   drm/bridge: thc63lvd1024: Convert to platform remove callback
>     returning void
>   drm/bridge: tfp410: Convert to platform remove callback returning void
>   drm/etnaviv: Convert to platform remove callback returning void
>   drm/exynos: Convert to platform remove callback returning void
>   drm/fsl-dcu: Convert to platform remove callback returning void
>   drm/hisilicon: Convert to platform remove callback returning void
>   drm/imx/dcss: Convert to platform remove callback returning void
>   drm/imx/ipuv3: Convert to platform remove callback returning void
>   drm/ingenic: Convert to platform remove callback returning void
>   drm/kmb: Convert to platform remove callback returning void
>   drm/lima: Convert to platform remove callback returning void
>   drm/logicvc: Convert to platform remove callback returning void
>   drm/mcde: Convert to platform remove callback returning void
>   drm/mediatek: Convert to platform remove callback returning void
>   drm/mediatek: Convert to platform remove callback returning void
>   drm/meson: Convert to platform remove callback returning void
>   drm/msm: Convert to platform remove callback returning void
>   drm/mxsfb: Convert to platform remove callback returning void
>   drm/nouveau: Convert to platform remove callback returning void
>   drm/omap: Convert to platform remove callback returning void
>   drm/panel: Convert to platform remove callback returning void
>   drm/panfrost: Convert to platform remove callback returning void
>   drm/rcar-du: Convert to platform remove callback returning void
>   drm/rockchip: Convert to platform remove callback returning void
>   drm/shmobile: Convert to platform remove callback returning void
>   drm/sprd: Convert to platform remove callback returning void
>   drm/sti: Convert to platform remove callback returning void
>   drm/stm: Convert to platform remove callback returning void
>   drm/sun4i: Convert to platform remove callback returning void
>   drm/tegra: Convert to platform remove callback returning void
>   drm/tests: helpers: Convert to platform remove callback returning void
>   drm/tidss: Convert to platform remove callback returning void
>   drm/tilcdc: Convert to platform remove callback returning void
>   drm/tiny: Convert to platform remove callback returning void
>   drm/tiny: Convert to platform remove callback returning void
>   drm/tve200: Convert to platform remove callback returning void
>   drm/v3d: Convert to platform remove callback returning void
>   drm/vc4: Convert to platform remove callback returning void
>   drm/xlnx/zynqmp_dpsub: Convert to platform remove callback returning
>     void
>
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c     | 5 ++---
>  drivers/gpu/drm/arm/hdlcd_drv.c                     | 5 ++---
>  drivers/gpu/drm/arm/malidp_drv.c                    | 5 ++---
>  drivers/gpu/drm/armada/armada_crtc.c                | 5 ++---
>  drivers/gpu/drm/armada/armada_drv.c                 | 5 ++---
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c             | 6 ++----
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c        | 6 ++----
>  drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c      | 6 ++----
>  drivers/gpu/drm/bridge/display-connector.c          | 6 ++----
>  drivers/gpu/drm/bridge/fsl-ldb.c                    | 6 ++----
>  drivers/gpu/drm/bridge/imx/imx8qm-ldb-drv.c         | 6 ++----
>  drivers/gpu/drm/bridge/imx/imx8qxp-ldb-drv.c        | 6 ++----
>  drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c | 6 ++----
>  drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c     | 6 ++----
>  drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c        | 6 ++----
>  drivers/gpu/drm/bridge/lvds-codec.c                 | 6 ++----
>  drivers/gpu/drm/bridge/nwl-dsi.c                    | 5 ++---
>  drivers/gpu/drm/bridge/simple-bridge.c              | 6 ++----
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 6 ++----
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c       | 6 ++----
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c  | 6 ++----
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 6 ++----
>  drivers/gpu/drm/bridge/thc63lvd1024.c               | 6 ++----
>  drivers/gpu/drm/bridge/ti-tfp410.c                  | 6 ++----
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c               | 6 ++----
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c               | 5 ++---
>  drivers/gpu/drm/exynos/exynos5433_drm_decon.c       | 6 ++----
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c          | 6 ++----
>  drivers/gpu/drm/exynos/exynos_dp.c                  | 6 ++----
>  drivers/gpu/drm/exynos/exynos_drm_drv.c             | 5 ++---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c             | 6 ++----
>  drivers/gpu/drm/exynos/exynos_drm_fimc.c            | 6 ++----
>  drivers/gpu/drm/exynos/exynos_drm_fimd.c            | 6 ++----
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c             | 6 ++----
>  drivers/gpu/drm/exynos/exynos_drm_gsc.c             | 6 ++----
>  drivers/gpu/drm/exynos/exynos_drm_mic.c             | 6 ++----
>  drivers/gpu/drm/exynos/exynos_drm_rotator.c         | 6 ++----
>  drivers/gpu/drm/exynos/exynos_drm_scaler.c          | 6 ++----
>  drivers/gpu/drm/exynos/exynos_hdmi.c                | 6 ++----
>  drivers/gpu/drm/exynos/exynos_mixer.c               | 6 ++----
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c           | 6 ++----
>  drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c        | 6 ++----
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c     | 5 ++---
>  drivers/gpu/drm/imx/dcss/dcss-drv.c                 | 6 ++----
>  drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c             | 6 ++----
>  drivers/gpu/drm/imx/ipuv3/imx-drm-core.c            | 5 ++---
>  drivers/gpu/drm/imx/ipuv3/imx-ldb.c                 | 5 ++---
>  drivers/gpu/drm/imx/ipuv3/imx-tve.c                 | 5 ++---
>  drivers/gpu/drm/imx/ipuv3/ipuv3-crtc.c              | 5 ++---
>  drivers/gpu/drm/imx/ipuv3/parallel-display.c        | 6 ++----
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c           | 6 ++----
>  drivers/gpu/drm/ingenic/ingenic-ipu.c               | 5 ++---
>  drivers/gpu/drm/kmb/kmb_drv.c                       | 5 ++---
>  drivers/gpu/drm/lima/lima_drv.c                     | 5 ++---
>  drivers/gpu/drm/logicvc/logicvc_drm.c               | 6 ++----
>  drivers/gpu/drm/mcde/mcde_drv.c                     | 6 ++----
>  drivers/gpu/drm/mcde/mcde_dsi.c                     | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_cec.c                  | 5 ++---
>  drivers/gpu/drm/mediatek/mtk_disp_aal.c             | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c           | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_disp_color.c           | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_disp_gamma.c           | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_disp_merge.c           | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c             | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c            | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_dp.c                   | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_dpi.c                  | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c              | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_dsi.c                  | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_hdmi.c                 | 5 ++---
>  drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c             | 6 ++----
>  drivers/gpu/drm/mediatek/mtk_mdp_rdma.c             | 5 ++---
>  drivers/gpu/drm/meson/meson_drv.c                   | 6 ++----
>  drivers/gpu/drm/meson/meson_dw_hdmi.c               | 6 ++----
>  drivers/gpu/drm/msm/adreno/adreno_device.c          | 5 ++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c             | 6 ++----
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c            | 6 ++----
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c            | 5 ++---
>  drivers/gpu/drm/msm/dp/dp_display.c                 | 6 ++----
>  drivers/gpu/drm/msm/dsi/dsi.c                       | 6 ++----
>  drivers/gpu/drm/msm/hdmi/hdmi.c                     | 6 ++----
>  drivers/gpu/drm/msm/hdmi/hdmi_phy.c                 | 6 ++----
>  drivers/gpu/drm/msm/msm_drv.c                       | 6 ++----
>  drivers/gpu/drm/msm/msm_mdss.c                      | 6 ++----
>  drivers/gpu/drm/mxsfb/lcdif_drv.c                   | 6 ++----
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c                   | 6 ++----
>  drivers/gpu/drm/nouveau/nouveau_platform.c          | 5 ++---
>  drivers/gpu/drm/omapdrm/dss/dispc.c                 | 5 ++---
>  drivers/gpu/drm/omapdrm/dss/dsi.c                   | 6 ++----
>  drivers/gpu/drm/omapdrm/dss/dss.c                   | 6 ++----
>  drivers/gpu/drm/omapdrm/dss/hdmi4.c                 | 5 ++---
>  drivers/gpu/drm/omapdrm/dss/hdmi5.c                 | 5 ++---
>  drivers/gpu/drm/omapdrm/dss/venc.c                  | 5 ++---
>  drivers/gpu/drm/omapdrm/omap_dmm_tiler.c            | 9 +++------
>  drivers/gpu/drm/omapdrm/omap_drv.c                  | 6 ++----
>  drivers/gpu/drm/panel/panel-lvds.c                  | 6 ++----
>  drivers/gpu/drm/panel/panel-seiko-43wvf1g.c         | 6 ++----
>  drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c     | 6 ++----
>  drivers/gpu/drm/panel/panel-simple.c                | 6 ++----
>  drivers/gpu/drm/panfrost/panfrost_drv.c             | 5 ++---
>  drivers/gpu/drm/rcar-du/rcar_cmm.c                  | 6 ++----
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c               | 6 ++----
>  drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c              | 6 ++----
>  drivers/gpu/drm/rcar-du/rcar_lvds.c                 | 6 ++----
>  drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c             | 6 ++----
>  drivers/gpu/drm/rcar-du/rzg2l_mipi_dsi.c            | 6 ++----
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c     | 6 ++----
>  drivers/gpu/drm/rockchip/cdn-dp-core.c              | 6 ++----
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c     | 6 ++----
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c         | 6 ++----
>  drivers/gpu/drm/rockchip/inno_hdmi.c                | 6 ++----
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c              | 6 ++----
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c         | 6 ++----
>  drivers/gpu/drm/rockchip/rockchip_lvds.c            | 6 ++----
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c        | 6 ++----
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c         | 6 ++----
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c            | 6 ++----
>  drivers/gpu/drm/sprd/sprd_dpu.c                     | 6 ++----
>  drivers/gpu/drm/sprd/sprd_drm.c                     | 5 ++---
>  drivers/gpu/drm/sprd/sprd_dsi.c                     | 6 ++----
>  drivers/gpu/drm/sti/sti_compositor.c                | 5 ++---
>  drivers/gpu/drm/sti/sti_drv.c                       | 6 ++----
>  drivers/gpu/drm/sti/sti_dvo.c                       | 5 ++---
>  drivers/gpu/drm/sti/sti_hda.c                       | 5 ++---
>  drivers/gpu/drm/sti/sti_hdmi.c                      | 6 ++----
>  drivers/gpu/drm/sti/sti_hqvdp.c                     | 5 ++---
>  drivers/gpu/drm/sti/sti_tvout.c                     | 5 ++---
>  drivers/gpu/drm/stm/drv.c                           | 6 ++----
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c               | 6 ++----
>  drivers/gpu/drm/sun4i/sun4i_backend.c               | 6 ++----
>  drivers/gpu/drm/sun4i/sun4i_drv.c                   | 6 ++----
>  drivers/gpu/drm/sun4i/sun4i_frontend.c              | 6 ++----
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c              | 6 ++----
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                  | 6 ++----
>  drivers/gpu/drm/sun4i/sun4i_tv.c                    | 6 ++----
>  drivers/gpu/drm/sun4i/sun6i_drc.c                   | 6 ++----
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c              | 6 ++----
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c               | 6 ++----
>  drivers/gpu/drm/sun4i/sun8i_mixer.c                 | 6 ++----
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c              | 6 ++----
>  drivers/gpu/drm/tegra/dpaux.c                       | 6 ++----
>  drivers/gpu/drm/tests/drm_kunit_helpers.c           | 5 ++---
>  drivers/gpu/drm/tidss/tidss_drv.c                   | 6 ++----
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c               | 6 ++----
>  drivers/gpu/drm/tiny/arcpgu.c                       | 6 ++----
>  drivers/gpu/drm/tiny/ofdrm.c                        | 6 ++----
>  drivers/gpu/drm/tiny/simpledrm.c                    | 6 ++----
>  drivers/gpu/drm/tve200/tve200_drv.c                 | 6 ++----
>  drivers/gpu/drm/v3d/v3d_drv.c                       | 6 ++----
>  drivers/gpu/drm/vc4/vc4_crtc.c                      | 5 ++---
>  drivers/gpu/drm/vc4/vc4_dpi.c                       | 5 ++---
>  drivers/gpu/drm/vc4/vc4_drv.c                       | 6 ++----
>  drivers/gpu/drm/vc4/vc4_dsi.c                       | 6 ++----
>  drivers/gpu/drm/vc4/vc4_hdmi.c                      | 5 ++---
>  drivers/gpu/drm/vc4/vc4_hvs.c                       | 5 ++---
>  drivers/gpu/drm/vc4/vc4_txp.c                       | 5 ++---
>  drivers/gpu/drm/vc4/vc4_v3d.c                       | 5 ++---
>  drivers/gpu/drm/vc4/vc4_vec.c                       | 5 ++---
>  drivers/gpu/drm/xlnx/zynqmp_dpsub.c                 | 6 ++----
>  159 files changed, 319 insertions(+), 597 deletions(-)
>
>
> base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
> --
> 2.39.2
>
