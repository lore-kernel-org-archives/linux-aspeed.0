From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 22 May 2020 15:52:31 +0200
Subject: [PATCH 06/21] drm/fsl-dcu: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-1-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
Message-ID: <20200522135246.10134-7-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The fsl-dcu driver uses the default implementation for CMA functions. The
DRM_GEM_CMA_DRIVER_OPS macro now sets these defaults in struct drm_driver.
All remaining operations are provided by CMA GEM object functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index f15d2e7967a3e..abbc1ddbf27f0 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -141,16 +141,7 @@ static struct drm_driver fsl_dcu_drm_driver = {
 	.irq_handler		= fsl_dcu_drm_irq,
 	.irq_preinstall		= fsl_dcu_irq_uninstall,
 	.irq_uninstall		= fsl_dcu_irq_uninstall,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops		= &drm_gem_cma_vm_ops,
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
-	.dumb_create		= drm_gem_cma_dumb_create,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.fops			= &fsl_dcu_drm_fops,
 	.name			= "fsl-dcu-drm",
 	.desc			= "Freescale DCU DRM",
-- 
2.26.2

