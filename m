From: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 18 Sep 2019 08:26:55 -0000
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Use
 devm_platform_ioremap_resource() in aspeed_pwm_tacho_probe()
Message-ID: <cd5bab7b-9333-2a43-bcf0-a47bbbe719eb@web.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 10:12:31 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 40c489be62ea..33fb54845bf6 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -891,17 +891,12 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	struct device_node *np, *child;
 	struct aspeed_pwm_tacho_data *priv;
 	void __iomem *regs;
-	struct resource *res;
 	struct device *hwmon;
 	struct clk *clk;
 	int ret;

 	np = dev->of_node;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOENT;
-	regs = devm_ioremap_resource(dev, res);
+	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
--
2.23.0

