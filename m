From: tommy-huang <tommy_huang@aspeedtech.com>
Date: Tue, 28 Sep 2021 10:57:02 +0800
Subject: [PATCH 5/6] HACK: drm/aspeed: Paramterise modes
In-Reply-To: <20210928025703.10909-1-tommy_huang@aspeedtech.com>
References: <20210928025703.10909-1-tommy_huang@aspeedtech.com>
Message-ID: <20210928025703.10909-6-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Joel Stanley <joel@jms.id.au>

The AST2600 will run at 1024x868.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 33095477cc03..11a44b08bd3f 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -99,7 +99,7 @@ static const struct drm_mode_config_funcs aspeed_gfx_mode_config_funcs = {
 	.atomic_commit		= drm_atomic_helper_commit,
 };
 
-static int aspeed_gfx_setup_mode_config(struct drm_device *drm)
+static int aspeed_gfx_setup_mode_config(struct drm_device *drm, int width, int height)
 {
 	int ret;
 
@@ -109,8 +109,8 @@ static int aspeed_gfx_setup_mode_config(struct drm_device *drm)
 
 	drm->mode_config.min_width = 0;
 	drm->mode_config.min_height = 0;
-	drm->mode_config.max_width = 800;
-	drm->mode_config.max_height = 600;
+	drm->mode_config.max_width = width;
+	drm->mode_config.max_height = height;
 	drm->mode_config.funcs = &aspeed_gfx_mode_config_funcs;
 
 	return ret;
@@ -201,7 +201,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	writel(0, priv->base + CRT_CTRL1);
 	writel(0, priv->base + CRT_CTRL2);
 
-	ret = aspeed_gfx_setup_mode_config(drm);
+	ret = aspeed_gfx_setup_mode_config(drm, 800, 600);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1

