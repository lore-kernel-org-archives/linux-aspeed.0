From: Cai Huoqing <caihuoqing@baidu.com>
Date: Tue, 31 Aug 2021 15:44:49 +0800
Subject: [PATCH] drm/aspeed: Make use of the helper function
 devm_platform_ioremap_resource()
Message-ID: <20210831074449.563-1-caihuoqing@baidu.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index b53fee6f1c17..de65da467de7 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -133,11 +133,9 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	struct device_node *np = pdev->dev.of_node;
 	const struct aspeed_gfx_config *config;
 	const struct of_device_id *match;
-	struct resource *res;
 	int ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(drm->dev, res);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.1

