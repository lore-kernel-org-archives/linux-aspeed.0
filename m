From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:46 +0800
Subject: [PATCH -next 27/34] rtc: st-lpc: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-28-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-st-lpc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 49474a3..f1c5471 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -186,7 +186,6 @@ static int st_rtc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct st_rtc *rtc;
-	struct resource *res;
 	uint32_t mode;
 	int ret = 0;
 
@@ -210,8 +209,7 @@ static int st_rtc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&rtc->lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rtc->ioaddr = devm_ioremap_resource(&pdev->dev, res);
+	rtc->ioaddr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rtc->ioaddr))
 		return PTR_ERR(rtc->ioaddr);
 
-- 
2.7.4


