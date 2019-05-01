From: Timothy Pearson <tpearson@raptorengineering.com>
Date: Wed, 1 May 2019 17:49:22 -0500 (CDT)
Subject: [PATCH 1/3] drm/aspeed: Preserve DVO configuration bits during
 initialization
Message-ID: <1681003008.3393892.1556750962226.JavaMail.zimbra@raptorengineeringinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

GFX064 contains DVO enable and mode bits.  These are hardware specific, configured
via the pinmux from the DT, and should not be cleared during startup.

Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 713a3975852b..1a7a9a000e2e 100644
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
+	reg = readl(priv->base + CRT_CTRL2) & 0xc0;
+	writel(reg, priv->base + CRT_CTRL2);
 
 	aspeed_gfx_setup_mode_config(drm);
 
-- 
2.11.0

