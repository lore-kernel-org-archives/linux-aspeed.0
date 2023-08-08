From: Zhu Wang <wangzhu9@huawei.com>
Date: Tue, 8 Aug 2023 19:52:09 +0800
Subject: [PATCH -next 1/5] rtc: aspeed: remove redundant of_match_ptr()
In-Reply-To: <20230808115213.154377-1-wangzhu9@huawei.com>
References: <20230808115213.154377-1-wangzhu9@huawei.com>
Message-ID: <20230808115213.154377-2-wangzhu9@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr() here.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/rtc/rtc-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
index a93352ed3aec..880b015eebaf 100644
--- a/drivers/rtc/rtc-aspeed.c
+++ b/drivers/rtc/rtc-aspeed.c
@@ -118,7 +118,7 @@ MODULE_DEVICE_TABLE(of, aspeed_rtc_match);
 static struct platform_driver aspeed_rtc_driver = {
 	.driver = {
 		.name = "aspeed-rtc",
-		.of_match_table = of_match_ptr(aspeed_rtc_match),
+		.of_match_table = aspeed_rtc_match,
 	},
 };
 
-- 
2.17.1

