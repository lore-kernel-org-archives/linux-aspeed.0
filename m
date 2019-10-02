From: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 2 Oct 2019 14:11:59 +0800
Subject: [PATCH 1/2] peci: aspeed: Add AST2600 compatible string
In-Reply-To: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
References: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
Message-ID: <20191002061200.29888-2-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 SoC contains the same register set as AST25xx.

Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
---
 drivers/peci/peci-aspeed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/peci/peci-aspeed.c b/drivers/peci/peci-aspeed.c
index 51cb2563ceb6..4eed119dc83b 100644
--- a/drivers/peci/peci-aspeed.c
+++ b/drivers/peci/peci-aspeed.c
@@ -485,6 +485,7 @@ static int aspeed_peci_remove(struct platform_device *pdev)
 static const struct of_device_id aspeed_peci_of_table[] = {
 	{ .compatible = "aspeed,ast2400-peci", },
 	{ .compatible = "aspeed,ast2500-peci", },
+	{ .compatible = "aspeed,ast2600-peci", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_peci_of_table);
-- 
2.17.1

