From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 30 Nov 2017 14:25:24 +1030
Subject: [PATCH v4 1/2] gpio: gpiolib: Generalise state persistence beyond
 sleep
In-Reply-To: <20171130035525.29653-1-andrew@aj.id.au>
References: <20171130035525.29653-1-andrew@aj.id.au>
Message-ID: <20171130035525.29653-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

General support for state persistence is added to gpiolib with the
introduction of a new pinconf parameter to propagate the request to
hardware. The existing persistence support for sleep is adapted to
include hardware support if the GPIO driver provides it. Persistence
continues to be enabled by default; in-kernel consumers can opt out, but
userspace (currently) does not have a choice.

The *_SLEEP_MAY_LOSE_VALUE and *_SLEEP_MAINTAIN_VALUE symbols are
renamed, dropping the SLEEP prefix to reflect that the concept is no
longer sleep-specific.  I feel that renaming to just *_MAY_LOSE_VALUE
could initially be misinterpreted, so I've further changed the symbols
to *_TRANSITORY and *_PERSISTENT to address this.

The sysfs interface is modified only to keep consistency with the
chardev interface in enforcing persistence for userspace exports.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/gpio/gpiolib-of.c               |  6 ++--
 drivers/gpio/gpiolib-sysfs.c            | 14 +++++---
 drivers/gpio/gpiolib.c                  | 61 ++++++++++++++++++++++++++++++---
 drivers/gpio/gpiolib.h                  |  2 +-
 include/dt-bindings/gpio/gpio.h         |  6 ++--
 include/linux/gpio/consumer.h           |  8 +++++
 include/linux/gpio/machine.h            |  4 +--
 include/linux/of_gpio.h                 |  2 +-
 include/linux/pinctrl/pinconf-generic.h |  2 ++
 9 files changed, 87 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index e0d59e61b52f..4a2b8d3397c7 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -153,8 +153,8 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 			*flags |= GPIO_OPEN_SOURCE;
 	}
 
-	if (of_flags & OF_GPIO_SLEEP_MAY_LOSE_VALUE)
-		*flags |= GPIO_SLEEP_MAY_LOSE_VALUE;
+	if (of_flags & OF_GPIO_TRANSITORY)
+		*flags |= GPIO_TRANSITORY;
 
 	return desc;
 }
@@ -214,6 +214,8 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
 
 	if (xlate_flags & OF_GPIO_ACTIVE_LOW)
 		*lflags |= GPIO_ACTIVE_LOW;
+	if (xlate_flags & OF_GPIO_TRANSITORY)
+		*lflags |= GPIO_TRANSITORY;
 
 	if (of_property_read_bool(np, "input"))
 		*dflags |= GPIOD_IN;
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 3f454eaf2101..0bd472ffb072 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -474,11 +474,15 @@ static ssize_t export_store(struct class *class,
 			status = -ENODEV;
 		goto done;
 	}
-	status = gpiod_export(desc, true);
-	if (status < 0)
-		gpiod_free(desc);
-	else
-		set_bit(FLAG_SYSFS, &desc->flags);
+
+	status = gpiod_set_transitory(desc, false);
+	if (!status) {
+		status = gpiod_export(desc, true);
+		if (status < 0)
+			gpiod_free(desc);
+		else
+			set_bit(FLAG_SYSFS, &desc->flags);
+	}
 
 done:
 	if (status)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index aad84a6306c4..e91c2d28b7bd 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -505,6 +505,10 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 		if (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE)
 			set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
+		ret = gpiod_set_transitory(desc, false);
+		if (ret < 0)
+			goto out_free_descs;
+
 		/*
 		 * Lines have to be requested explicitly for input
 		 * or output, else the line will be treated "as is".
@@ -2520,6 +2524,49 @@ int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
+/**
+ * gpiod_set_transitory - Lose or retain GPIO state on suspend or reset
+ * @desc: descriptor of the GPIO for which to configure persistence
+ * @transitory: True to lose state on suspend or reset, false for persistence
+ *
+ * Returns:
+ * 0 on success, otherwise a negative error code.
+ */
+int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
+{
+	struct gpio_chip *chip;
+	unsigned long packed;
+	int gpio;
+	int rc;
+
+	/*
+	 * Handle FLAG_TRANSITORY first, enabling queries to gpiolib for
+	 * persistence state.
+	 */
+	if (transitory)
+		set_bit(FLAG_TRANSITORY, &desc->flags);
+	else
+		clear_bit(FLAG_TRANSITORY, &desc->flags);
+
+	/* If the driver supports it, set the persistence state now */
+	chip = desc->gdev->chip;
+	if (!chip->set_config)
+		return 0;
+
+	packed = pinconf_to_config_packed(PIN_CONFIG_PERSIST_STATE,
+					  !transitory);
+	gpio = gpio_chip_hwgpio(desc);
+	rc = chip->set_config(chip, gpio, packed);
+	if (rc == -ENOTSUPP) {
+		dev_dbg(&desc->gdev->dev, "Persistence not supported for GPIO %d\n",
+				gpio);
+		return 0;
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(gpiod_set_transitory);
+
 /**
  * gpiod_is_active_low - test whether a GPIO is active-low or not
  * @desc: the gpio descriptor to test
@@ -3107,8 +3154,7 @@ bool gpiochip_line_is_persistent(struct gpio_chip *chip, unsigned int offset)
 	if (offset >= chip->ngpio)
 		return false;
 
-	return !test_bit(FLAG_SLEEP_MAY_LOSE_VALUE,
-			 &chip->gpiodev->descs[offset].flags);
+	return !test_bit(FLAG_TRANSITORY, &chip->gpiodev->descs[offset].flags);
 }
 EXPORT_SYMBOL_GPL(gpiochip_line_is_persistent);
 
@@ -3545,8 +3591,10 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 
 	if (lflags & GPIO_OPEN_SOURCE)
 		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
-	if (lflags & GPIO_SLEEP_MAY_LOSE_VALUE)
-		set_bit(FLAG_SLEEP_MAY_LOSE_VALUE, &desc->flags);
+
+	status = gpiod_set_transitory(desc, (lflags & GPIO_TRANSITORY));
+	if (status < 0)
+		return status;
 
 	/* No particular flag request, return here... */
 	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET)) {
@@ -3660,6 +3708,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	bool active_low = false;
 	bool single_ended = false;
 	bool open_drain = false;
+	bool transitory = false;
 	int ret;
 
 	if (!fwnode)
@@ -3674,6 +3723,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 			active_low = flags & OF_GPIO_ACTIVE_LOW;
 			single_ended = flags & OF_GPIO_SINGLE_ENDED;
 			open_drain = flags & OF_GPIO_OPEN_DRAIN;
+			transitory = flags & OF_GPIO_TRANSITORY;
 		}
 	} else if (is_acpi_node(fwnode)) {
 		struct acpi_gpio_info info;
@@ -3704,6 +3754,9 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 			lflags |= GPIO_OPEN_SOURCE;
 	}
 
