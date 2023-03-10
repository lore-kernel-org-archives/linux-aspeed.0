From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 10 Mar 2023 23:30:12 +0100
Subject: [PATCH] watchdog: aspeed: Drop of_match_ptr for ID table
Message-ID: <20230310223012.315897-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/watchdog/aspeed_wdt.c:56:34: error: ?aspeed_wdt_of_table? defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/watchdog/aspeed_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index c1e79874a2bb..b72a858bbac7 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -465,7 +465,7 @@ static struct platform_driver aspeed_watchdog_driver = {
 	.probe = aspeed_wdt_probe,
 	.driver = {
 		.name = KBUILD_MODNAME,
-		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
+		.of_match_table = aspeed_wdt_of_table,
 	},
 };
 
-- 
2.34.1

