From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 13 Mar 2023 16:51:23 +0100
Subject: [PATCH v2 10/25] drm/logicvc: Use GEM DMA fbdev emulation
In-Reply-To: <20230313155138.20584-1-tzimmermann@suse.de>
References: <20230313155138.20584-1-tzimmermann@suse.de>
Message-ID: <20230313155138.20584-11-tzimmermann@suse.de>
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
 drivers/gpu/drm/logicvc/logicvc_drm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index 2fb23697740a..c35c453fd025 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -17,7 +17,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_print.h>
 
@@ -449,7 +449,7 @@ static int logicvc_drm_probe(struct platform_device *pdev)
 		preferred_bpp = 32;
 		break;
 	}
-	drm_fbdev_generic_setup(drm_dev, preferred_bpp);
+	drm_fbdev_dma_setup(drm_dev, preferred_bpp);
 
 	return 0;
 
-- 
2.39.2

