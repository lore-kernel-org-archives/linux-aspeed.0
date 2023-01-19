From: ye.xingchen@zte.com.cn <ye.xingchen@zte.com.cn>
Date: Thu, 19 Jan 2023 17:15:31 +0800 (CST)
Subject: =?UTF-8?B?W1BBVENIXSBpMmM6IGFzcGVlZDogVXNlIGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Message-ID: <202301191715319948743@zte.com.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: ye xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/i2c/busses/i2c-aspeed.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index c64c381b69b7..d3c99c5b3247 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -979,15 +979,13 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct aspeed_i2c_bus *bus;
 	struct clk *parent_clk;
-	struct resource *res;
 	int irq, ret;

 	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
 	if (!bus)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bus->base = devm_ioremap_resource(&pdev->dev, res);
+	bus->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(bus->base))
 		return PTR_ERR(bus->base);

-- 
2.25.1
