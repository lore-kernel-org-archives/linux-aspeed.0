From: Eddie James <eajames@linux.ibm.com>
Date: Wed,  5 Jun 2024 16:22:32 -0500
Subject: [PATCH v4 00/40] fsi: Add interrupt support
Message-ID: <20240605212312.349188-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series primarily adds interrupt support to the FSI driver subsystem.
There are a number of related changes and fixes. Firstly, the FSI clocking
model is improved to allow FSI engine drivers to obtain real clock rates
and calculate appropriate clock dividers. Secondly, much master code is
made common through the use of a regmap to access master registers. This
will prove more useful as additional FSI master drivers are added. Lastly,
interrupt support is added to the FSI I2C driver.

Changes since v3:
 - Fix compile warnings due to non-static local function and incorrect use
   of handle_irq_desc

Changes since v2:
 - Add several patches to fix additional issues found during testing
 - For local bus frequenccy, use cfam clock-frequency property instead of
   hardcoded master local bus divider
 - Change default local bus clock divider from 8 to 2
 - Zero the regmap_config structure in the common FSI initialization
   function
 - Add AST2700 direct AHB access of master registers
 - Remove slave interrupt handler since it's not used yet
 - For I2C driver, change minimum clock div to 3, use DIV_ROUND_UP instead
   of re-implementing it, and use better logic for checking for
   clock-frequency property
 - Add detail to I2C driver formatting change

Eddie James (40):
  fsi: hub: Set master index to link number plus one
  fsi: Move slave definitions to fsi-slave.h
  fsi: Fix slave addressing after break command
  fsi: Use a defined value for default echo delay
  fsi: Calculate local bus clock frequency
  fsi: core: Improve master read/write/error traces
  fsi: core: Add slave error trace
  fsi: core: Reset errors instead of clearing interrupts
  fsi: aspeed: Add AST2700 support
  fsi: core: Add slave spinlock
  fsi: core: Allow cfam device type aliases
  fsi: core: Add common regmap master functions
  fsi: core: Disable relative addressing during scan
  fsi: hub: Use common initialization and link enable
  fsi: aspeed: Use common initialization and link enable
  fsi: aspeed: Remove cfam reset sysfs file in error path and remove
  fsi: aspeed: Refactor trace functions
  fsi: aspeed: Don't clear all IRQs during OPB transfers
  fsi: aspeed: Only read result register for successful read
  fsi: aspeed: Switch to spinlock
  fsi: aspeed: Disable relative addressing and IPOLL for cfam reset
  fsi: aspeed: Use common master error handler
  fsi: core: Add interrupt support
  fsi: aspeed: Add interrupt support
  fsi: hub: Add interrupt support
  i2c: fsi: Calculate clock divider from local bus frequency
  i2c: fsi: Improve formatting
  i2c: fsi: Change fsi_i2c_write_reg to accept data instead of a pointer
  i2c: fsi: Remove list structure of ports
  i2c: fsi: Define a function to check status error bits
  i2c: fsi: Add boolean for skip stop command on abort
  i2c: fsi: Add interrupt support
  fsi: hub master: Reset hub master after errors
  fsi: core: Add master register read-only sysfs
  fsi: core: Add slave register read-only sysfs
  fsi: i2cr: Adjust virtual CFAM ID to match Odyssey chip
  fsi: core: Add different types of CFAM
  spi: fsi: Calculate clock divider from local bus frequency
  ARM: dts: aspeed: P10 and tacoma: Set FSI clock frequency
  ARM: dts: aspeed: P10: Bump SPI max frequencies

 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |  32 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |   1 +
 .../arm/boot/dts/aspeed/ibm-power10-dual.dtsi |  17 +-
 .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi |  16 +-
 drivers/fsi/Kconfig                           |   2 +
 drivers/fsi/fsi-core.c                        | 888 +++++++++++++++---
 drivers/fsi/fsi-master-aspeed.c               | 431 +++++----
 drivers/fsi/fsi-master-hub.c                  | 244 ++---
 drivers/fsi/fsi-master-i2cr.c                 |   2 +-
 drivers/fsi/fsi-master.h                      |  33 +
 drivers/fsi/fsi-slave.h                       | 117 +++
 drivers/i2c/busses/i2c-fsi.c                  | 463 ++++++---
 drivers/spi/spi-fsi.c                         |  33 +-
 include/linux/fsi.h                           |   3 +
 include/trace/events/fsi.h                    | 171 ++--
 include/trace/events/fsi_master_aspeed.h      |  86 +-
 include/trace/events/i2c_fsi.h                |  45 +
 17 files changed, 1897 insertions(+), 687 deletions(-)
 create mode 100644 include/trace/events/i2c_fsi.h

-- 
2.39.3

