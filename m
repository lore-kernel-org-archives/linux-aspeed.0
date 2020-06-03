From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed,  3 Jun 2020 10:31:18 +0200
Subject: [PATCH v2 09/23] drm/imx: Use GEM CMA object functions
In-Reply-To: <20200603083132.4610-1-tzimmermann@suse.de>
References: <20200603083132.4610-1-tzimmermann@suse.de>
Message-ID: <20200603083132.4610-10-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The imx driver uses the default implementation for CMA functions. The
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
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index 2e38f1a5cf8da..36037b2e65647 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -146,17 +146,7 @@ static const struct drm_ioctl_desc imx_drm_ioctls[] = {
 
 static struct drm_driver imx_drm_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
-	.gem_free_object_unlocked = drm_gem_cma_free_object,
-	.gem_vm_ops		= &drm_gem_cma_vm_ops,
-	.dumb_create		= drm_gem_cma_dumb_create,
-
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table	= drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap		= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap	= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.ioctls			= imx_drm_ioctls,
 	.num_ioctls		= ARRAY_SIZE(imx_drm_ioctls),
 	.fops			= &imx_drm_driver_fops,
-- 
2.26.2

