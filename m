From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:30 +0200
Subject: [PATCH v3 26/43] drm/meson: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-27-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE sets the functions in
struct drm_driver to their defaults. No functional changes are
made.

v2:
	* update for DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 036af6e69bb78..8b9c8dd788c41 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -96,15 +96,8 @@ static struct drm_driver meson_driver = {
 	/* IRQ */
 	.irq_handler		= meson_irq,
 
-	/* PRIME Ops */
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
-
-	/* GEM Ops */
-	.gem_create_object	= drm_gem_cma_create_object_default_funcs,
-	.dumb_create		= meson_dumb_create,
+	/* CMA Ops */
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(meson_dumb_create),
 
 	/* Misc */
 	.fops			= &fops,
-- 
2.26.2

