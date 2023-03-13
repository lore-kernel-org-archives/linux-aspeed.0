From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 13 Mar 2023 16:51:13 +0100
Subject: [PATCH v2 00/25] drm/dma-helper: Add dedicated fbdev emulation
Message-ID: <20230313155138.20584-1-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add fbdev emulation that is optimized for DMA helpers, as used by most
drivers. It operates directly on GEM DMA buffers in system memory.
Memory pages are mmap'ed directly to userspace. No implicit shadow
buffers need to be allocated; as can happen with the generic fbdev
emulation. Convert drivers that fulfil the requirements.

Tested with fbcon and IGT on vc4.

Future direction: providing a dedicated fbdev emulation for GEM DMA
helpers will allow us to remove this case from the generic fbdev code.
The latter can then be simplified.

v2:
	* update mcde and pl111 as well (Linus)

Linus Walleij (1):
  drm/mcde: Do not use dirty GEM FB handling

Thomas Zimmermann (24):
  drm/fbdev-dma: Implement fbdev emulation for GEM DMA helpers
  arm/hdlcd: Use GEM DMA fbdev emulation
  arm/malidp: Use GEM DMA fbdev emulation
  drm/aspeed: Use GEM DMA fbdev emulation
  drm/atmel-hlcdc: Use GEM DMA fbdev emulation
  drm/fsl-dcu: Use GEM DMA fbdev emulation
  drm/imx/dcss: Use GEM DMA fbdev emulation
  drm/imx: Use GEM DMA fbdev emulation
  drm/kmb: Use GEM DMA fbdev emulation
  drm/logicvc: Use GEM DMA fbdev emulation
  drm/meson: Use GEM DMA fbdev emulation
  drm/mxsfb/lcdif: Use GEM DMA fbdev emulation
  drm/mxsfb: Use GEM DMA fbdev emulation
  drm/sti: Use GEM DMA fbdev emulation
  drm/stm: Use GEM DMA fbdev emulation
  drm/sun4i: Use GEM DMA fbdev emulation
  drm/tidss: Use GEM DMA fbdev emulation
  drm/tilcdc: Use GEM DMA fbdev emulation
  drm/arcpgu: Use GEM DMA fbdev emulation
  drm/tve200: Use GEM DMA fbdev emulation
  drm/vc4: Use GEM DMA fbdev emulation
  drm/xlnx: Use GEM DMA fbdev emulation
  drm/mcde: Use GEM DMA fbdev emulation
  drm/pl111: Use GEM DMA fbdev emulation

 drivers/gpu/drm/Makefile                     |   1 +
 drivers/gpu/drm/arm/hdlcd_drv.c              |   4 +-
 drivers/gpu/drm/arm/malidp_drv.c             |   4 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c      |   4 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c |   4 +-
 drivers/gpu/drm/drm_fbdev_dma.c              | 275 +++++++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c    |   4 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c          |   4 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c     |   4 +-
 drivers/gpu/drm/kmb/kmb_drv.c                |   4 +-
 drivers/gpu/drm/logicvc/logicvc_drm.c        |   4 +-
 drivers/gpu/drm/mcde/mcde_drv.c              |   6 +-
 drivers/gpu/drm/meson/meson_drv.c            |   4 +-
 drivers/gpu/drm/mxsfb/lcdif_drv.c            |   4 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c            |   4 +-
 drivers/gpu/drm/pl111/pl111_drv.c            |   4 +-
 drivers/gpu/drm/sti/sti_drv.c                |   4 +-
 drivers/gpu/drm/stm/drv.c                    |   4 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c            |   4 +-
 drivers/gpu/drm/tidss/tidss_drv.c            |   4 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c          |   4 +-
 drivers/gpu/drm/tiny/arcpgu.c                |   4 +-
 drivers/gpu/drm/tve200/tve200_drv.c          |   4 +-
 drivers/gpu/drm/vc4/vc4_drv.c                |   4 +-
 drivers/gpu/drm/xlnx/zynqmp_kms.c            |   4 +-
 include/drm/drm_fbdev_dma.h                  |  15 +
 26 files changed, 338 insertions(+), 47 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_fbdev_dma.c
 create mode 100644 include/drm/drm_fbdev_dma.h


base-commit: b21ced77ae1dbc3d8b01d3aef3c99bba7377a69b
prerequisite-patch-id: 0aa359f6144c4015c140c8a6750be19099c676fb
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: 3f204510fcbf9530d6540bd8e6128cce598988b6
prerequisite-patch-id: 75f2ebf12693f23508f00d574b2b57488723e474
prerequisite-patch-id: 718531bf5cf15716834cfaf3008ea0e2366ec927
prerequisite-patch-id: a793aa283cf41f290d970404881f24bffc48caff
prerequisite-patch-id: e74f259d1923247a74d5bf7d996afb0e6ca01883
prerequisite-patch-id: a1d12b9548110b1f5e9aa3803b21e2a7f9f8c19d
prerequisite-patch-id: 033f10da72f10d82f113a5066a3b3a7ff91d13aa
prerequisite-patch-id: 976264fafbd69d0996209a90a3d546d9be3f3779
prerequisite-patch-id: 617c74af5e16717898a23ced9c8badfff1e0ade7
prerequisite-patch-id: 5e0cfa9c81aa7ceb2cc48c5cbc9934496251fac4
prerequisite-patch-id: 13594c3cc8102960bb195bc7f572fefba8eb19d7
prerequisite-patch-id: 99d9da7e08369050d135c23d32dead811bb9cf97
prerequisite-patch-id: 833f9d8341a287961ee653b04730da57ce987b06
prerequisite-patch-id: 5d5c9caaf9489a6c2f688d632a57a0fb65fcb5f7
prerequisite-patch-id: b64758ecd64ec0c0acd96d0766ba891378c5c539
prerequisite-patch-id: 37a7d3e9fb3e4e2b7ebeac3f77da6610f12beea3
prerequisite-patch-id: 99073429dafdc98cdd31464ce28e795696a149f9
prerequisite-patch-id: c2247eca44927569cd2b6d9f370195965346adb4
-- 
2.39.2

