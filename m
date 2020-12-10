From: Troy Lee <troy_lee@aspeedtech.com>
Date: Thu, 10 Dec 2020 14:50:13 +0800
Subject: [PATCH] gpio: aspeed: Lock GPIO pin used as IRQ
Message-ID: <20201210065013.29348-1-troy_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

GPIO pins can be used as IRQ indicators. When they do,
those pins should be flaged with locks to avoid kernel
warning message.

Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
---
 drivers/gpio/gpio-aspeed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index b966f5e28ebf..f5b3e1d89fbf 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -651,6 +651,13 @@ static int aspeed_gpio_set_type(struct irq_data *d, unsigned int type)
 		aspeed_gpio_copro_release(gpio, offset);
 	spin_unlock_irqrestore(&gpio->lock, flags);
 
+	rc = gpiochip_lock_as_irq(&gpio->chip, d->hwirq);
+	if (rc) {
+		dev_err(gpio->chip.parent, "unable to lock GPIO %lu as IRQ\n",
+			d->hwirq);
+		return rc;
+	}
+
 	irq_set_handler_locked(d, handler);
 
 	return 0;
-- 
2.17.1

