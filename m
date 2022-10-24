From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 24 Oct 2022 13:19:33 +0200
Subject: [PATCH v2 01/21] drm/komeda: Don't set struct drm_driver.lastclose
In-Reply-To: <20221024111953.24307-1-tzimmermann@suse.de>
References: <20221024111953.24307-1-tzimmermann@suse.de>
Message-ID: <20221024111953.24307-2-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Don't set struct drm_driver.lastclose. It's used to restore the
fbdev console. But as komeda uses generic fbdev emulation, the
console is being restored by the DRM client helpers already. See
the call to drm_client_dev_restore() in drm_lastclose().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index 451746ebbe713..62dc64550793e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -10,7 +10,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_managed.h>
@@ -59,7 +58,6 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
 
 static const struct drm_driver komeda_kms_driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
-	.lastclose			= drm_fb_helper_lastclose,
 	DRM_GEM_DMA_DRIVER_OPS_WITH_DUMB_CREATE(komeda_gem_dma_dumb_create),
 	.fops = &komeda_cma_fops,
 	.name = "komeda",
-- 
2.38.0

