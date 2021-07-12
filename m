From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 12 Jul 2021 18:03:15 +0800
Subject: [PATCH v6 8/9] gpio: gpio-aspeed-sgpio: Use generic device property
 APIs
In-Reply-To: <20210712100317.23298-1-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
Message-ID: <20210712100317.23298-9-steven_lee@aspeedtech.com>
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
index 6b3695197c97..b3d05fc724f0 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -533,13 +533,13 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 
 	pin_mask = pdata->pin_mask;
 
-	rc = of_property_read_u32(pdev->dev.of_node, "ngpios", &nr_gpios);
+	rc = device_property_read_u32(&pdev->dev, "ngpios", &nr_gpios);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Could not read ngpios property\n");
 		return -EINVAL;
 	}
 
-	rc = of_property_read_u32(pdev->dev.of_node, "bus-frequency", &sgpio_freq);
+	rc = device_property_read_u32(&pdev->dev, "bus-frequency", &sgpio_freq);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Could not read bus-frequency property\n");
 		return -EINVAL;
-- 
2.17.1

