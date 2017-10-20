From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Oct 2017 14:07:24 +1030
Subject: [RFC PATCH 2/5] gpio: gpiolib: Add OF support for maintaining GPIO
 values on reset
In-Reply-To: <20171020033727.21557-1-andrew@aj.id.au>
References: <20171020033727.21557-1-andrew@aj.id.au>
Message-ID: <20171020033727.21557-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add flags and the associated flag mappings between interfaces to enable
GPIO reset tolerance to be specified via devicetree.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/gpio/gpiolib-of.c       | 2 ++
 drivers/gpio/gpiolib.c          | 5 +++++
 include/dt-bindings/gpio/gpio.h | 4 ++++
 include/linux/of_gpio.h         | 1 +
 4 files changed, 12 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index e0d59e61b52f..4a268ba52998 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -155,6 +155,8 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 
 	if (of_flags & OF_GPIO_SLEEP_MAY_LOSE_VALUE)
 		*flags |= GPIO_SLEEP_MAY_LOSE_VALUE;
+	if (of_flags & OF_GPIO_RESET_TOLERANT)
+		*flags |= GPIO_RESET_TOLERANT;
 
 	return desc;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d9dc7e588699..6b4c5df10e84 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3434,6 +3434,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	bool active_low = false;
 	bool single_ended = false;
 	bool open_drain = false;
+	bool reset_tolerant = false;
 	int ret;
 
 	if (!fwnode)
@@ -3448,6 +3449,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 			active_low = flags & OF_GPIO_ACTIVE_LOW;
 			single_ended = flags & OF_GPIO_SINGLE_ENDED;
 			open_drain = flags & OF_GPIO_OPEN_DRAIN;
+			reset_tolerant = flags & OF_GPIO_RESET_TOLERANT;
 		}
 	} else if (is_acpi_node(fwnode)) {
 		struct acpi_gpio_info info;
@@ -3478,6 +3480,9 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 			lflags |= GPIO_OPEN_SOURCE;
 	}
 
+	if (reset_tolerant)
+		lflags |= GPIO_RESET_TOLERANT;
+
 	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
 	if (ret < 0) {
 		gpiod_put(desc);
diff --git a/include/dt-bindings/gpio/gpio.h b/include/dt-bindings/gpio/gpio.h
index 70de5b7a6c9b..01c75d9e308e 100644
--- a/include/dt-bindings/gpio/gpio.h
+++ b/include/dt-bindings/gpio/gpio.h
@@ -32,4 +32,8 @@
 #define GPIO_SLEEP_MAINTAIN_VALUE 0
 #define GPIO_SLEEP_MAY_LOSE_VALUE 8
 
+/* Bit 4 express GPIO persistence on reset */
+#define GPIO_RESET_INTOLERANT 0
+#define GPIO_RESET_TOLERANT 16
+
 #endif
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 1fe205582111..9b34737706a7 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -32,6 +32,7 @@ enum of_gpio_flags {
 	OF_GPIO_SINGLE_ENDED = 0x2,
 	OF_GPIO_OPEN_DRAIN = 0x4,
 	OF_GPIO_SLEEP_MAY_LOSE_VALUE = 0x8,
+	OF_GPIO_RESET_TOLERANT = 0x16,
 };
 
 #ifdef CONFIG_OF_GPIO
-- 
2.11.0

