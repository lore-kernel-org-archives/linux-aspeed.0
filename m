From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:35 +0200
Subject: [PATCH v3 31/43] drm/shmobile: Use GEM CMA object functions
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-32-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Create GEM objects with drm_gem_cma_create_object_default_funcs(), which
allocates the object and sets CMA's default object functions. Corresponding
callbacks in struct drm_driver are cleared. No functional changes are made.

Driver and object-function instances use the same callback functions, with
the exception of vunmap. The implementation of vunmap is empty and left out
in CMA's default object functions.

v3:
	* convert to DRIVER_OPS macro in a separate patch

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/shmobile/shmob_drm_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
index ae9d6b8d3ca87..e209610d4b8a1 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
@@ -131,14 +131,10 @@ DEFINE_DRM_GEM_CMA_FOPS(shmob_drm_fops);
 static struct drm_driver shmob_drm_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET,
 	.irq_handler		= shmob_drm_irq,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops		= &drm_gem_cma_vm_ops,
+	.gem_create_object	= drm_gem_cma_create_object_default_funcs,
 	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
 	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
 	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
 	.dumb_create		= drm_gem_cma_dumb_create,
 	.fops			= &shmob_drm_fops,
-- 
2.26.2

