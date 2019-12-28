From: Yangtao Li <tiny.windzz@gmail.com>
Date: Sat, 28 Dec 2019 19:06:31 +0000
Subject: [PATCH] fsi: aspeed: convert to devm_platform_ioremap_resource
Message-ID: <20191228190631.26777-1-tiny.windzz@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/fsi/fsi-master-aspeed.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f49742b310c2..edd0b287e7b7 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -422,7 +422,6 @@ static int aspeed_master_init(struct fsi_master_aspeed *aspeed)
 static int fsi_master_aspeed_probe(struct platform_device *pdev)
 {
 	struct fsi_master_aspeed *aspeed;
-	struct resource *res;
 	int rc, links, reg;
 	__be32 raw;
 
@@ -432,8 +431,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 
 	aspeed->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	aspeed->base = devm_ioremap_resource(&pdev->dev, res);
+	aspeed->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(aspeed->base))
 		return PTR_ERR(aspeed->base);
 
-- 
2.17.1

