From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 22 May 2020 15:52:44 +0200
Subject: [PATCH 19/21] drm/tilcdc: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-1-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
Message-ID: <20200522135246.10134-20-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The tilcdc driver uses the default implementation for CMA functions. The
DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
All remaining operations are provided by CMA GEM object functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index a5e9ee4c7fbf4..0d74a64432633 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -496,18 +496,7 @@ DEFINE_DRM_GEM_CMA_FOPS(fops);
 static struct drm_driver tilcdc_driver = {
 	.driver_features    = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.irq_handler        = tilcdc_irq,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_print_info     = drm_gem_cma_print_info,
-	.gem_vm_ops         = &drm_gem_cma_vm_ops,
-	.dumb_create        = drm_gem_cma_dumb_create,
-
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init       = tilcdc_debugfs_init,
 #endif
-- 
2.26.2

