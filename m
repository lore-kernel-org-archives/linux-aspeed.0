From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 22 May 2020 15:52:36 +0200
Subject: [PATCH 11/21] drm/malidp: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-1-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
Message-ID: <20200522135246.10134-12-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The malidp driver uses the default implementation for CMA functions; except
for the .dumb_create callback. The __DRM_GEM_CMA_DRIVER_OPS macro now sets
these defaults and .dumb_create in struct drm_driver. All remaining
operations are provided by CMA GEM object functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/arm/malidp_drv.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index def8c9ffafcaf..92e0bca6aa2f4 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -563,16 +563,7 @@ static void malidp_debugfs_init(struct drm_minor *minor)
 
 static struct drm_driver malidp_driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops = &drm_gem_cma_vm_ops,
-	.dumb_create = malidp_dumb_create,
-	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap = drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap = drm_gem_cma_prime_mmap,
+	__DRM_GEM_CMA_DRIVER_OPS(malidp_dumb_create),
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init = malidp_debugfs_init,
 #endif
-- 
2.26.2

