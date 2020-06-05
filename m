From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:38 +0200
Subject: [PATCH v3 34/43] drm/stm: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-35-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE sets the functions in
struct drm_driver to their defaults. No functional changes are
made.

v2:
	* update for DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/stm/drv.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 441c5b2af9698..411103f013e25 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -62,12 +62,7 @@ static struct drm_driver drv_driver = {
 	.minor = 0,
 	.patchlevel = 0,
 	.fops = &drv_driver_fops,
-	.gem_create_object = drm_gem_cma_create_object_default_funcs,
-	.dumb_create = stm_gem_cma_dumb_create,
-	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
-	.gem_prime_import_sg_table = drm_gem_cma_prime_import_sg_table,
-	.gem_prime_mmap = drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(stm_gem_cma_dumb_create),
 };
 
 static int drv_load(struct drm_device *ddev)
-- 
2.26.2

