From: Tao Ren <taoren@fb.com>
Date: Wed, 12 Dec 2018 13:53:05 -0800
Subject: [PATCH] gpio: aspeed: remove duplicated statement
Message-ID: <20181212215305.3852170-1-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove duplicated assignment statement from aspeed_gpio_probe() function.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 drivers/gpio/gpio-aspeed.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 2342e154029b..854bce4fb9e7 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1185,7 +1185,6 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 	gpio->chip.parent = &pdev->dev;
 	gpio->chip.ngpio = gpio->config->nr_gpios;
-	gpio->chip.parent = &pdev->dev;
 	gpio->chip.direction_input = aspeed_gpio_dir_in;
 	gpio->chip.direction_output = aspeed_gpio_dir_out;
 	gpio->chip.get_direction = aspeed_gpio_get_direction;
-- 
2.17.1

