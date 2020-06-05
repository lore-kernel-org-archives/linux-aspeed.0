From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:44 +0200
Subject: [PATCH v3 40/43] drm/tve200: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-41-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DRM_GEM_CMA_DRIVER_OPS sets the functions in struct drm_driver
to their defaults. No functional changes are made.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/tve200/tve200_drv.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index f10d5bb1323ca..c3aa39bd38ecd 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -147,13 +147,7 @@ static struct drm_driver tve200_drm_driver = {
 	.major = 1,
 	.minor = 0,
 	.patchlevel = 0,
-	.gem_create_object = drm_gem_cma_create_object_default_funcs,
-	.dumb_create = drm_gem_cma_dumb_create,
-
-	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_mmap = drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS,
 };
 
 static int tve200_probe(struct platform_device *pdev)
-- 
2.26.2

