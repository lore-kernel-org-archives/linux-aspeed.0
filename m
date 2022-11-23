From: Xiu Jianfeng <xiujianfeng@huawei.com>
Date: Wed, 23 Nov 2022 21:58:08 +0800
Subject: [PATCH] soc: aspeed: Fix memory leak issue in aspeed_socinfo_init()
Message-ID: <20221123135808.171048-1-xiujianfeng@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If soc_device_register() fails, @attrs->machine may have allocated
string, it should be freed before return error, otherwise will cause
memory leak issue, fix it.

Fixes: e0218dca5787 ("soc: aspeed: Add soc info driver")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 1ca140356a08..3f759121dc00 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -137,6 +137,7 @@ static int __init aspeed_socinfo_init(void)
 
 	soc_dev = soc_device_register(attrs);
 	if (IS_ERR(soc_dev)) {
+		kfree(attrs->machine);
 		kfree(attrs->soc_id);
 		kfree(attrs->serial_number);
 		kfree(attrs);
-- 
2.17.1

