From: YueHaibing <yuehaibing@huawei.com>
Date: Sun, 6 Oct 2019 18:29:35 +0800
Subject: [PATCH -next 16/34] rtc: meson: use devm_platform_ioremap_resource()
 to simplify code
In-Reply-To: <20191006102953.57536-1-yuehaibing@huawei.com>
References: <20191006102953.57536-1-yuehaibing@huawei.com>
Message-ID: <20191006102953.57536-17-yuehaibing@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/rtc/rtc-meson.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
index e08b981..9bd8478 100644
--- a/drivers/rtc/rtc-meson.c
+++ b/drivers/rtc/rtc-meson.c
@@ -292,7 +292,6 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	};
 	struct device *dev = &pdev->dev;
 	struct meson_rtc *rtc;
-	struct resource *res;
 	void __iomem *base;
 	int ret;
 	u32 tm;
@@ -312,8 +311,7 @@ static int meson_rtc_probe(struct platform_device *pdev)
 	rtc->rtc->ops = &meson_rtc_ops;
 	rtc->rtc->range_max = U32_MAX;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.7.4


