From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:22 +0800
Subject: [PATCH -next 03/34] rtc: brcmstb-waketimer: use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-4-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-brcmstb-waketimer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-brcmstb-waketimer.c b/drivers/rtc/rtc-brcmstb-waketimer.c
index 3e9800f..cb7af87 100644
--- a/drivers/rtc/rtc-brcmstb-waketimer.c
+++ b/drivers/rtc/rtc-brcmstb-waketimer.c
@@ -200,7 +200,6 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct brcmstb_waketmr *timer;
-	struct resource *res;
 	int ret;
 
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
@@ -210,8 +209,7 @@ static int brcmstb_waketmr_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, timer);
 	timer->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	timer->base = devm_ioremap_resource(dev, res);
+	timer->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->base))
 		return PTR_ERR(timer->base);
 
-- 
2.7.4


