From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 22 May 2020 15:52:38 +0200
Subject: [PATCH 13/21] drm/meson: Use GEM CMA object functions
In-Reply-To: <20200522135246.10134-1-tzimmermann@suse.de>
References: <20200522135246.10134-1-tzimmermann@suse.de>
Message-ID: <20200522135246.10134-14-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The meson driver uses the default implementation for CMA functions; except
for the .dumb_create callback. The __DRM_GEM_CMA_DRIVER_OPS macro now sets
these defaults and .dumb_create in struct drm_driver. All remaining
operations are provided by CMA GEM object functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/meson/meson_drv.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 4c5aafcec7991..2fe88f2b2fb55 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -96,19 +96,8 @@ static struct drm_driver meson_driver = {
 	/* IRQ */
 	.irq_handler		= meson_irq,
 
-	/* PRIME Ops */
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
-
-	/* GEM Ops */
-	.dumb_create		= meson_dumb_create,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops		= &drm_gem_cma_vm_ops,
+	/* CMA Ops */
+	__DRM_GEM_CMA_DRIVER_OPS(meson_dumb_create),
 
 	/* Misc */
 	.fops			= &fops,
-- 
2.26.2

