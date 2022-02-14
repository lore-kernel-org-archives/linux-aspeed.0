From: cgel.zte@gmail.com <cgel.zte@gmail.com>
Date: Mon, 14 Feb 2022 02:04:54 +0000
Subject: [PATCH] drm/aspeed: Use of_device_get_match_data()
Message-ID: <20220214020454.1714560-1-chi.minghao@zte.com.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 65f172807a0d..9fe1983bd9c3 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -132,7 +132,6 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	struct aspeed_gfx *priv = to_aspeed_gfx(drm);
 	struct device_node *np = pdev->dev.of_node;
 	const struct aspeed_gfx_config *config;
-	const struct of_device_id *match;
 	struct resource *res;
 	int ret;
 
@@ -141,10 +140,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	match = of_match_device(aspeed_gfx_match, &pdev->dev);
-	if (!match)
-		return -EINVAL;
-	config = match->data;
+	config = of_device_get_match_data(&pdev->dev);
 
 	priv->dac_reg = config->dac_reg;
 	priv->vga_scratch_reg = config->vga_scratch_reg;
-- 
2.25.1

