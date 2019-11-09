From: YueHaibing <yuehaibing@huawei.com>
Date: Sat, 9 Nov 2019 11:32:09 +0800
Subject: [PATCH -next] fsi: aspeed: Use devm_kfree in aspeed_master_release()
Message-ID: <20191109033209.45244-1-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'aspeed' is allocted by devm_kfree(), it should not be
freed bt kfree().

Fixes: 1edac1269c02 ("fsi: Add ast2600 master driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fsi/fsi-master-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 3dd82dd..0f63eec 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -361,7 +361,7 @@ static void aspeed_master_release(struct device *dev)
 	struct fsi_master_aspeed *aspeed =
 		to_fsi_master_aspeed(dev_to_fsi_master(dev));
 
-	kfree(aspeed);
+	devm_kfree(dev, aspeed);
 }
 
 /* mmode encoders */
-- 
2.7.4


