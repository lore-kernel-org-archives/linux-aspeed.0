From: Yang Yingliang <yangyingliang@huawei.com>
Date: Tue, 18 Oct 2022 22:49:57 +0800
Subject: [PATCH 1/2] fsi: aspeed: fix master device refcount leak
Message-ID: <20221018144958.1972563-1-yangyingliang@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If fsi_master_register() fails, put_device() need be called to decrease
refcount to 0, so that the name allocated in dev_set_name() can be freed
in callback function kobject_cleanup().

Besides, the refcount is hold in fsi_master_aspeed_probe(), it need be put
in fsi_master_aspeed_remove().

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/fsi/fsi-master-aspeed.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 7cec1772820d..a72dbfe2addc 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -624,8 +624,11 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	aspeed_master_init(aspeed);
 
 	rc = fsi_master_register(&aspeed->master);
-	if (rc)
+	if (rc) {
+		put_device(&aspeed->master.dev);
+		aspeed = NULL;
 		goto err_release;
+	}
 
 	/* At this point, fsi_master_register performs the device_initialize(),
 	 * and holds the sole reference on master.dev. This means the device
@@ -651,6 +654,7 @@ static int fsi_master_aspeed_remove(struct platform_device *pdev)
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
 
+	put_device(&aspeed->master.dev);
 	return 0;
 }
 
-- 
2.25.1

