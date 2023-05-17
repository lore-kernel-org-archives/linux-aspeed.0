From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 18 May 2023 01:01:02 +0200
Subject: [PATCH 00/97] usb: Convert to platform remove callback returning void
Message-ID: <20230517230239.187727-1-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

this series convers the drivers below drivers/usb to the .remove_new()
callback of struct platform_driver(). The motivation is to make the
remove callback less prone for errors and wrong assumptions. See commit
5c5a7680e67b ("platform: Provide a remove callback that returns no
value") for a more detailed rationale.

All drivers converted here already returned zero unconditionally in their
.remove() callback, so converting them to .remove_new() is trivial.

Best regards
Uwe

Uwe Kleine-K?nig (97):
  usb: c67x00-drv: Convert to platform remove callback returning void
  usb: cdns3-imx: Convert to platform remove callback returning void
  usb: cdns3-plat: Convert to platform remove callback returning void
  usb: cdns3-ti: Convert to platform remove callback returning void
  usb: chipidea/ci_hdrc_imx: Convert to platform remove callback
    returning void
  usb: chipidea/ci_hdrc_msm: Convert to platform remove callback
    returning void
  usb: chipidea/ci_hdrc_tegra: Convert to platform remove callback
    returning void
  usb: chipidea/ci_hdrc_usb2: Convert to platform remove callback
    returning void
  usb: chipidea/core: Convert to platform remove callback returning void
  usb: common: usb-conn-gpio: Convert to platform remove callback
    returning void
  usb: dwc2/platform: Convert to platform remove callback returning void
  usb: core: Convert to platform remove callback returning void
  usb: dwc3-am62: Convert to platform remove callback returning void
  usb: dwc3-exynos: Convert to platform remove callback returning void
  usb: dwc3-imx8mp: Convert to platform remove callback returning void
  usb: dwc3-keystone: Convert to platform remove callback returning void
  usb: dwc3-meson-g12a: Convert to platform remove callback returning
    void
  usb: dwc3-of-simple: Convert to platform remove callback returning
    void
  usb: dwc3-omap: Convert to platform remove callback returning void
  usb: dwc3-qcom: Convert to platform remove callback returning void
  usb: dwc3-st: Convert to platform remove callback returning void
  usb: dwc3-xilinx: Convert to platform remove callback returning void
  usb: fotg210: Convert to platform remove callback returning void
  usb: gadget: hid: Convert to platform remove callback returning void
  usb: gadget: aspeed: Convert to platform remove callback returning
    void
  usb: gadget/atmel_usba_udc: Convert to platform remove callback
    returning void
  usb: gadget/bcm63xx_udc: Convert to platform remove callback returning
    void
  usb: bdc: Convert to platform remove callback returning void
  usb: gadget/dummy_hcd: Convert to platform remove callback returning
    void
  usb: gadget/fsl_qe_udc: Convert to platform remove callback returning
    void
  usb: gadget/fusb300_udc: Convert to platform remove callback returning
    void
  usb: gadget/m66592-udc: Convert to platform remove callback returning
    void
  usb: gadget/mv_u3d_core: Convert to platform remove callback returning
    void
  usb: gadget/mv_udc_core: Convert to platform remove callback returning
    void
  usb: gadget/net2272: Convert to platform remove callback returning
    void
  usb: gadget/omap_udc: Convert to platform remove callback returning
    void
  usb: gadget/pxa27x_udc: Convert to platform remove callback returning
    void
  usb: gadget/r8a66597-udc: Convert to platform remove callback
    returning void
  usb: gadget/renesas_usb3: Convert to platform remove callback
    returning void
  usb: gadget/renesas_usbf: Convert to platform remove callback
    returning void
  usb: gadget/rzv2m_usb3drd: Convert to platform remove callback
    returning void
  usb: gadget/snps_udc_plat: Convert to platform remove callback
    returning void
  usb: gadget/tegra-xudc: Convert to platform remove callback returning
    void
  usb: gadget/udc-xilinx: Convert to platform remove callback returning
    void
  usb: ehci-atmel: Convert to platform remove callback returning void
  usb: ehci-brcm: Convert to platform remove callback returning void
  usb: ehci-exynos: Convert to platform remove callback returning void
  usb: ehci-fsl: Convert to platform remove callback returning void
  usb: ehci-grlib: Convert to platform remove callback returning void
  usb: ehci-mv: Convert to platform remove callback returning void
  usb: ehci-npcm7xx: Convert to platform remove callback returning void
  usb: ehci-omap: Convert to platform remove callback returning void
  usb: ehci-orion: Convert to platform remove callback returning void
  usb: ehci-platform: Convert to platform remove callback returning void
  usb: ehci-ppc-of: Convert to platform remove callback returning void
  usb: ehci-sh: Convert to platform remove callback returning void
  usb: ehci-spear: Convert to platform remove callback returning void
  usb: ehci-st: Convert to platform remove callback returning void
  usb: ehci-xilinx-of: Convert to platform remove callback returning
    void
  usb: fsl-mph-dr-of: Convert to platform remove callback returning void
  usb: isp116x-hcd: Convert to platform remove callback returning void
  usb: isp1362-hcd: Convert to platform remove callback returning void
  usb: octeon-hcd: Convert to platform remove callback returning void
  usb: ohci-at91: Convert to platform remove callback returning void
  usb: ohci-da8xx: Convert to platform remove callback returning void
  usb: ohci-exynos: Convert to platform remove callback returning void
  usb: ohci-nxp: Convert to platform remove callback returning void
  usb: ohci-omap: Convert to platform remove callback returning void
  usb: ohci-platform: Convert to platform remove callback returning void
  usb: ohci-ppc-of: Convert to platform remove callback returning void
  usb: ohci-pxa27x: Convert to platform remove callback returning void
  usb: ohci-s3c2410: Convert to platform remove callback returning void
  usb: ohci-sm501: Convert to platform remove callback returning void
  usb: ohci-spear: Convert to platform remove callback returning void
  usb: ohci-st: Convert to platform remove callback returning void
  usb: oxu210hp-hcd: Convert to platform remove callback returning void
  usb: r8a66597-hcd: Convert to platform remove callback returning void
  usb: sl811-hcd: Convert to platform remove callback returning void
  usb: uhci-grlib: Convert to platform remove callback returning void
  usb: uhci-platform: Convert to platform remove callback returning void
  usb: xhci-histb: Convert to platform remove callback returning void
  usb: xhci-mtk: Convert to platform remove callback returning void
  usb: xhci-plat: Convert to platform remove callback returning void
  usb: xhci-tegra: Convert to platform remove callback returning void
  usb: isp1760: Convert to platform remove callback returning void
  usb: misc: eud: Convert to platform remove callback returning void
  usb: misc: usb3503: Convert to platform remove callback returning void
  usb: renesas_usbhs: Convert to platform remove callback returning void
  usb: roles: intel_xhci: Convert to platform remove callback returning
    void
  usb: typec: mux: gpio-sbu: Convert to platform remove callback
    returning void
  usb: typec: intel_pmc_mux: Convert to platform remove callback
    returning void
  usb: typec: qcom-pmic-typec: Convert to platform remove callback
    returning void
  usb: typec: tcpci_mt6360: Convert to platform remove callback
    returning void
  usb: typec: tcpci_mt6360: Convert to platform remove callback
    returning void
  usb: typec: wcove: Convert to platform remove callback returning void
  usb: typec: ucsi: acpi: Convert to platform remove callback returning
    void
  usbip: vhci_hcd: Convert to platform remove callback returning void

 drivers/usb/c67x00/c67x00-drv.c                |  6 ++----
 drivers/usb/cdns3/cdns3-imx.c                  |  6 ++----
 drivers/usb/cdns3/cdns3-plat.c                 |  5 ++---
 drivers/usb/cdns3/cdns3-ti.c                   |  6 ++----
 drivers/usb/chipidea/ci_hdrc_imx.c             |  6 ++----
 drivers/usb/chipidea/ci_hdrc_msm.c             |  6 ++----
 drivers/usb/chipidea/ci_hdrc_tegra.c           |  6 ++----
 drivers/usb/chipidea/ci_hdrc_usb2.c            |  6 ++----
 drivers/usb/chipidea/core.c                    |  6 ++----
 drivers/usb/common/usb-conn-gpio.c             |  6 ++----
 drivers/usb/dwc2/platform.c                    |  6 ++----
 drivers/usb/dwc3/core.c                        |  6 ++----
 drivers/usb/dwc3/dwc3-am62.c                   |  5 ++---
 drivers/usb/dwc3/dwc3-exynos.c                 |  6 ++----
 drivers/usb/dwc3/dwc3-imx8mp.c                 |  6 ++----
 drivers/usb/dwc3/dwc3-keystone.c               |  6 ++----
 drivers/usb/dwc3/dwc3-meson-g12a.c             |  6 ++----
 drivers/usb/dwc3/dwc3-of-simple.c              |  6 ++----
 drivers/usb/dwc3/dwc3-omap.c                   |  6 ++----
 drivers/usb/dwc3/dwc3-qcom.c                   |  6 ++----
 drivers/usb/dwc3/dwc3-st.c                     |  6 ++----
 drivers/usb/dwc3/dwc3-xilinx.c                 |  6 ++----
 drivers/usb/fotg210/fotg210-core.c             |  6 ++----
 drivers/usb/gadget/legacy/hid.c                |  6 ++----
 drivers/usb/gadget/udc/aspeed-vhub/core.c      |  8 +++-----
 drivers/usb/gadget/udc/atmel_usba_udc.c        |  6 ++----
 drivers/usb/gadget/udc/bcm63xx_udc.c           |  6 ++----
 drivers/usb/gadget/udc/bdc/bdc_core.c          |  5 ++---
 drivers/usb/gadget/udc/dummy_hcd.c             | 11 ++++-------
 drivers/usb/gadget/udc/fsl_qe_udc.c            |  6 ++----
 drivers/usb/gadget/udc/fusb300_udc.c           |  6 ++----
 drivers/usb/gadget/udc/m66592-udc.c            |  5 ++---
 drivers/usb/gadget/udc/mv_u3d_core.c           |  6 ++----
 drivers/usb/gadget/udc/mv_udc_core.c           |  6 ++----
 drivers/usb/gadget/udc/net2272.c               |  6 ++----
 drivers/usb/gadget/udc/omap_udc.c              |  6 ++----
 drivers/usb/gadget/udc/pxa27x_udc.c            |  6 ++----
 drivers/usb/gadget/udc/r8a66597-udc.c          |  6 ++----
 drivers/usb/gadget/udc/renesas_usb3.c          |  6 ++----
 drivers/usb/gadget/udc/renesas_usbf.c          |  6 ++----
 drivers/usb/gadget/udc/rzv2m_usb3drd.c         |  6 ++----
 drivers/usb/gadget/udc/snps_udc_plat.c         |  8 +++-----
 drivers/usb/gadget/udc/tegra-xudc.c            |  6 ++----
 drivers/usb/gadget/udc/udc-xilinx.c            |  6 ++----
 drivers/usb/host/ehci-atmel.c                  |  6 ++----
 drivers/usb/host/ehci-brcm.c                   |  5 ++---
 drivers/usb/host/ehci-exynos.c                 |  6 ++----
 drivers/usb/host/ehci-fsl.c                    |  6 ++----
 drivers/usb/host/ehci-grlib.c                  |  6 ++----
 drivers/usb/host/ehci-mv.c                     |  6 ++----
 drivers/usb/host/ehci-npcm7xx.c                |  6 ++----
 drivers/usb/host/ehci-omap.c                   |  6 ++----
 drivers/usb/host/ehci-orion.c                  |  6 ++----
 drivers/usb/host/ehci-platform.c               |  6 ++----
 drivers/usb/host/ehci-ppc-of.c                 |  6 ++----
 drivers/usb/host/ehci-sh.c                     |  6 ++----
 drivers/usb/host/ehci-spear.c                  |  6 ++----
 drivers/usb/host/ehci-st.c                     |  6 ++----
 drivers/usb/host/ehci-xilinx-of.c              |  6 ++----
 drivers/usb/host/fsl-mph-dr-of.c               |  5 ++---
 drivers/usb/host/isp116x-hcd.c                 |  7 +++----
 drivers/usb/host/isp1362-hcd.c                 |  6 ++----
 drivers/usb/host/octeon-hcd.c                  |  6 ++----
 drivers/usb/host/ohci-at91.c                   |  5 ++---
 drivers/usb/host/ohci-da8xx.c                  |  6 ++----
 drivers/usb/host/ohci-exynos.c                 |  6 ++----
 drivers/usb/host/ohci-nxp.c                    |  6 ++----
 drivers/usb/host/ohci-omap.c                   |  5 ++---
 drivers/usb/host/ohci-platform.c               |  6 ++----
 drivers/usb/host/ohci-ppc-of.c                 |  6 ++----
 drivers/usb/host/ohci-pxa27x.c                 |  5 ++---
 drivers/usb/host/ohci-s3c2410.c                |  5 ++---
 drivers/usb/host/ohci-sm501.c                  |  6 ++----
 drivers/usb/host/ohci-spear.c                  |  5 ++---
 drivers/usb/host/ohci-st.c                     |  6 ++----
 drivers/usb/host/oxu210hp-hcd.c                |  6 ++----
 drivers/usb/host/r8a66597-hcd.c                |  5 ++---
 drivers/usb/host/sl811-hcd.c                   |  5 ++---
 drivers/usb/host/uhci-grlib.c                  |  6 ++----
 drivers/usb/host/uhci-platform.c               |  6 ++----
 drivers/usb/host/xhci-histb.c                  |  6 ++----
 drivers/usb/host/xhci-mtk.c                    |  6 ++----
 drivers/usb/host/xhci-plat.c                   |  6 ++----
 drivers/usb/host/xhci-tegra.c                  |  6 ++----
 drivers/usb/isp1760/isp1760-if.c               |  6 ++----
 drivers/usb/misc/qcom_eud.c                    |  6 ++----
 drivers/usb/misc/usb3503.c                     |  6 ++----
 drivers/usb/renesas_usbhs/common.c             |  6 ++----
 drivers/usb/roles/intel-xhci-usb-role-switch.c |  6 ++----
 drivers/usb/typec/mux/gpio-sbu-mux.c           |  6 ++----
 drivers/usb/typec/mux/intel_pmc_mux.c          |  6 ++----
 drivers/usb/typec/qcom-pmic-typec.c            |  6 ++----
 drivers/usb/typec/tcpm/tcpci_mt6360.c          |  5 ++---
 drivers/usb/typec/tcpm/tcpci_mt6370.c          |  6 ++----
 drivers/usb/typec/tcpm/wcove.c                 |  6 ++----
 drivers/usb/typec/ucsi/ucsi_acpi.c             |  6 ++----
 drivers/usb/usbip/vhci_hcd.c                   |  6 ++----
 97 files changed, 199 insertions(+), 379 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

