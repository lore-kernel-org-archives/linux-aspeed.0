From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:29 +0800
Subject: [PATCH -next 10/34] rtc: ds1511: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-11-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-ds1511.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1511.c b/drivers/rtc/rtc-ds1511.c
index b6a4775..a63872c 100644
--- a/drivers/rtc/rtc-ds1511.c
+++ b/drivers/rtc/rtc-ds1511.c
@@ -414,7 +414,6 @@ static int ds1511_nvram_write(void *priv, unsigned int pos, void *buf,
 
 static int ds1511_rtc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct rtc_plat_data *pdata;
 	int ret = 0;
 	struct nvmem_config ds1511_nvmem_cfg = {
@@ -431,8 +430,7 @@ static int ds1511_rtc_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ds1511_base = devm_ioremap_resource(&pdev->dev, res);
+	ds1511_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ds1511_base))
 		return PTR_ERR(ds1511_base);
 	pdata->ioaddr = ds1511_base;
-- 
2.7.4