+	if (transitory)
+		lflags |= GPIO_TRANSITORY;
+
 	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
 	if (ret < 0) {
 		gpiod_put(desc);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index af48322839c3..736b189d1bb5 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -205,7 +205,7 @@ struct gpio_desc {
 #define FLAG_OPEN_SOURCE 8	/* Gpio is open source type */
 #define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
 #define FLAG_IS_HOGGED	11	/* GPIO is hogged */
-#define FLAG_SLEEP_MAY_LOSE_VALUE 12	/* GPIO may lose value in sleep */
+#define FLAG_TRANSITORY 12	/* GPIO may lose value in sleep or reset */
 
 	/* Connection label */
 	const char		*label;
diff --git a/include/dt-bindings/gpio/gpio.h b/include/dt-bindings/gpio/gpio.h
index dd549ff04295..2cc10ae4bbb7 100644
--- a/include/dt-bindings/gpio/gpio.h
+++ b/include/dt-bindings/gpio/gpio.h
@@ -29,8 +29,8 @@
 #define GPIO_OPEN_DRAIN (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_DRAIN)
 #define GPIO_OPEN_SOURCE (GPIO_SINGLE_ENDED | GPIO_LINE_OPEN_SOURCE)
 
-/* Bit 3 express GPIO suspend/resume persistence */
-#define GPIO_SLEEP_MAINTAIN_VALUE 0
-#define GPIO_SLEEP_MAY_LOSE_VALUE 8
+/* Bit 3 express GPIO suspend/resume and reset persistence */
+#define GPIO_PERSISTENT 0
+#define GPIO_TRANSITORY 8
 
 #endif
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 7447d85dbe2f..540b2c142493 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -139,6 +139,7 @@ void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					int *value_array);
 
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
+int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
 
 int gpiod_is_active_low(const struct gpio_desc *desc);
 int gpiod_cansleep(const struct gpio_desc *desc);
@@ -431,6 +432,13 @@ static inline int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 	return -ENOSYS;
 }
 
+static inline int gpiod_set_transitory(struct gpio_desc *desc, bool transitory)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(1);
+	return -ENOSYS;
+}
+
 static inline int gpiod_is_active_low(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index 846be7c69a52..b2f2dc638463 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -10,8 +10,8 @@ enum gpio_lookup_flags {
 	GPIO_ACTIVE_LOW = (1 << 0),
 	GPIO_OPEN_DRAIN = (1 << 1),
 	GPIO_OPEN_SOURCE = (1 << 2),
-	GPIO_SLEEP_MAINTAIN_VALUE = (0 << 3),
-	GPIO_SLEEP_MAY_LOSE_VALUE = (1 << 3),
+	GPIO_PERSISTENT = (0 << 3),
+	GPIO_TRANSITORY = (1 << 3),
 };
 
 /**
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 1fe205582111..18a7f03e1182 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -31,7 +31,7 @@ enum of_gpio_flags {
 	OF_GPIO_ACTIVE_LOW = 0x1,
 	OF_GPIO_SINGLE_ENDED = 0x2,
 	OF_GPIO_OPEN_DRAIN = 0x4,
-	OF_GPIO_SLEEP_MAY_LOSE_VALUE = 0x8,
+	OF_GPIO_TRANSITORY = 0x8,
 };
 
 #ifdef CONFIG_OF_GPIO
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index ec6dadcc1fde..6c0680641108 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -94,6 +94,7 @@
  *	or latch delay (on outputs) this parameter (in a custom format)
  *	specifies the clock skew or latch delay. It typically controls how
  *	many double inverters are put in front of the line.
+ * @PIN_CONFIG_PERSIST_STATE: retain pin state across sleep or controller reset
  * @PIN_CONFIG_END: this is the last enumerator for pin configurations, if
  *	you need to pass in custom configurations to the pin controller, use
  *	PIN_CONFIG_END+1 as the base offset.
@@ -122,6 +123,7 @@ enum pin_config_param {
 	PIN_CONFIG_SLEEP_HARDWARE_STATE,
 	PIN_CONFIG_SLEW_RATE,
 	PIN_CONFIG_SKEW_DELAY,
+	PIN_CONFIG_PERSIST_STATE,
 	PIN_CONFIG_END = 0x7F,
 	PIN_CONFIG_MAX = 0xFF,
 };
-- 
2.14.1

