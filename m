From: Joel Stanley <joel@jms.id.au>
Date: Wed, 18 Aug 2021 10:35:34 +0930
Subject: [PATCH] soc: aspeed: socinfo: Add AST2625 variant
Message-ID: <20210818010534.2508122-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add AST26XX series AST2625-A3 SOC ID, taken from the vendor u-boot SDK:

 arch/arm/mach-aspeed/ast2600/scu_info.c
 +       SOC_ID("AST2625-A3", 0x0503040305030403),

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Dylan, can you please review this for me?

 drivers/soc/aspeed/aspeed-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index e3215f826d17..1ca140356a08 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -26,6 +26,7 @@ static struct {
 	{ "AST2600", 0x05000303 },
 	{ "AST2620", 0x05010203 },
 	{ "AST2605", 0x05030103 },
+	{ "AST2625", 0x05030403 },
 };
 
 static const char *siliconid_to_name(u32 siliconid)
-- 
2.32.0

