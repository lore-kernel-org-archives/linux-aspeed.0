From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 13 Jan 2021 17:38:08 -0500
Subject: [PATCH, v1 1/1] gpio: aspeed: Add gpio base address reading
In-Reply-To: <20210113223808.31626-1-hongweiz@ami.com>
References: <20210113223808.31626-1-hongweiz@ami.com>
Message-ID: <20210113223808.31626-2-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <20210113223808.EQQo4oBa5Ovnu5TvlFvb-t4PNoUC16YuQ1wK11oxlAg@z>

Add gpio base address reading in the driver; in old code, it just
returns -1 to gpio->chip.base.

Fixes: 7ee2d5b4d4340353 ("ARM: dts: nuvoton: Add Fii Kudo system")
Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
---
 drivers/gpio/gpio-aspeed.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index d07bf2c3f136..4ebe4c40154c 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1140,7 +1140,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	const struct of_device_id *gpio_id;
 	struct aspeed_gpio *gpio;
 	int rc, i, banks, err;
-	u32 ngpio;
+	u32 ngpio, base;
 
 	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
 	if (!gpio)
@@ -1179,7 +1179,10 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	gpio->chip.set = aspeed_gpio_set;
 	gpio->chip.set_config = aspeed_gpio_set_config;
 	gpio->chip.label = dev_name(&pdev->dev);
-	gpio->chip.base = -1;
+	err = of_property_read_u32(pdev->dev.of_node, "base", &base);
+	gpio->chip.base = (u16) base;
+	if (err)
+		gpio->chip.base = -1;
 
 	/* Allocate a cache of the output registers */
 	banks = DIV_ROUND_UP(gpio->chip.ngpio, 32);
-- 
2.17.1

