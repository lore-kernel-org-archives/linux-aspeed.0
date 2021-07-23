From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 23 Jul 2021 17:28:53 +0930
Subject: [RFC PATCH 1/6] pinctrl: Add pinctrl_gpio_as_pin()
In-Reply-To: <20210723075858.376378-1-andrew@aj.id.au>
References: <20210723075858.376378-1-andrew@aj.id.au>
Message-ID: <20210723075858.376378-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Allow gpiochips to map the GPIO numberspace onto a pin numberspace when
the register layout for GPIO control is implemented in terms of the
pin numberspace.

This requirement sounds kind of strange, but the patch is driven by
trying to resolve a bug in the leds-pca955x driver where this mapping is
not correctly performed.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/core.c          | 19 +++++++++++++++++++
 include/linux/pinctrl/pinctrl.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index a4ac87c8b4f8..9c788f0e2844 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -738,6 +738,25 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 	return -EINVAL;
 }
 
+int pinctrl_gpio_as_pin(struct pinctrl_dev *pctldev, unsigned int gpio)
+{
+	struct pinctrl_gpio_range *range;
+	int pin;
+
+	range = pinctrl_match_gpio_range(pctldev, gpio);
+	if (!range)
+		return -ENODEV;
+
+	mutex_lock(&pctldev->mutex);
+
+	pin = gpio_to_pin(range, gpio);
+
+	mutex_unlock(&pctldev->mutex);
+
+	return pin;
+}
+EXPORT_SYMBOL_GPL(pinctrl_find_gpio_range_from_pin);
+
 bool pinctrl_gpio_can_use_line(unsigned gpio)
 {
 	struct pinctrl_dev *pctldev;
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 70b45d28e7a9..1ceebc499cc4 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -182,6 +182,9 @@ extern struct pinctrl_dev *pinctrl_find_and_add_gpio_range(const char *devname,
 extern struct pinctrl_gpio_range *
 pinctrl_find_gpio_range_from_pin(struct pinctrl_dev *pctldev,
 				 unsigned int pin);
+
+extern int pinctrl_gpio_as_pin(struct pinctrl_dev *pctldev, unsigned int gpio);
+
 extern int pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 				const char *pin_group, const unsigned **pins,
 				unsigned *num_pins);
-- 
2.30.2

