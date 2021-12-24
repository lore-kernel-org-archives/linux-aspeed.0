From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Fri, 24 Dec 2021 11:13:43 +0700
Subject: [PATCH v6 0/9] Add Ampere's Altra SMPro MFD and its child drivers
Message-ID: <20211224041352.29405-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The SMpro co-processor on Ampere Altra processor family is to monitor
and report various data included hwmon-related info, RAS errors, and
other miscellaneous information. The SMPro MFD driver intializes the
register map and instantiates all sub-devices. All the specifics will
be handled in the child drivers.

This patch set includes support for Ampere SMpro hwmon, errmon, and
misc as the child drivers. The hwmon driver supports accessing various
CPU sensors provided by the SMpro co-processor including temperature,
power, voltages, and current found on Ampere Altra processor family.
The errmon driver supports monitoring and reporting RAS-related errors.
The misc driver is to support reporting boot progress and other
miscellaneous information.

v6:
  + Introduced smpro-errmon, smpro-misc as smpro-mfd sub-device [Quan]
  + Comments for v5: https://lkml.org/lkml/2021/7/13/49

v5:
  + Introduced the smpro-mfd driver and drop the use of
  simple-mfd-i2c driver to avoid DT node with no resource in child
  device DT nodes [Rob]
  + Removed the use of reg DT property in child driver [Quan]
  + Validated ManufactureID when probing smpro-mfd drivers [Quan]
  + As child devices are instantiated by SMPro MFD driver, drop the
  ManufacturerID checking in child driver, ie: smpro-hwmon [Quan]
  + Revised commit messages [Quan]

v4:
  + Revised commit message [Quan]
  + Fixed build issue found by kernel test robot [Guenter]
  + Returned regmap_read() error code [Guenter]

v3:
  + Supported list of compatible string [Rob]
  + Introduced reg property in DT to specify reg offset [Rob]
  + Updated description and other minor changes in yaml file [Rob]
  + Handled negative temperature value [Guenter]
  + Returned -ENODEV if Manufacturer ID is wrong [Guenter]
  + Refactored smpro_read_string() and smpro_temp_read() [Guenter]
  + Removed smpro_write() function [Guenter]
  + Added minor refactor changes [Quan]

v2:
  + Used 'struct of_device_id's .data attribute [Lee Jones]
  + Removed "virtual" sensors [Guenter]
  + Fixed typo "mili" to "milli", "nanoWatt" to "microWatt" [Guenter]
  + Reported SOC_TDP as "Socket TDP" using max attributes [Guenter]
  + Clarified "highest" meaning in documentation [Guenter]
  + Corrected return error code when host is turn off [Guenter]
  + Reported MEM HOT Threshold for all DIMMs as temp*_crit [Guenter]
  + Removed license info as SPDX-License-Identifier existed [Guenter]
  + Added is_visible() support [Guenter]
  + Used HWMON_CHANNEL_INFO() macro and LABEL attributes [Guenter]
  + Made is_valid_id() return boolean [Guenter]
  + Returned -EPROBE_DEFER when smpro reg inaccessible [Guenter]
  + Removed unnecessary error message when dev register fail [Guenter]
  + Removed Socket TDP sensor [Quan]
  + Changed "ampere,ac01-smpro" to "ampere,smpro" [Quan]
  + Included sensor type and channel in labels [Quan]
  + Refactorized code to fix checkpatch.pl --strict complaint [Quan]

Quan Nguyen (9):
  dt-bindings: mfd: Add bindings for Ampere Altra SMPro MFD driver
  mfd: smpro-mfd: Adds Ampere's Altra SMpro MFD driver
  hwmon: smpro: Add Ampere's Altra smpro-hwmon driver
  docs: hwmon: (smpro-hwmon) Add documentation
  regmap: Introduces regmap lock helpers
  misc: smpro-errmon: Add Ampere's SMpro error monitor driver
  docs: misc-devices: (smpro-errmon) Add documentation
  misc: smpro-misc: Add Ampere's Altra SMpro misc driver
  docs: misc-devices: (smpro-misc) Add documentation

 .../devicetree/bindings/mfd/ampere,smpro.yaml |  48 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/smpro-hwmon.rst           | 101 ++++
 Documentation/misc-devices/index.rst          |   2 +
 Documentation/misc-devices/smpro-errmon.rst   | 206 +++++++
 Documentation/misc-devices/smpro-misc.rst     |  82 +++
 drivers/base/regmap/regmap.c                  |  12 +
 drivers/hwmon/Kconfig                         |   8 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/smpro-hwmon.c                   | 463 ++++++++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/smpro-mfd.c                       |  78 +++
 drivers/misc/Kconfig                          |  14 +
 drivers/misc/Makefile                         |   2 +
 drivers/misc/smpro-errmon.c                   | 571 ++++++++++++++++++
 drivers/misc/smpro-misc.c                     | 177 ++++++
 include/linux/regmap.h                        |   2 +
 18 files changed, 1781 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
 create mode 100644 Documentation/hwmon/smpro-hwmon.rst
 create mode 100644 Documentation/misc-devices/smpro-errmon.rst
 create mode 100644 Documentation/misc-devices/smpro-misc.rst
 create mode 100644 drivers/hwmon/smpro-hwmon.c
 create mode 100644 drivers/mfd/smpro-mfd.c
 create mode 100644 drivers/misc/smpro-errmon.c
 create mode 100644 drivers/misc/smpro-misc.c

-- 
2.28.0

