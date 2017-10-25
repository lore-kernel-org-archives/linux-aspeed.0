From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 25 Oct 2017 15:34:15 +1030
Subject: [PATCH 0/2] gpio: Expose reset tolerance capability
Message-ID: <20171025050417.27992-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series enables GPIO state persistence across controller resets,
modifying gpiolib to expose control of the behaviour and providing an initial
implementation in the Aspeed GPIO controller.

This is a follow-up to the initial RFC series[1], which had some undesirable
features (and bugs).

From the RFC, I've:

1. Dropped the idea of distinguishing between sleep and reset cases[2]
2. Changed the default behaviour from transitory to persistent (must explicitly
   request transitory behaviour for controllers supporting reset tolerance)[3]
3. Dropped the ability for userspace to configure whether or not the exported
   GPIO is persistent[4][5]

On point 2, whilst the patch modifying the sysfs interface ABI no-longer lives,
gpiolib-sysfs still requires modification to provide consistent behaviour with
the chardev interface in providing a default-persistent GPIO on export.

Regarding point 3, I figured this is something we can add later once there's
been some discussion on how much of a good idea it is.

As some of the capabilities in the RFC have been dropped, I've squashed the
gpiolib support into a single patch as it's not really that complex.

Hopefully that addresses the feedback on the RFC. Please review!

Andrew

[1] https://www.spinics.net/lists/devicetree/msg199559.html
[2] https://www.spinics.net/lists/devicetree/msg199566.html
[3] https://www.spinics.net/lists/devicetree/msg199574.html
[4] https://www.spinics.net/lists/devicetree/msg199568.html
[5] https://www.spinics.net/lists/devicetree/msg199569.html 

Andrew Jeffery (2):
  gpio: gpiolib: Expand sleep tolerance to include controller reset
  gpio: aspeed: Add support for reset tolerance

 drivers/gpio/gpio-aspeed.c              | 39 ++++++++++++++++++++--
 drivers/gpio/gpiolib-of.c               |  6 ++--
 drivers/gpio/gpiolib-sysfs.c            | 14 +++++---
 drivers/gpio/gpiolib.c                  | 58 ++++++++++++++++++++++++++++++---
 drivers/gpio/gpiolib.h                  |  2 +-
 include/dt-bindings/gpio/gpio.h         |  6 ++--
 include/linux/gpio/consumer.h           |  8 +++++
 include/linux/gpio/machine.h            |  4 +--
 include/linux/of_gpio.h                 |  2 +-
 include/linux/pinctrl/pinconf-generic.h |  2 ++
 10 files changed, 121 insertions(+), 20 deletions(-)

-- 
2.11.0

