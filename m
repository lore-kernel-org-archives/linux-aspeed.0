From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:26 +0200
Subject: [PATCH v3 22/43] drm/malidp: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-23-tzimmermann@suse.de>
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
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index a56a93fc7bc2e..cbd35fd305803 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -563,12 +563,7 @@ static void malidp_debugfs_init(struct drm_minor *minor)
 
 static struct drm_driver malidp_driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
-	.gem_create_object = drm_gem_cma_create_object_default_funcs,
-	.dumb_create = malidp_dumb_create,
-	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_mmap = drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(malidp_dumb_create),
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init = malidp_debugfs_init,
 #endif
-- 
2.26.2

