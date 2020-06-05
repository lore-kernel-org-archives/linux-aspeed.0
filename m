From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri,  5 Jun 2020 09:32:24 +0200
Subject: [PATCH v3 20/43] drm/komeda: Set GEM CMA functions with
 DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE
In-Reply-To: <20200605073247.4057-1-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
Message-ID: <20200605073247.4057-21-tzimmermann@suse.de>
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
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index af24dca1cab63..1f6682032ca49 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -61,12 +61,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
 static struct drm_driver komeda_kms_driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.lastclose			= drm_fb_helper_lastclose,
-	.gem_create_object		= drm_gem_cma_create_object_default_funcs,
-	.dumb_create			= komeda_gem_cma_dumb_create,
-	.prime_handle_to_fd		= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle		= drm_gem_prime_fd_to_handle,
-	.gem_prime_import_sg_table	= drm_gem_cma_prime_import_sg_table,
-	.gem_prime_mmap			= drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(komeda_gem_cma_dumb_create),
 	.fops = &komeda_cma_fops,
 	.name = "komeda",
 	.desc = "Arm Komeda Display Processor driver",
-- 
2.26.2

