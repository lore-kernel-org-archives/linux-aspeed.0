From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:24 +0800
Subject: [PATCH -next 05/34] rtc: cadence: use
 devm_platform_ioremap_resource() to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-6-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-cadence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-cadence.c b/drivers/rtc/rtc-cadence.c
index 592aae2..595d5d2 100644
--- a/drivers/rtc/rtc-cadence.c
+++ b/drivers/rtc/rtc-cadence.c
@@ -255,7 +255,6 @@ static const struct rtc_class_ops cdns_rtc_ops = {
 static int cdns_rtc_probe(struct platform_device *pdev)
 {
 	struct cdns_rtc *crtc;
-	struct resource *res;
 	int ret;
 	unsigned long ref_clk_freq;
 
@@ -263,8 +262,7 @@ static int cdns_rtc_probe(struct platform_device *pdev)
 	if (!crtc)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	crtc->regs = devm_ioremap_resource(&pdev->dev, res);
+	crtc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(crtc->regs))
 		return PTR_ERR(crtc->regs);
 
-- 
2.7.4


