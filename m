From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:10 +0200
Subject: [PATCH v3 06/43] drm/arm: Use GEM CMA object functions
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-7-tzimmermann@suse.de>
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
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 194419f47c5e5..dd4db48ff6361 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -240,16 +240,11 @@ static struct drm_driver hdlcd_driver = {
 	.irq_preinstall = hdlcd_irq_preinstall,
 	.irq_postinstall = hdlcd_irq_postinstall,
 	.irq_uninstall = hdlcd_irq_uninstall,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_print_info = drm_gem_cma_print_info,
-	.gem_vm_ops = &drm_gem_cma_vm_ops,
+	.gem_create_object = drm_gem_cma_create_object_default_funcs,
 	.dumb_create = drm_gem_cma_dumb_create,
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table = drm_gem_cma_prime_get_sg_table,
 	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap = drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
 	.gem_prime_mmap = drm_gem_cma_prime_mmap,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init = hdlcd_debugfs_init,
-- 
2.26.2

