From: Joel Stanley <joel@jms.id.au>
Date: Wed,  3 Apr 2019 10:49:06 +1030
Subject: [PATCH v3 0/3] drm: Add ASPEED BMC 'GFX' driver
Message-ID: <20190403001909.31637-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v3: Fix up drmP and IRQ flag, thanks Sam
v2: Address review from Noralf and Daniel, add maintainers patch

This driver is for the ASPEED BMC SoC's GFX display hardware. This
driver runs on the ARM based BMC systems, unlike the ast driver which
runs on a host CPU and is is for a PCIe graphics device that happens to
live in the BMC's silicon, but is otherwise available for use by the
BMC.

Joel Stanley (3):
  dt-bindings: gpu: Add ASPEED GFX bindings document
  drm: Add ASPEED GFX driver
  MAINTAINERS: Add ASPEED BMC GFX DRM driver entry

 .../devicetree/bindings/gpu/aspeed-gfx.txt    |  41 +++
 MAINTAINERS                                   |   8 +
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/aspeed/Kconfig                |  14 +
 drivers/gpu/drm/aspeed/Makefile               |   3 +
 drivers/gpu/drm/aspeed/aspeed_gfx.h           | 104 +++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c      | 241 ++++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       | 269 ++++++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c       |  42 +++
 10 files changed, 725 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
 create mode 100644 drivers/gpu/drm/aspeed/Kconfig
 create mode 100644 drivers/gpu/drm/aspeed/Makefile
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx.h
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_out.c

-- 
2.20.1

