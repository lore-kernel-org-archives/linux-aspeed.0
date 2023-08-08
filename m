From: Zhu Wang <wangzhu9@huawei.com>
Date: Tue, 8 Aug 2023 19:52:11 +0800
Subject: [PATCH -next 3/5] rtc: nct3018y: remove redundant of_match_ptr()
In-Reply-To: <20230808115213.154377-1-wangzhu9@huawei.com>
References: <20230808115213.154377-1-wangzhu9@huawei.com>
Message-ID: <20230808115213.154377-4-wangzhu9@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver depends on CONFIG_OF, so it is not necessary to use
of_match_ptr() here. We remove of_match_ptr().

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/rtc/rtc-nct3018y.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index a4e3f924837e..ed4e606be8e5 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -538,7 +538,7 @@ MODULE_DEVICE_TABLE(of, nct3018y_of_match);
 static struct i2c_driver nct3018y_driver = {
 	.driver		= {
 		.name	= "rtc-nct3018y",
-		.of_match_table = of_match_ptr(nct3018y_of_match),
+		.of_match_table = nct3018y_of_match,
 	},
 	.probe		= nct3018y_probe,
 	.id_table	= nct3018y_id,
-- 
2.17.1

