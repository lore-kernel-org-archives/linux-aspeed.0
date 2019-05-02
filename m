From: Timothy Pearson <tpearson@raptorengineering.com>
Date: Thu, 2 May 2019 16:51:15 -0500 (CDT)
Subject: [PATCH 1/2] [v2] drm/aspeed: Preserve DVO configuration bits during
 initialization
Message-ID: <1731023470.3553122.1556833875705.JavaMail.zimbra@raptorengineeringinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

GFX064 contains DVO enable and mode bits.  These are hardware specific, configured
via the pinmux from the DT, and should not be cleared during startup.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx.h     | 3 +++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
index b7a986e49177..b34c97613aaf 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright 2018 IBM Corporation
+// Copyright 2019 Raptor Engineering, LLC
 
 #include <drm/drm_device.h>
 #include <drm/drm_simple_kms_helper.h>
@@ -73,6 +74,8 @@ int aspeed_gfx_create_output(struct drm_device *drm);
 
 /* CTRL2 */
 #define CRT_CTRL_DAC_EN			BIT(0)
+#define CRT_CTRL_DVO_MODE		BIT(6)
+#define CRT_CTRL_DVO_EN			BIT(7)
 #define CRT_CTRL_VBLANK_LINE(x)		(((x) << 20) & CRT_CTRL_VBLANK_LINE_MASK)
 #define CRT_CTRL_VBLANK_LINE_MASK	GENMASK(20, 31)
 
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 713a3975852b..7e9072fd0ef0 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -98,6 +98,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	struct aspeed_gfx *priv;
 	struct resource *res;
 	int ret;
+	u32 reg;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -146,7 +147,9 @@ static int aspeed_gfx_load(struct drm_device *drm)
 
 	/* Sanitize control registers */
 	writel(0, priv->base + CRT_CTRL1);
-	writel(0, priv->base + CRT_CTRL2);
+	/* Preserve CRT_CTRL2[7:6] (DVO configuration) */
+	reg = readl(priv->base + CRT_CTRL2) & (CRT_CTRL_DVO_MODE | CRT_CTRL_DVO_EN);
+	writel(reg, priv->base + CRT_CTRL2);
 
 	aspeed_gfx_setup_mode_config(drm);
 
-- 
2.11.0
