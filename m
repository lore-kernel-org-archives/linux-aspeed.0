From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 8 Jan 2024 15:43:45 +0800
Subject: [PATCH v12 0/3] Support pwm/tach driver for aspeed ast26xx
Message-ID: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Unlike the old design that the register setting of the TACH should based
on the configure of the PWM. In ast26xx, the dependency between pwm and
tach controller is eliminated and becomes a separate hardware block. One
is used to provide pwm output and another is used to monitor the frequency
of the input. This driver implements them by exposing two kernel
subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
existing drivers for controlling elements such as fans (pwm-fan.c),
beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
provides sysfs interfaces for fan.

Changes since v11:
Fix the compiler error of the driver.
The owner member has to be moved to struct pwm_chip.

Changes since v10:
Add the enum for the 'fan-driving-mode' properties in the fan-common.yaml.

Changes since v9:
Change the type of fan-driving-mode to string
Fix some typos and formatting issues.

Changes since v8:
Fix the fail of fan div register setting. (FIELD_GET -> FIELD_PREP)
Change the type of tach-ch from uint32_t to uint8-array
Add additional properties and apply constraints to certain properties.

Changes since v7:
Cherry-pick the fan-common.yaml and add the following properties:
- min-rpm
- div
- mode
- tach-ch
Fix the warning which is reported by the kernel test robot.

Changes since v6:
Consolidate the PWM and TACH functionalities into a unified driver.

Changes since v5:
- pwm/tach:
  - Remove the utilization of common resources from the parent node.
  - Change the concept to 16 PWM/TACH controllers, each with one channel,
  instead of 1 PWM/TACH controller with 16 channels.
- dt-binding:
  - Eliminate the usage of simple-mfd.

Changes since v4:
- pwm:
  - Fix the return type of get_status function.
- tach:
  - read clk source once and re-use it
  - Remove the constants variables
  - Allocate tach_channel as array
  - Use dev->parent
- dt-binding:
  - Fix the order of the patches
  - Add example and description for tach child node
  - Remove pwm extension property

Changes since v3:
- pwm:
  - Remove unnecessary include header
  - Fix warning Prefer "GPL" over "GPL v2"
- tach:
  - Remove the paremeter min_rpm and max_rpm and return the tach value 
  directly without any polling or delay.
  - Fix warning Prefer "GPL" over "GPL v2"
- dt-binding:
  - Replace underscore in node names with dashes
  - Split per subsystem

Changes since v2:
- pwm:
  - Use devm_* api to simplify the error cleanup
  - Fix the multi-line alignment problem
- tach:
  - Add tach-aspeed-ast2600 to index.rst
  - Fix the multi-line alignment problem
  - Remove the tach enable/disable when read the rpm
  - Fix some coding format issue

Changes since v1:
- tach:
  - Add the document tach-aspeed-ast2600.rst
  - Use devm_* api to simplify the error cleanup.
  - Change hwmon register api to devm_hwmon_device_register_with_info

Billy Tsai (2):
  dt-bindings: hwmon: Support Aspeed g6 PWM TACH Control
  hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach

Naresh Solanki (1):
  dt-bindings: hwmon: fan: Add fan binding to schema

 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    |  69 +++
 .../devicetree/bindings/hwmon/fan-common.yaml |  79 +++
 Documentation/hwmon/aspeed-g6-pwm-tach.rst    |  26 +
 Documentation/hwmon/index.rst                 |   1 +
 drivers/hwmon/Kconfig                         |  11 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/aspeed-g6-pwm-tach.c            | 538 ++++++++++++++++++
 7 files changed, 725 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/hwmon/aspeed-g6-pwm-tach.rst
 create mode 100644 drivers/hwmon/aspeed-g6-pwm-tach.c

-- 
2.25.1

