From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed,  3 Jun 2020 10:31:09 +0200
Subject: [PATCH v2 00/23] drm: Convert most CMA-based drivers to GEM object
 functions
Message-ID: <20200603083132.4610-1-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Most of the CMA-based drivers use the default implementation for the
callbacks in struct drm_driver. With this patch, these interfaces are
initialized with a common helper macro and GEM object functions replace
several deprecated interfaces.

The first patch updates the existing macro to similar naming as with
SHMEM and adds a helper for drivers that override the default implementation
for .dumb_create(). The remaining patches convert the drivers. The aspeed
driver already uses GEM object functions and only changes to the initializer
macro. The kirin driver also changes to the default dumb_create function.

I don't have much of the hardware, so it's only compile-tested on aarch64,
arm and x86-64 only. Several patches have Tested-by tags. The aspeed driver
has used the implemented scheme for a while.

v2:
	* add more detailed commit messages (Laurent, Sam)
	* use default .dumb_create implementation in kirin (Emil)
	* fix zte build error (Sam, Emil)
	* introduce DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE (everyone)

Thomas Zimmermann (23):
  drm/cma-helper: Rework DRM_GEM_CMA_VMAP_DRIVER_OPS macro
  drm/arc: Use GEM CMA object functions
  drm/arm: Use GEM CMA object functions
  drm/aspeed: Set driver CMA functions with DRM_GEM_CMA_DRIVER_OPS
  drm/atmel-hlcdc: Use GEM CMA object functions
  drm/fsl-dcu: Use GEM CMA object functions
  drm/hisilicon/kirin: Set .dumb_create to drm_gem_cma_dumb_create()
  drm/hisilicon/kirin: Use GEM CMA object functions
  drm/imx: Use GEM CMA object functions
  drm/ingenic: Use GEM CMA object functions
  drm/komeda: Use GEM CMA object functions
  drm/malidp: Use GEM CMA object functions
  drm/mcde: Use GEM CMA object functions
  drm/meson: Use GEM CMA object functions
  drm/mxsfb: Use GEM CMA object functions
  drm/rcar-du: Use GEM CMA object functions
  drm/shmobile: Use GEM CMA object functions
  drm/stm: Use GEM CMA object functions
  drm/sti: Use GEM CMA object functions
  drm/tilcdc: Use GEM CMA object functions
  drm/tv200: Use GEM CMA object functions
  drm/zte: Use GEM CMA object functions
  drm: Remove struct drm_driver.gem_print_info

 drivers/gpu/drm/arc/arcpgu_drv.c              | 12 +-------
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 11 +------
 drivers/gpu/drm/arm/hdlcd_drv.c               | 12 +-------
 drivers/gpu/drm/arm/malidp_drv.c              | 11 +------
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |  7 +----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 11 +------
 drivers/gpu/drm/drm_gem.c                     |  2 --
 drivers/gpu/drm/drm_gem_cma_helper.c          |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     | 11 +------
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 12 +-------
 drivers/gpu/drm/imx/imx-drm-core.c            | 12 +-------
 drivers/gpu/drm/ingenic/ingenic-drm.c         | 13 +-------
 drivers/gpu/drm/mcde/mcde_drv.c               | 12 +-------
 drivers/gpu/drm/meson/meson_drv.c             | 15 ++--------
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             | 11 +------
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         | 11 +------
 drivers/gpu/drm/shmobile/shmob_drm_drv.c      | 11 +------
 drivers/gpu/drm/sti/sti_drv.c                 | 12 +-------
 drivers/gpu/drm/stm/drv.c                     | 11 +------
 drivers/gpu/drm/sun4i/sun4i_drv.c             |  3 +-
 drivers/gpu/drm/tidss/tidss_drv.c             |  2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           | 13 +-------
 drivers/gpu/drm/tiny/hx8357d.c                |  2 +-
 drivers/gpu/drm/tiny/ili9225.c                |  2 +-
 drivers/gpu/drm/tiny/ili9341.c                |  2 +-
 drivers/gpu/drm/tiny/ili9486.c                |  2 +-
 drivers/gpu/drm/tiny/mi0283qt.c               |  2 +-
 drivers/gpu/drm/tiny/repaper.c                |  2 +-
 drivers/gpu/drm/tiny/st7586.c                 |  2 +-
 drivers/gpu/drm/tiny/st7735r.c                |  2 +-
 drivers/gpu/drm/tve200/tve200_drv.c           | 12 +-------
 drivers/gpu/drm/zte/zx_drm_drv.c              | 11 +------
 include/drm/drm_drv.h                         | 17 -----------
 include/drm/drm_gem_cma_helper.h              | 30 ++++++++++++++++---
 34 files changed, 58 insertions(+), 245 deletions(-)

--
2.26.2

