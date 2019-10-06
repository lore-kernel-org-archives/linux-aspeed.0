From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:36 +0800
Subject: [PATCH -next 17/34] rtc: mt7622: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-18-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-mt7622.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
index 16bd26b..f1e3563 100644
--- a/drivers/rtc/rtc-mt7622.c
+++ b/drivers/rtc/rtc-mt7622.c
@@ -303,7 +303,6 @@ MODULE_DEVICE_TABLE(of, mtk_rtc_match);
 static int mtk_rtc_probe(struct platform_device *pdev)
 {
 	struct mtk_rtc *hw;
-	struct resource *res;
 	int ret;
 
 	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
@@ -312,8 +311,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hw);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	hw->base = devm_ioremap_resource(&pdev->dev, res);
+	hw->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hw->base))
 		return PTR_ERR(hw->base);
 
-- 
2.7.4


