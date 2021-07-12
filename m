From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 12 Jul 2021 18:03:16 +0800
Subject: [PATCH v6 9/9] gpio: gpio-aspeed-sgpio: Return error if ngpios is not
 multiple of 8.
In-Reply-To: <20210712100317.23298-1-steven_lee@aspeedtech.com>
References: <20210712100317.23298-1-steven_lee@aspeedtech.com>
Message-ID: <20210712100317.23298-10-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an else-if condition in the probe function to check whether ngpios is
multiple of 8.
Per AST datasheet, numbers of available serial GPIO pins in Serial GPIO
Configuration Register must be n bytes. For instance, if n = 1, it means
AST SoC supports 8 GPIO pins.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpio-aspeed-sgpio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed-sgpio.c b/drivers/gpio/gpio-aspeed-sgpio.c
index b3d05fc724f0..191b82a2560c 100644
--- a/drivers/gpio/gpio-aspeed-sgpio.c
+++ b/drivers/gpio/gpio-aspeed-sgpio.c
@@ -537,6 +537,10 @@ static int __init aspeed_sgpio_probe(struct platform_device *pdev)
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Could not read ngpios property\n");
 		return -EINVAL;
+	} else if (nr_gpios % 8) {
+		dev_err(&pdev->dev, "Number of GPIOs not multiple of 8: %d\n",
+			nr_gpios);
+		return -EINVAL;
 	}
 
 	rc = device_property_read_u32(&pdev->dev, "bus-frequency", &sgpio_freq);
-- 
2.17.1

