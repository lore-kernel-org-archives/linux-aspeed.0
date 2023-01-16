From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 16 Jan 2023 14:12:22 +0100
Subject: [PATCH 09/22] drm/i2c/ch7006: Remove unnecessary include statements for drm_crtc_helper.h
In-Reply-To: <20230116131235.18917-1-tzimmermann@suse.de>
References: <20230116131235.18917-1-tzimmermann@suse.de>
Message-ID: <20230116131235.18917-10-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several source files include drm_crtc_helper.h without needing it or
only to get its transitive include statements; leading to unnecessary
compile-time dependencies.

Directly include required headers and drop drm_crtc_helper.h where
possible.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/i2c/ch7006_drv.c  | 2 ++
 drivers/gpu/drm/i2c/ch7006_priv.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index 923389f22020..521bdf656cca 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -26,6 +26,8 @@
 
 #include <linux/module.h>
 
+#include <drm/drm_crtc_helper.h>
+
 #include "ch7006_priv.h"
 
 /* DRM encoder functions */
diff --git a/drivers/gpu/drm/i2c/ch7006_priv.h b/drivers/gpu/drm/i2c/ch7006_priv.h
index 986b04599906..052bdc48a339 100644
--- a/drivers/gpu/drm/i2c/ch7006_priv.h
+++ b/drivers/gpu/drm/i2c/ch7006_priv.h
@@ -27,7 +27,6 @@
 #ifndef __DRM_I2C_CH7006_PRIV_H__
 #define __DRM_I2C_CH7006_PRIV_H__
 
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_encoder_slave.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/i2c/ch7006.h>
-- 
2.39.0

