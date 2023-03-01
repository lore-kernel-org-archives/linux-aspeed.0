From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed,  1 Mar 2023 16:30:59 +0100
Subject: [PATCH 20/22] drm/tve200: Use GEM DMA fbdev emulation
In-Reply-To: <20230301153101.4282-1-tzimmermann@suse.de>
References: <20230301153101.4282-1-tzimmermann@suse.de>
Message-ID: <20230301153101.4282-21-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the fbdev emulation that is optimized for DMA helpers. Avoids
possible shadow buffering and makes the code simpler.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tve200/tve200_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 0d05c386d303..abd557332b28 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -40,7 +40,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_module.h>
@@ -227,7 +227,7 @@ static int tve200_probe(struct platform_device *pdev)
 	 * Passing in 16 here will make the RGB565 mode the default
 	 * Passing in 32 will use XRGB8888 mode
 	 */
-	drm_fbdev_generic_setup(drm, 16);
+	drm_fbdev_dma_setup(drm, 16);
 
 	return 0;
 
-- 
2.39.2

