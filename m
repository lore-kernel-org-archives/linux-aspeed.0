From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 22 May 2020 15:52:29 +0200
Subject: [PATCH 04/21] drm/aspeed: Set driver CMA functions with
 DRM_GEM_CMA_DRIVER_OPS
In-Reply-To: <20200522135246.10134-1-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
Message-ID: <20200522135246.10134-5-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DRM_GEM_CMA_DRIVER_OPS sets the functions in struct drm_driver
to their defaults. No functional changes are made.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 6b27242b9ee3c..1167ff78e24a3 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -188,12 +188,7 @@ DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver aspeed_gfx_driver = {
 	.driver_features        = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
-	.gem_create_object	= drm_cma_gem_create_object_default_funcs,
-	.dumb_create		= drm_gem_cma_dumb_create,
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_mmap		= drm_gem_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.fops = &fops,
 	.name = "aspeed-gfx-drm",
 	.desc = "ASPEED GFX DRM",
-- 
2.26.2

