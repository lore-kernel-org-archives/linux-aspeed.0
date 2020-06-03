From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed,  3 Jun 2020 10:31:19 +0200
Subject: [PATCH v2 10/23] drm/ingenic: Use GEM CMA object functions
In-Reply-To: <20200603083132.4610-1-tzimmermann@suse.de>
References: <20200603083132.4610-1-tzimmermann@suse.de>
Message-ID: <20200603083132.4610-11-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ingenic driver uses the default implementation for CMA functions. The
DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.

Using DRM_GEM_CMA_DRIVER_OPS introduces several changes: the driver now
sets .gem_create_object to drm_cma_gem_create_object_default_funcs(),
which sets CMA GEM object functions. GEM object functions implement the
rsp operations where possible. Corresponding interfaces in struct drm_driver
are cleared. Prime import now uses drm_gem_cma_prime_import_sg_table_vmap(),
which maps the imported buffer upon import. Mmap operations are performed
by drm_gem_prime_mmap(), which goes through GEM file operations. These
changes have been part of the aspeed driver for some time.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 55b49a31729bf..16f0740df507c 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -519,18 +519,7 @@ static struct drm_driver ingenic_drm_driver_data = {
 	.patchlevel		= 0,
 
 	.fops			= &ingenic_drm_fops,
-
-	.dumb_create		= drm_gem_cma_dumb_create,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops		= &drm_gem_cma_vm_ops,
-
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS,
 
 	.irq_handler		= ingenic_drm_irq_handler,
 };
-- 
2.26.2

