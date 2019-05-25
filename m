From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 25 May 2019 22:41:53 +0800
Subject: [PATCH -next] EDAC: aspeed: Remove set but not used variable 'np'
Message-ID: <20190525144153.2028-1-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/edac/aspeed_edac.c: In function aspeed_probe:
drivers/edac/aspeed_edac.c:284:22: warning: variable np set but not used [-Wunused-but-set-variable]

It is never used and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/edac/aspeed_edac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 11833c0a5d07..5634437bb39d 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -281,15 +281,11 @@ static int aspeed_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
-	struct device_node *np;
 	struct resource *res;
 	void __iomem *regs;
 	u32 reg04;
 	int rc;
 
-	/* setup regmap */
-	np = dev->of_node;
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENOENT;
-- 
2.17.1


