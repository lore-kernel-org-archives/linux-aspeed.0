From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:41 +0800
Subject: [PATCH -next 22/34] rtc: s3c: use devm_platform_ioremap_resource() to
 simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-23-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-s3c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 7801249..e1b50e6 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -444,7 +444,6 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 {
 	struct s3c_rtc *info = NULL;
 	struct rtc_time rtc_tm;
-	struct resource *res;
 	int ret;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -475,8 +474,7 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 		info->irq_tick, info->irq_alarm);
 
 	/* get the memory region */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	info->base = devm_ioremap_resource(&pdev->dev, res);
+	info->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->base))
 		return PTR_ERR(info->base);
 
-- 
2.7.4


