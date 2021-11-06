From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Sat,  6 Nov 2021 20:35:07 +0100
Subject: [RESEND PATCH v2 0/2] drm: Small CMA cleanups
Message-ID: <20211106193509.17472-1-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

(no changes; resending for kernel CI)

Remove CMA dependencies from MIPI-DBI and replace the config
symbol DRM_KMS_CMA_HELPER with DRM_KMS_HELPER. This allows to
link drm_fb_cma_helper.o into a helper library.

Thomas Zimmermann (2):
  drm/mipi-dbi: Remove dependency on GEM CMA helper library
  drm: Remove CONFIG_DRM_KMS_CMA_HELPER option

 drivers/gpu/drm/Kconfig                 |  7 -----
 drivers/gpu/drm/Makefile                |  2 +-
 drivers/gpu/drm/arm/Kconfig             |  2 --
 drivers/gpu/drm/arm/display/Kconfig     |  1 -
 drivers/gpu/drm/aspeed/Kconfig          |  1 -
 drivers/gpu/drm/atmel-hlcdc/Kconfig     |  1 -
 drivers/gpu/drm/drm_mipi_dbi.c          | 34 ++++++++++++++++++-------
 drivers/gpu/drm/fsl-dcu/Kconfig         |  1 -
 drivers/gpu/drm/hisilicon/kirin/Kconfig |  1 -
 drivers/gpu/drm/imx/Kconfig             |  2 +-
 drivers/gpu/drm/imx/dcss/Kconfig        |  2 +-
 drivers/gpu/drm/ingenic/Kconfig         |  1 -
 drivers/gpu/drm/kmb/Kconfig             |  1 -
 drivers/gpu/drm/mcde/Kconfig            |  1 -
 drivers/gpu/drm/meson/Kconfig           |  1 -
 drivers/gpu/drm/mxsfb/Kconfig           |  2 +-
 drivers/gpu/drm/panel/Kconfig           |  2 +-
 drivers/gpu/drm/pl111/Kconfig           |  1 -
 drivers/gpu/drm/rcar-du/Kconfig         |  1 -
 drivers/gpu/drm/shmobile/Kconfig        |  1 -
 drivers/gpu/drm/sti/Kconfig             |  1 -
 drivers/gpu/drm/stm/Kconfig             |  1 -
 drivers/gpu/drm/sun4i/Kconfig           |  1 -
 drivers/gpu/drm/tidss/Kconfig           |  1 -
 drivers/gpu/drm/tilcdc/Kconfig          |  1 -
 drivers/gpu/drm/tiny/Kconfig            | 20 +++++++--------
 drivers/gpu/drm/tve200/Kconfig          |  1 -
 drivers/gpu/drm/vc4/Kconfig             |  1 -
 drivers/gpu/drm/xlnx/Kconfig            |  1 -
 29 files changed, 40 insertions(+), 53 deletions(-)


base-commit: c2502072fe2bd823d59749dca7fde064b345e61c
--
2.33.1

