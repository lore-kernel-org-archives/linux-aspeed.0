From: Igor Kononenko <i.kononenko@yadro.com>
Date: Sun, 21 Aug 2022 18:54:11 +0300
Subject: [PATCH 3/3] drivers/misc: (aspeed-lpc-snoop): Fix platform_get_irq() error checking
In-Reply-To: <cover.1661094034.git.i.kononenko@yadro.com>
References: <cover.1661094034.git.i.kononenko@yadro.com>
Message-ID: <77b3bcb747675a7128b98efad3beb0c53e0a8908.1661094034.git.i.kononenko@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The `platform_get_irq` return negative code that is indicate an error.
So `!lpc_snoop->irq` leads to misscought a failure.
This patch brings fix of checking negative `rc`.

Signed-off-by: Igor Kononenko <i.kononenko@yadro.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 6ec47bf1dc6b..25731cf0342d 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -167,7 +167,7 @@ static int aspeed_lpc_snoop_config_irq(struct aspeed_lpc_snoop *lpc_snoop,
 	int rc;
 
 	lpc_snoop->irq = platform_get_irq(pdev, 0);
-	if (!lpc_snoop->irq)
+	if (lpc_snoop->irq < 0)
 		return -ENODEV;
 
 	rc = devm_request_irq(dev, lpc_snoop->irq,
-- 
2.25.1

