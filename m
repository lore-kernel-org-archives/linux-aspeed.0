From: Kangjie Lu <kjlu@umn.edu>
Date: Sun, 24 Mar 2019 18:10:02 -0500
Subject: [PATCH] gpio: fix a potential NULL pointer dereference
Message-ID: <20190324231002.2106-1-kjlu@umn.edu>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In case devm_kzalloc, the patch returns ENOMEM to avoid potential
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpio/gpio-aspeed.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 854bce4fb9e7..217507002dbc 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -1224,6 +1224,8 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
 
 	gpio->offset_timer =
 		devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
+	if (!gpio->offset_timer)
+		return -ENOMEM;
 
 	return aspeed_gpio_setup_irqs(gpio, pdev);
 }
-- 
2.17.1

