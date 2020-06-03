From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed,  3 Jun 2020 10:31:20 +0200
Subject: [PATCH v2 11/23] drm/komeda: Use GEM CMA object functions
In-Reply-To: <20200603083132.4610-1-tzimmermann@suse.de>
References: <20200603083132.4610-1-tzimmermann@suse.de>
Message-ID: <20200603083132.4610-12-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The komeda driver uses the default implementation for CMA functions; except
for the .dumb_create callback. The DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE()
macro now sets these defaults and .dumb_create in struct drm_driver. All
remaining operations are provided by CMA GEM object functions.

By using DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE() the driver now
sets .gem_create_object to drm_cma_gem_create_object_default_funcs(),
which sets CMA GEM object functions. GEM object functions implement the
rsp operations where possible. Corresponding interfaces in struct drm_driver
are cleared. Prime import now uses drm_gem_cma_prime_import_sg_table_vmap(),
which maps the imported buffer upon import. Mmap operations are performed
by drm_gem_prime_mmap(), which goes through GEM file operations. These
changes have been part of the aspeed driver for some time.

v2:
	* update for DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Emil Velikov <emil.velikov@collabora.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index 6b85d5f4caa85..1f6682032ca49 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -61,16 +61,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
 static struct drm_driver komeda_kms_driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.lastclose			= drm_fb_helper_lastclose,
-	.gem_free_object_unlocked	= drm_gem_cma_free_object,
-	.gem_vm_ops			= &drm_gem_cma_vm_ops,
-	.dumb_create			= komeda_gem_cma_dumb_create,
-	.prime_handle_to_fd		= drm_gem_prime_handle_to_fd,
-	.prime_fd_to_handle		= drm_gem_prime_fd_to_handle,
-	.gem_prime_get_sg_table		= drm_gem_cma_prime_get_sg_table,
-	.gem_prime_import_sg_table	= drm_gem_cma_prime_import_sg_table,
-	.gem_prime_vmap			= drm_gem_cma_prime_vmap,
-	.gem_prime_vunmap		= drm_gem_cma_prime_vunmap,
-	.gem_prime_mmap			= drm_gem_cma_prime_mmap,
+	DRM_GEM_CMA_DRIVER_OPS_WITH_DUMB_CREATE(komeda_gem_cma_dumb_create),
 	.fops = &komeda_cma_fops,
 	.name = "komeda",
 	.desc = "Arm Komeda Display Processor driver",
-- 
2.26.2

