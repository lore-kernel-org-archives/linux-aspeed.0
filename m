From: Zhu Wang <wangzhu9@huawei.com>
Date: Tue, 8 Aug 2023 19:52:12 +0800
Subject: [PATCH -next 4/5] rtc: armada38x: remove redundant of_match_ptr()
In-Reply-To: <20230808115213.154377-1-wangzhu9@huawei.com>
References: <20230808115213.154377-1-wangzhu9@huawei.com>
Message-ID: <20230808115213.154377-5-wangzhu9@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr().

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/rtc/rtc-armada38x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index b4139c200676..ef878b76dd7b 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -474,7 +474,6 @@ static const struct armada38x_rtc_data armada8k_data = {
 	.alarm = ALARM2,
 };
 
-#ifdef CONFIG_OF
 static const struct of_device_id armada38x_rtc_of_match_table[] = {
 	{
 		.compatible = "marvell,armada-380-rtc",
@@ -487,7 +486,6 @@ static const struct of_device_id armada38x_rtc_of_match_table[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(of, armada38x_rtc_of_match_table);
-#endif
 
 static __init int armada38x_rtc_probe(struct platform_device *pdev)
 {
@@ -577,7 +575,7 @@ static struct platform_driver armada38x_rtc_driver = {
 	.driver		= {
 		.name	= "armada38x-rtc",
 		.pm	= &armada38x_rtc_pm_ops,
-		.of_match_table = of_match_ptr(armada38x_rtc_of_match_table),
+		.of_match_table = armada38x_rtc_of_match_table,
 	},
 };
 
-- 
2.17.1

