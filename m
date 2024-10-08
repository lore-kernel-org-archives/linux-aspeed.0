From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 8 Oct 2024 16:14:45 +0800
Subject: [PATCH v7 2/7] gpio: aspeed: Use devm_clk api to manage clock source
In-Reply-To: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
References: <20241008081450.1490955-1-billy_tsai@aspeedtech.com>
Message-ID: <20241008081450.1490955-3-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace of_clk_get with devm_clk_get_enabled to manage the clock source.

Fixes: 5ae4cb94b313 ("gpio: aspeed: Add debounce support")
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 98551b7f6de2..ea40ad43a79b 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1193,7 +1193,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	if (!gpio_id)
 		return -EINVAL;
 
-	gpio->clk = of_clk_get(pdev->dev.of_node, 0);
+	gpio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(gpio->clk)) {
 		dev_warn(&pdev->dev,
 				"Failed to get clock from devicetree, debouncing disabled\n");
-- 
2.25.1

