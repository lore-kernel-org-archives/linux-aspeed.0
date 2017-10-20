From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Oct 2017 14:07:26 +1030
Subject: [RFC PATCH 4/5] gpio: gpiolib: Add sysfs support for maintaining GPIO
 values on reset
In-Reply-To: <20171020033727.21557-1-andrew@aj.id.au>
References: <20171020033727.21557-1-andrew@aj.id.au>
Message-ID: <20171020033727.21557-5-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Expose a new 'maintain' sysfs attribute to control both suspend and
reset tolerance.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/gpio/sysfs.txt |  9 +++++
 drivers/gpio/gpiolib-sysfs.c | 88 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/Documentation/gpio/sysfs.txt b/Documentation/gpio/sysfs.txt
index aeab01aa4d00..f447f0746884 100644
--- a/Documentation/gpio/sysfs.txt
+++ b/Documentation/gpio/sysfs.txt
@@ -96,6 +96,15 @@ and have the following read/write attributes:
 		for "rising" and "falling" edges will follow this
 		setting.
 
+	"maintain" ... displays and controls whether the state of the GPIO is
+		maintained or lost on suspend or reset. The valid values take
+	        the following meanings:
+
+	        0: Do not maintain state on either suspend or reset
+	        1: Maintain state for suspend only
+	        2: Maintain state for reset only
+	        3: Maintain state for both suspend and reset
+
 GPIO controllers have paths like /sys/class/gpio/gpiochip42/ (for the
 controller implementing GPIOs starting at #42) and have the following
 read-only attributes:
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 3f454eaf2101..bfa186e73e26 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -289,6 +289,74 @@ static ssize_t edge_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(edge);
 
+#define GPIOLIB_SYSFS_MAINTAIN_SUSPEND	BIT(0)
+#define GPIOLIB_SYSFS_MAINTAIN_RESET	BIT(1)
+#define GPIOLIB_SYSFS_MAINTAIN_ALL	GENMASK(1, 0)
+static ssize_t maintain_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct gpiod_data *data = dev_get_drvdata(dev);
+	ssize_t	status = 0;
+	int val = 0;
+
+	mutex_lock(&data->mutex);
+
+	if (!test_bit(FLAG_SLEEP_MAY_LOSE_VALUE, &data->desc->flags))
+		val |= GPIOLIB_SYSFS_MAINTAIN_SUSPEND;
+
+	if (test_bit(FLAG_RESET_TOLERANT, &data->desc->flags))
+		val |= GPIOLIB_SYSFS_MAINTAIN_RESET;
+
+	status = sprintf(buf, "%d\n", val);
+
+	mutex_unlock(&data->mutex);
+
+	return status;
+}
+
+static ssize_t maintain_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf,
+			      size_t size)
+{
+	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpio_chip *chip;
+	ssize_t	status;
+	long provided;
+
+	mutex_lock(&data->mutex);
+
+	chip = data->desc->gdev->chip;
+
+	if (!chip->set_config)
+		return -ENOTSUPP;
+
+	status = kstrtol(buf, 0, &provided);
+	if (status < 0)
+		goto out;
+
+	if (provided & ~GPIOLIB_SYSFS_MAINTAIN_ALL) {
+		status = -EINVAL;
+		goto out;
+	}
+
+	if (!(provided & GPIOLIB_SYSFS_MAINTAIN_SUSPEND))
+		set_bit(FLAG_SLEEP_MAY_LOSE_VALUE, &data->desc->flags);
+	else
+		clear_bit(FLAG_SLEEP_MAY_LOSE_VALUE,
+			  &data->desc->flags);
+
+	/* Configure reset tolerance */
+	status = gpiod_set_reset_tolerant(data->desc,
+			!!(provided & GPIOLIB_SYSFS_MAINTAIN_RESET));
+out:
+	mutex_unlock(&data->mutex);
+
+	return status ? : size;
+
+}
+static DEVICE_ATTR_RW(maintain);
+
 /* Caller holds gpiod-data mutex. */
 static int gpio_sysfs_set_active_low(struct device *dev, int value)
 {
@@ -378,6 +446,7 @@ static struct attribute *gpio_attrs[] = {
 	&dev_attr_edge.attr,
 	&dev_attr_value.attr,
 	&dev_attr_active_low.attr,
+	&dev_attr_maintain.attr,
 	NULL,
 };
 
@@ -474,11 +543,22 @@ static ssize_t export_store(struct class *class,
 			status = -ENODEV;
 		goto done;
 	}
-	status = gpiod_export(desc, true);
-	if (status < 0)
+
+	/*
+	 * If userspace is requesting the GPIO via sysfs, make them explicitly
+	 * configure reset tolerance each time by unconditionally disabling it
+	 * here, as the export and configuration steps are not atomic.
+	 */
+	status = gpiod_set_reset_tolerant(desc, false);
+	if (status < 0) {
 		gpiod_free(desc);
-	else
-		set_bit(FLAG_SYSFS, &desc->flags);
+	} else {
+		status = gpiod_export(desc, true);
+		if (status < 0)
+			gpiod_free(desc);
+		else
+			set_bit(FLAG_SYSFS, &desc->flags);
+	}
 
 done:
 	if (status)
-- 
2.11.0

