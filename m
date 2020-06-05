From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:18 +0200
Subject: [PATCH v3 14/43] drm/hisilicon/kirin: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-15-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DRM_GEM_CMA_DRIVER_OPS sets the functions in struct drm_driver
to their defaults. No functional changes are made.

v2:
	* use DRM_GEM_CMA_DRIVER_OPS

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
Cc: Xu YiPing <xuyiping@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index a550e464153b6..e1108c1735ad0 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -921,13 +921,7 @@ DEFINE_DRM_GEM_CMA_FOPS(ade_fops);
 static struct drm_driver ade_driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops = &ade_fops,
-	.gem_create_object = drm_gem_cma_create_object_default_funcs,
-	.dumb_create = drm_gem_cma_dumb_create,
-	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_mmap = drm_gem_cma_prime_mmap,
-
+	DRM_GEM_CMA_DRIVER_OPS,
 	.name = "kirin",
 	.desc = "Hisilicon Kirin620 SoC DRM Driver",
 	.date = "20150718",
-- 
2.26.2

