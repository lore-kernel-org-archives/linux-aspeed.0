From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 20 Oct 2017 14:07:22 +1030
Subject: [RFC PATCH 0/5] gpio: Expose reset tolerance capability
Message-ID: <20171020033727.21557-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series exposes a "reset tolerant" property for GPIOs. For example, the
controller implemented in Aspeed BMCs provides such a feature to allow the BMC
to be reset whilst maintaining necessary state to keep host systems alive or
status LEDs in-tact.

I'm sending it as an RFC because I'm not sure using pinconf is the right way
to go about it, or that expanding the sysfs interface is a good idea, or that
the approach taken is right in the context of the existing suspend support.
pinconf just ended up being a convenient abstraction whilst supporting the
sysfs change, and didn't feel unreasonable to use for devicetree or the chardev
interface either. My concern with using pinconf is that the reset-tolerant
property is (currently) GPIO-centric, but maybe that's not a worry.

So the patches in the series support configuring the property via devicetree,
the chardev interface and the sysfs interface. The sysfs interface also exposes
the ability to configure the suspend tolerance, though there are some ordering
requirements with respect to setting the direction (the suspend tolerance will
only take if configured before setting the pin direction on the Arizona
controller).

Please review!

Cheers,

Andrew

Andrew Jeffery (5):
  gpio: gpiolib: Add core support for maintaining GPIO values on reset
  gpio: gpiolib: Add OF support for maintaining GPIO values on reset
  gpio: gpiolib: Add chardev support for maintaining GPIO values on
    reset
  gpio: gpiolib: Add sysfs support for maintaining GPIO values on reset
  gpio: aspeed: Add support for reset tolerance

 Documentation/gpio/sysfs.txt            |  9 ++++
 drivers/gpio/gpio-arizona.c             |  4 +-
 drivers/gpio/gpio-aspeed.c              | 39 ++++++++++++++-
 drivers/gpio/gpiolib-of.c               |  2 +
 drivers/gpio/gpiolib-sysfs.c            | 88 +++++++++++++++++++++++++++++++--
 drivers/gpio/gpiolib.c                  | 74 +++++++++++++++++++++++++--
 drivers/gpio/gpiolib.h                  |  1 +
 include/dt-bindings/gpio/gpio.h         |  4 ++
 include/linux/gpio/consumer.h           |  9 ++++
 include/linux/gpio/driver.h             |  5 +-
 include/linux/gpio/machine.h            |  2 +
 include/linux/of_gpio.h                 |  1 +
 include/linux/pinctrl/pinconf-generic.h |  2 +
 include/uapi/linux/gpio.h               | 11 +++--
 14 files changed, 234 insertions(+), 17 deletions(-)

-- 
2.11.0

