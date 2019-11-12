From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 12 Nov 2019 11:47:44 +0800
Subject: [PATCH v3 -next] fsi: aspeed: Fix aspeed device free
In-Reply-To: <20191109033634.30544-1-yuehaibing@huawei.com>
References: <20191109033634.30544-1-yuehaibing@huawei.com>
Message-ID: <20191112034744.10180-1-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'aspeed' is allocted by devm_kfree(), it should not be kfree().
In fact it will be freed while the device released.
Also we grap reference after fsi_master_register() success,
so should put it in fsi_master_aspeed_remove().

Fixes: 1edac1269c02 ("fsi: Add ast2600 master driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v3: remove unneeded release() and put last reference
v2: fix log typos
---
 drivers/fsi/fsi-master-aspeed.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f49742b..01a7f24 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -350,14 +350,6 @@ static int aspeed_master_break(struct fsi_master *master, int link)
 	return aspeed_master_write(master, link, 0, addr, &cmd, 4);
 }
 
-static void aspeed_master_release(struct device *dev)
-{
-	struct fsi_master_aspeed *aspeed =
-		to_fsi_master_aspeed(dev_to_fsi_master(dev));
-
-	kfree(aspeed);
-}
-
 /* mmode encoders */
 static inline u32 fsi_mmode_crs0(u32 x)
 {
@@ -483,7 +475,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "hub version %08x (%d links)\n", reg, links);
 
 	aspeed->master.dev.parent = &pdev->dev;
-	aspeed->master.dev.release = aspeed_master_release;
 	aspeed->master.dev.of_node = of_node_get(dev_of_node(&pdev->dev));
 
 	aspeed->master.n_links = links;
@@ -522,6 +513,7 @@ static int fsi_master_aspeed_remove(struct platform_device *pdev)
 
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
+	put_device(&aspeed->master.dev);
 
 	return 0;
 }
-- 
2.7.4


