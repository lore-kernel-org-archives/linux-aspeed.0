From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:20 +0200
Subject: [PATCH v3 16/43] drm/imx: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-17-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DRM_GEM_CMA_DRIVER_OPS sets the functions in struct drm_driver
to their defaults. No functional changes are made.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index f13e7cd9b7d16..36037b2e65647 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -146,13 +146,7 @@ static const struct drm_ioctl_desc imx_drm_ioctls[] = {
 
 static struct drm_driver imx_drm_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
-	.gem_create_object	= drm_gem_cma_create_object_default_funcs,
-	.dumb_create		= drm_gem_cma_dumb_create,
-
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_mmap		= drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS,
 	.ioctls			= imx_drm_ioctls,
 	.num_ioctls		= ARRAY_SIZE(imx_drm_ioctls),
 	.fops			= &imx_drm_driver_fops,
-- 
2.26.2

