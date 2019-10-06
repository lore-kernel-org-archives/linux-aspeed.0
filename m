From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:45 +0800
Subject: [PATCH -next 26/34] rtc: ds1286: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-27-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-ds1286.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index a06508b..7acf849 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -323,15 +323,13 @@ static const struct rtc_class_ops ds1286_ops = {
 static int ds1286_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
-	struct resource *res;
 	struct ds1286_priv *priv;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct ds1286_priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->rtcregs = devm_ioremap_resource(&pdev->dev, res);
+	priv->rtcregs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->rtcregs))
 		return PTR_ERR(priv->rtcregs);
 
-- 
2.7.4


