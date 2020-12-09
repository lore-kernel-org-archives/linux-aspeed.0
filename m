From: Troy Lee <troy_lee@aspeedtech.com>
Date: Wed, 9 Dec 2020 15:59:16 +0800
Subject: [PATCH 0/4] hwmon: aspeed2600-pwm-tacho: Add driver support
Message-ID: <20201209075921.26689-1-troy_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aspeed AST2600 is a server management SoC which has 16 PWM channels and 
16 fan tacho channel.

This series of patch provides AST2600 PWM/Fan tacho support in hwmon class.

The driver provides a sysfs interface, and user can configure PWM duty cycle
and read current FAN speed in RPM.

Troy Lee (4):
  dt-bindings: hwmon: Add Aspeed AST2600 PWM/Fan
  ARM: dts: aspeed: Add Aspeed AST2600 PWM/Fan node in devicetree
  hwmon: Add Aspeed AST2600 support
  hwmon: Support Aspeed AST2600 PWM/Fan tachometer

 .../bindings/hwmon/aspeed2600-pwm-tacho.txt   |   69 ++
 Documentation/hwmon/aspeed_pwm_tachometer.rst |   24 +
 Documentation/hwmon/index.rst                 |    1 +
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      |  149 +++
 arch/arm/boot/dts/aspeed-g6.dtsi              |   10 +
 drivers/hwmon/Kconfig                         |   10 +
 drivers/hwmon/Makefile                        |    1 +
 drivers/hwmon/aspeed2600-pwm-tacho.c          | 1053 +++++++++++++++++
 8 files changed, 1317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed2600-pwm-tacho.txt
 create mode 100644 Documentation/hwmon/aspeed_pwm_tachometer.rst
 create mode 100644 drivers/hwmon/aspeed2600-pwm-tacho.c

-- 
2.17.1

