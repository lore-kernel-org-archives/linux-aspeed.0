From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Date: Tue, 5 Nov 2019 12:12:30 +0200
Subject: [PATCH 07/62] gpio: gpio-aspeed: Use new GPIO_LINE_DIRECTION
In-Reply-To: <cover.1572945709.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1572945709.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <493e2f9ed5aff112519adcdf2d3044bf54c2d91a.1572945709.git.matti.vaittinen@fi.rohmeurope.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It's hard for occasional GPIO code reader/writer to know if values 0/1
equal to IN or OUT. Use defined GPIO_LINE_DIRECTION_IN and
GPIO_LINE_DIRECTION_OUT to help them out.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/gpio/gpio-aspeed.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
index 09e53c5f3b0a..f1037b61f763 100644
--- a/drivers/gpio/gpio-aspeed.c
+++ b/drivers/gpio/gpio-aspeed.c
@@ -487,10 +487,10 @@ static int aspeed_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 	u32 val;
 
 	if (!have_input(gpio, offset))
-		return 0;
+		return GPIO_LINE_DIRECTION_OUT;
 
 	if (!have_output(gpio, offset))
-		return 1;
+		return GPIO_LINE_DIRECTION_IN;
 
 	spin_lock_irqsave(&gpio->lock, flags);
 
@@ -498,8 +498,7 @@ static int aspeed_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 
 	spin_unlock_irqrestore(&gpio->lock, flags);
 
-	return !val;
-
+	return val ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
 }
 
 static inline int irqd_to_aspeed_gpio_data(struct irq_data *d,
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
