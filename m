From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 26 Nov 2022 10:44:02 +0100
Subject: [PATCH] fsi: Aspeed: Fix a resource leak in fsi_master_aspeed_remove()
Message-ID: <faf56efd13207ea888c5ebda2d3de82e096d3fa0.1669455822.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

An explicit get_device() call in fsi_master_aspeed_probe() is not balanced
by a corresponding put_device() in the .remove() function.

Add it, otherwise some resource may never be released.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative and untested.
---
 drivers/fsi/fsi-master-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 7cec1772820d..b66d9853117b 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -651,6 +651,8 @@ static int fsi_master_aspeed_remove(struct platform_device *pdev)
 	fsi_master_unregister(&aspeed->master);
 	clk_disable_unprepare(aspeed->clk);
 
+	put_device(&aspeed->master.dev);
+
 	return 0;
 }
 
-- 
2.34.1

