From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 29 Nov 2019 18:25:31 +0100
Subject: [PATCH v3 0/6] DA9062 PMIC features
Message-ID: <20191129172537.31410-1-m.felsch@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

this series address all comments made on [1]. Patch "gpio: add support
to get local gpio number" is splitted into:
 - "gpio: treewide rename gpio_chip_hwgpio to gpiod_to_offset"
 - "gpio: make gpiod_to_offset() available for other users"
Please check the discussion [1] for more information. You need to apply
[2] to test the new features.

[1] https://lore.kernel.org/lkml/20191127135932.7223-1-m.felsch at pengutronix.de/
[2] https://lore.kernel.org/linux-gpio/20191129165817.20426-1-m.felsch at pengutronix.de/T/#m3da1fb0d16a37979c74bbcebdb29f3da9e89a9ac

Marco Felsch (6):
  gpio: treewide rename gpio_chip_hwgpio to gpiod_to_offset
  gpio: make gpiod_to_offset() available for other users
  dt-bindings: mfd: da9062: add regulator voltage selection
    documentation
  regulator: da9062: add voltage selection gpio support
  dt-bindings: mfd: da9062: add regulator gpio enable/disable
    documentation
  regulator: da9062: add gpio based regulator dis-/enable support

 .../devicetree/bindings/mfd/da9062.txt        |  16 ++
 drivers/gpio/gpio-aspeed.c                    |  15 +-
 drivers/gpio/gpiolib-sysfs.c                  |   9 +-
 drivers/gpio/gpiolib.c                        |  74 +++--
 drivers/gpio/gpiolib.h                        |   8 -
 drivers/regulator/da9062-regulator.c          | 258 ++++++++++++++++++
 include/linux/gpio/private.h                  |  27 ++
 7 files changed, 361 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/gpio/private.h

-- 
2.20.1

