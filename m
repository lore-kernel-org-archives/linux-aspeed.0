From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Aug 2017 15:37:36 +0930
Subject: [PATCH 2/2] gpio: aspeed: Remove reference to clock name in debounce
 warning message
In-Reply-To: <20170808060736.1917-1-andrew@aj.id.au>
References: <20170808060736.1917-1-andrew@aj.id.au>
Message-ID: <20170808060736.1917-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

HPLL is in fact not the clock we need. Remove the description of which clock we
failed to find a phandle to in order to avoid any further error.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpio-aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 4ca436e66bdb..bfc53995064a 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -834,7 +834,7 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 	gpio->clk = of_clk_get(pdev->dev.of_node, 0);
 	if (IS_ERR(gpio->clk)) {
 		dev_warn(&pdev->dev,
-				"No HPLL clock phandle provided, debouncing disabled\n");
+				"Failed to get clock from devicetree, debouncing disabled\n");
 		gpio->clk = NULL;
 	}
 
-- 
2.11.0

