From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 13 Mar 2023 16:51:22 +0100
Subject: [PATCH v2 09/25] drm/kmb: Use GEM DMA fbdev emulation
In-Reply-To: <20230313155138.20584-1-tzimmermann@suse.de>
References: <20230313155138.20584-1-tzimmermann@suse.de>
Message-ID: <20230313155138.20584-10-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the fbdev emulation that is optimized for DMA helpers. Avoids
possible shadow buffering and makes the code simpler.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index d29c678f6c91..24035b53441c 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -15,7 +15,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_generic.h>
+#include <drm/drm_fbdev_dma.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_module.h>
@@ -562,7 +562,7 @@ static int kmb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_register;
 
-	drm_fbdev_generic_setup(&kmb->drm, 0);
+	drm_fbdev_dma_setup(&kmb->drm, 0);
 
 	return 0;
 
-- 
2.39.2

