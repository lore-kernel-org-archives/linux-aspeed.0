From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:43 +0200
Subject: [PATCH v3 39/43] drm/tve200: Use GEM CMA object functions
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-40-tzimmermann@suse.de>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/tve200/tve200_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 00ba9e5ce1307..f10d5bb1323ca 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -147,16 +147,12 @@ static struct drm_driver tve200_drm_driver = {
 	.major = 1,
 	.minor = 0,
 	.patchlevel = 0,
+	.gem_create_object = drm_gem_cma_create_object_default_funcs,
 	.dumb_create = drm_gem_cma_dumb_create,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops = &drm_gem_cma_vm_ops,
 
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
 	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap = drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
 	.gem_prime_mmap = drm_gem_cma_prime_mmap,
 };
 
-- 
2.26.2

