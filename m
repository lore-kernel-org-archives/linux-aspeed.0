From: Troy Lee <troy_lee@aspeedtech.com>
Date: Mon, 18 Jan 2021 06:50:48 +0000
Subject: [PATCH v3 0/4] hwmon: aspeed2600-pwm-tacho: Add driver support
Message-ID: <20210118065059.2478078-1-troy_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aspeed AST2600 is a server management SoC which has 16 PWM channels and
16 fan tacho channel.

This series of patch provides AST2600 PWM/Fan tacho support in hwmon
class.

The driver provides a sysfs interface, and user can configure PWM duty
cycle and read current FAN speed in RPM.

Changes since v2:
 - declare local function as static function
 - fixed dt binding yamllint warnings/errors
 - rename dt property property name from pwm-freq to pwm-freq-hz

Changes since v1:
 - dt-binding rewrote with dt schema format
 - register hwmon driver with devm_hwmon_device_register_with_info()
 - moving default configurations to device tree

Troy Lee (4):
  dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
  hwmon: Add Aspeed AST2600 support
  ARM: dts: aspeed: Add Aspeed AST2600 PWM/Fan node in devicetree
  hwmon: Support Aspeed AST2600 PWM/Fan tachometer

 .../hwmon/aspeed,ast2600-pwm-tachometer.yaml  | 131 +++
 .../hwmon/aspeed2600-pwm-tachometer.rst       |  27 +
 Documentation/hwmon/index.rst                 |   1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      | 152 ++++
 arch/arm/boot/dts/aspeed-g6.dtsi              |  10 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/aspeed2600-pwm-tacho.c          | 756 ++++++++++++++++++
 8 files changed, 1088 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-pwm-tachometer.yaml
 create mode 100644 Documentation/hwmon/aspeed2600-pwm-tachometer.rst
 create mode 100644 drivers/hwmon/aspeed2600-pwm-tacho.c


base-commit: 1d011777cdbe7ae38a854a0cbeb6bdfbf724cce0
-- 
2.25.1

