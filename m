From: Zhu Wang <wangzhu9@huawei.com>
Date: Tue, 8 Aug 2023 19:52:13 +0800
Subject: [PATCH -next 5/5] rtc: at91rm9200: remove redundant of_match_ptr()
In-Reply-To: <20230808115213.154377-1-wangzhu9@huawei.com>
References: <20230808115213.154377-1-wangzhu9@huawei.com>
Message-ID: <20230808115213.154377-6-wangzhu9@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr() here.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/rtc/rtc-at91rm9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index e9d17232d0a8..4052e983455f 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -642,7 +642,7 @@ static struct platform_driver at91_rtc_driver = {
 	.driver		= {
 		.name	= "at91_rtc",
 		.pm	= &at91_rtc_pm_ops,
-		.of_match_table = of_match_ptr(at91_rtc_dt_ids),
+		.of_match_table = at91_rtc_dt_ids,
 	},
 };
 
-- 
2.17.1

