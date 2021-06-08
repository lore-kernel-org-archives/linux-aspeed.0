From: Steven Lee <steven_lee@aspeedtech.com>
Date: Tue, 8 Jun 2021 18:25:44 +0800
Subject: [PATCH v5 09/10] gpio: gpio-aspeed-sgpio: Use generic device property
 APIs
In-Reply-To: <20210608102547.4880-1-steven_lee@aspeedtech.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
Message-ID: <20210608102547.4880-10-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Replace all of_property_read_u32() with device_property_read_u32().

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Acked-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index 38f4900d84bd..f1e40486d401 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -564,7 +564,7 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 	gpio->max_ngpios = pdata->max_ngpios;
 	pin_mask = pdata->pin_mask;
 
-	rc = of_property_read_u32(pdev->dev.of_node, "ngpios", &nr_gpios);
+	rc = device_property_read_u32(&pdev->dev, "ngpios", &nr_gpios);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Could not read ngpios property\n");
 		return -EINVAL;
@@ -575,7 +575,7 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 	}
 	gpio->n_sgpio = nr_gpios;
 
-	rc = of_property_read_u32(pdev->dev.of_node, "bus-frequency", &sgpio_freq);
+	rc = device_property_read_u32(&pdev->dev, "bus-frequency", &sgpio_freq);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Could not read bus-frequency property\n");
 		return -EINVAL;
-- 
2.17.1

