From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Thu,  3 Nov 2022 16:14:32 +0100
Subject: [PATCH v3 09/23] drm/panel-ili9341: Include <linux/backlight.h>
In-Reply-To: <20221103151446.2638-1-tzimmermann@suse.de>
References: <20221103151446.2638-1-tzimmermann@suse.de>
Message-ID: <20221103151446.2638-10-tzimmermann@suse.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Include <linux/backlight.h> for devm_of_find_backlight().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 39dc40cf681f0..b59472c29a40d 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -18,6 +18,7 @@
  * Copyright 2018 David Lechner <david@lechnology.com>
  */
 
+#include <linux/backlight.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
-- 
2.38.0

