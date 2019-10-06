From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:52 +0800
Subject: [PATCH -next 33/34] rtc: xgene: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-34-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-xgene.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 9683fbf..603c4e4 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -137,7 +137,6 @@ static irqreturn_t xgene_rtc_interrupt(int irq, void *id)
 static int xgene_rtc_probe(struct platform_device *pdev)
 {
 	struct xgene_rtc_dev *pdata;
-	struct resource *res;
 	int ret;
 	int irq;
 
@@ -147,8 +146,7 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pdata);
 	pdata->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pdata->csr_base = devm_ioremap_resource(&pdev->dev, res);
+	pdata->csr_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdata->csr_base))
 		return PTR_ERR(pdata->csr_base);
 
-- 
2.7.4


