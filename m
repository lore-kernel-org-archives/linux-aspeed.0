From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 13 Mar 2023 16:51:17 +0100
Subject: [PATCH v2 04/25] drm/aspeed: Use GEM DMA fbdev emulation
In-Reply-To: <20230313155138.20584-1-tzimmermann@suse.de>
References: <20230313155138.20584-1-tzimmermann@suse.de>
Message-ID: <20230313155138.20584-5-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the fbdev emulation that is optimized for DMA helpers. Avoids
possible shadow buffering and makes the code simpler.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index ecfb060d2557..c8c7f8215155 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -15,7 +15,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_device.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_module.h>
@@ -341,7 +341,7 @@ static int aspeed_gfx_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_unload;
 
-	drm_fbdev_generic_setup(&priv->drm, 32);
+	drm_fbdev_dma_setup(&priv->drm, 32);
 	return 0;
 
 err_unload:
-- 
2.39.2

