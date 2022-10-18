From: Yang Yingliang <yangyingliang@huawei.com>
Date: Tue, 18 Oct 2022 22:49:58 +0800
Subject: [PATCH 2/2] fsi: aspeed: fix node refcount leak
In-Reply-To: <20221018144958.1972563-1-yangyingliang@huawei.com>
References: <20221018144958.1972563-1-yangyingliang@huawei.com>
Message-ID: <20221018144958.1972563-2-yangyingliang@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The node refcount is hold in fsi_master_aspeed_probe(), it need be put in
fsi_master_aspeed_remove() and in error path in fsi_master_aspeed_probe().

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/fsi/fsi-master-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index a72dbfe2addc..8160e781dc04 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -625,6 +625,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 
 	rc = fsi_master_register(&aspeed->master);
 	if (rc) {
+		of_node_put(aspeed->master.dev.of_node);
 		put_device(&aspeed->master.dev);
 		aspeed = NULL;
 		goto err_release;
@@ -654,6 +655,7 @@ static int fsi_master_aspeed_remove(struct platform_device *pdev)
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
 
+	of_node_put(aspeed->master.dev.of_node);
 	put_device(&aspeed->master.dev);
 	return 0;
 }
-- 
2.25.1

