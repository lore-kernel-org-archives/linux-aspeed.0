From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 25 Feb 2021 17:18:50 +0700
Subject: [PATCH 0/4] Add Ampere's Altra SMPro hwmon driver
Message-ID: <20210225101854.13896-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series adds support for Ampere SMpro hwmon driver. This driver
supports accessing various CPU sensors provided by the SMpro co-processor
including temperature, power, voltages, and current found on Ampere
Altra processor family.

Quan Nguyen (4):
  dt-bindings: mfd: Add bindings for Ampere Altra SMPro drivers
  mfd: simple-mfd-i2c: Adds Ampere's Altra SMpro support
  hwmon: smpro: Add Ampere's Altra smpro-hwmon driver
  docs: hwmon: (smpro-hwmon) Add documentation

 .../bindings/hwmon/ampere,ac01-hwmon.yaml     |  27 +
 .../bindings/mfd/ampere,ac01-smpro.yaml       |  82 +++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/smpro-hwmon.rst           | 100 +++
 drivers/hwmon/Kconfig                         |   8 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/smpro-hwmon.c                   | 620 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/simple-mfd-i2c.c                  |  15 +-
 9 files changed, 862 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ampere,ac01-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ampere,ac01-smpro.yaml
 create mode 100644 Documentation/hwmon/smpro-hwmon.rst
 create mode 100644 drivers/hwmon/smpro-hwmon.c

-- 
2.28.0

