From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 26 Dec 2021 17:56:02 +0100
Subject: [PATCH] fsi: Aspeed: Fix a potential double free
Message-ID: <2cafa0607ca171ebd00ac6c7e073b46808e24f00.1640537669.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'aspeed' is a devm_alloc'ed, so there is no need to free it explicitly or
there will be a double free().

Remove the 'release' function that is wrong and unneeded.

Fixes: 606397d67f41 ("fsi: Add ast2600 master driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is completely theoretical. It looks good to me, but there is a
little too much indirections for me. I'm also not that familiar with
fixing issue related to 'release' function...

... So review with care :)
---
 drivers/fsi/fsi-master-aspeed.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index 8606e55c1721..4a745ccb60cf 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -373,14 +373,6 @@ static int aspeed_master_break(struct fsi_master *master, int link)
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
@@ -603,7 +595,6 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "hub version %08x (%d links)\n", reg, links);
 
 	aspeed->master.dev.parent = &pdev->dev;
-	aspeed->master.dev.release = aspeed_master_release;
 	aspeed->master.dev.of_node = of_node_get(dev_of_node(&pdev->dev));
 
 	aspeed->master.n_links = links;
-- 
2.32.0

