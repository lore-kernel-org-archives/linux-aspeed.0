From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 31 Oct 2022 18:38:05 +0800
Subject: [PATCH 0/3] Support pwm/tach driver for aspeed ast26xx
Message-ID: <20221031103809.20225-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Unlike the old design that the register setting of the TACH should based
on the configure of the PWM. In ast26xx, the dependency between pwm and
tach controller is eliminated and becomes a separate hardware block. One
is used to provide pwm output and another is used to monitor the frequency
of the input. Therefore, this patch serials implements them by writing the
two driver "pwm-aspeed-ast2600.c" and "tach-aspeed-ast2600.c". The former
is following the pwm subsystem which can apply the existed driver to
controller the fan(pwm-fan.c), beeper(pwm-beeper.c) and so on. The latter
is following the sysfs interface of hwmon to creat the node for fan
monitor.

Billy Tsai (3):
  dt-bindings: Add bindings for aspeed pwm-tach.
  pwm: Add Aspeed ast2600 PWM support
  hwmon: Add Aspeed ast2600 TACH support

 .../bindings/hwmon/aspeed,ast2600-tach.yaml   |  48 ++
 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml |  76 ++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      |  64 ++
 drivers/hwmon/Kconfig                         |   9 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tach-aspeed-ast2600.c           | 692 ++++++++++++++++++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-aspeed-ast2600.c              | 325 ++++++++
 9 files changed, 1226 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
 create mode 100644 drivers/hwmon/tach-aspeed-ast2600.c
 create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c

-- 
2.25.1

