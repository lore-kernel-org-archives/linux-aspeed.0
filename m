From: Zhu Wang <wangzhu9@huawei.com>
Date: Tue, 8 Aug 2023 19:52:10 +0800
Subject: [PATCH -next 2/5] rtc: at91sam9: remove redundant of_match_ptr()
In-Reply-To: <20230808115213.154377-1-wangzhu9@huawei.com>
References: <20230808115213.154377-1-wangzhu9@huawei.com>
Message-ID: <20230808115213.154377-3-wangzhu9@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr() here.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/rtc/rtc-at91sam9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 610f27dfc462..f93bee96e362 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -534,7 +534,7 @@ static struct platform_driver at91_rtc_driver = {
 	.driver		= {
 		.name	= "rtc-at91sam9",
 		.pm	= &at91_rtc_pm_ops,
-		.of_match_table = of_match_ptr(at91_rtc_dt_ids),
+		.of_match_table = at91_rtc_dt_ids,
 	},
 };
 
-- 
2.17.1

