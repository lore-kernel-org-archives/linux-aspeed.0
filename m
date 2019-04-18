From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Apr 2019 12:58:14 -0700
Subject: [PATCH 0/6] thermal: Introduce devm_thermal_of_cooling_device_register
Message-ID: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

thermal_of_cooling_device_register() and thermal_cooling_device_register()
are typically called from driver probe functions, and
thermal_cooling_device_unregister() is called from remove functions. This
makes both a perfect candidate for device managed functions.

Introduce devm_thermal_of_cooling_device_register(). This function can
also be used to replace thermal_cooling_device_register() by passing a NULL
pointer as device node. The new function requires both struct device *
and struct device_node * as parameters since the struct device_node *
parameter is not always identical to dev->of_node.

Don't introduce a device managed remove function since it is not needed
at this point.

The patch series introduces the new function and then converts various
hwmon drivers to use it.
