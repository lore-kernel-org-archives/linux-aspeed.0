From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:50 +0800
Subject: [PATCH -next 31/34] rtc: tx4939: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-32-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-tx4939.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
index 5a29915..715b829 100644
--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -236,7 +236,6 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
 	struct tx4939rtc_plat_data *pdata;
-	struct resource *res;
 	int irq, ret;
 	struct nvmem_config nvmem_cfg = {
 		.name = "tx4939_nvram",
@@ -253,8 +252,7 @@ static int __init tx4939_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, pdata);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pdata->rtcreg = devm_ioremap_resource(&pdev->dev, res);
+	pdata->rtcreg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdata->rtcreg))
 		return PTR_ERR(pdata->rtcreg);
 
-- 
2.7.4


