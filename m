From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 22 Apr 2021 16:08:39 +0700
Subject: [PATCH v4 0/4] Add Ampere's Altra SMPro hwmon driver
Message-ID: <20210422090843.4614-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series adds support for Ampere SMpro hwmon driver. This
driver supports accessing various CPU sensors provided by the SMpro
co-processor including temperature, power, voltages, and current found
on Ampere Altra processor family.

The SMpro co-processor on Ampere Altra processor family is to monitor
and report various data included hwmon-related info, RAS errors, and
other miscellaneous information. This parent SMPro MFD driver creates
a single simple register map to be shared by all sub-devices and leave
all the specific to be handled by the child drivers.

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

Quan Nguyen (4):
  dt-bindings: mfd: Add bindings for Ampere Altra SMPro drivers
  mfd: simple-mfd-i2c: Adds Ampere's Altra SMpro support
  hwmon: smpro: Add Ampere's Altra smpro-hwmon driver
  docs: hwmon: (smpro-hwmon) Add documentation

 .../bindings/hwmon/ampere,ac01-hwmon.yaml     |  28 +
 .../devicetree/bindings/mfd/ampere,smpro.yaml | 105 ++++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/smpro-hwmon.rst           | 101 ++++
 drivers/hwmon/Kconfig                         |   8 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/smpro-hwmon.c                   | 491 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/simple-mfd-i2c.c                  |   6 +
 9 files changed, 752 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
 create mode 100644 Documentation/hwmon/smpro-hwmon.rst
 create mode 100644 drivers/hwmon/smpro-hwmon.c

-- 
2.28.0

