From: Xu Wang <vulab@iscas.ac.cn>
Date: Wed, 18 Dec 2019 06:08:46 -0000
Subject: [PATCH] EDAC: aspeed: Remove unneeded semicolon
Message-ID: <1576648806-1114-1-git-send-email-vulab@iscas.ac.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove unneeded semicolon reported by coccinelle.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/edac/aspeed_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 09a9e3d..b194658b 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -243,7 +243,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 	if (!np) {
 		dev_err(mci->pdev, "dt: missing /memory node\n");
 		return -ENODEV;
-	};
+	}
 
 	rc = of_address_to_resource(np, 0, &r);
 
@@ -252,7 +252,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 	if (rc) {
 		dev_err(mci->pdev, "dt: failed requesting resource for /memory node\n");
 		return rc;
-	};
+	}
 
 	dev_dbg(mci->pdev, "dt: /memory node resources: first page r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
 		r.start, resource_size(&r), PAGE_SHIFT);
-- 
2.7.4

