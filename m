From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Mar 2019 16:13:14 +1030
Subject: [PATCH 0/2] drm: Add ASPEED BMC 'GFX' driver
Message-ID: <20190328054316.17939-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This driver is for the ASPEED BMC SoC's GFX display hardware. This
driver runs on the ARM based BMC systems, unlike the ast driver which
runs on a host CPU and is is for a PCIe graphics device that happens to
live in the BMC's silicon, but is otherwise available for use by the
BMC.

I submitted a RFC about a year ago.

 https://patchwork.kernel.org/patch/10339605/

I've fixed all of the issues I had in the RFC, and made the cleanups
that Eric suggested in that review. This version is based on
next-20190327.

Joel Stanley (2):
  dt-bindings: gpu: Add ASPEED GFX bindings document
  drm: Add ASPEED GFX driver

 .../devicetree/bindings/gpu/aspeed-gfx.txt    |  41 +++
 drivers/gpu/drm/Kconfig                       |   2 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/aspeed/Kconfig                |  15 +
 drivers/gpu/drm/aspeed/Makefile               |   3 +
 drivers/gpu/drm/aspeed/aspeed_gfx.h           | 104 +++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c      | 248 ++++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       | 269 ++++++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_out.c       |  49 ++++
 9 files changed, 732 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
 create mode 100644 drivers/gpu/drm/aspeed/Kconfig
 create mode 100644 drivers/gpu/drm/aspeed/Makefile
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx.h
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
 create mode 100644 drivers/gpu/drm/aspeed/aspeed_gfx_out.c

-- 
2.20.1

