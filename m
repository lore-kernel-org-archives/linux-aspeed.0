From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 29 Sep 2021 04:54:02 -0700
Subject: [PATCH 0/6] Dynamic aspeed-smc flash chips via "reserved" DT status
Message-ID: <20210929115409.21254-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This patch series aims to improve a scenario that arises in OpenBMC
and which isn't handled very well at the moment.  Certain devices, the
example at hand being the flash chip used to store the host's firmware
(e.g. the BIOS), may be shared between the BMC and the host system but
only available to one or the other at any given time.  The device may
thus be effectively off-limits to the BMC when it boots, and only
usable after userspace performs the necessary steps to coordinate
appropriately with the host (tracking its power state, twiddling
GPIOs, sending IPMI commands, etc.).

Neither the "okay" nor the "disabled" device-tree status values works
nicely for the flash device this case -- an "okay" device gets probed
automatically as soon as the device and a driver for it are available,
and a "disabled" one gets forgotten about entirely, whereas we want
the BMC's kernel to be aware of the existence of the device, but not
try to actually do anything with it (i.e. probe it) until explicitly
requested to do so by userspace.

However, while there's no support for it currently in the kernel tree,
the device-tree spec [0] also lists "reserved" as a possible status
value, and its description seems like a fairly reasonable fit for this
situation:

  Indicates that the device is operational, but should not be used.
  Typically this is used for devices that are controlled by another
  software component, such as platform firmware.

These patches start making use of this status value in the aspeed-smc
driver.  The first patch adds a companion routine to
of_device_is_available() that checks for a "reserved" status instead
of "okay".  The second patch is a small MTD adjustment to allow an
unregistered device to be cleanly re-registered.  Patches 3 through 5
modify the aspeed-smc driver to allow individual chips to be attached
and detached at runtime, and to avoid automatically attaching any
marked as reserved.  Finally, patch 6 employs the newly-supported
status in adding support for the BIOS flash device to the ASRock Rack
e3c246d4i BMC.


Thanks,
Zev

[0] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.3/devicetree-specification-v0.3.pdf

Zev Weiss (6):
  of: base: Add function to check for status = "reserved"
  mtd: core: clear out unregistered devices a bit more
  mtd: spi-nor: aspeed: Refactor registration/unregistration
  mtd: spi-nor: aspeed: Allow attaching & detaching chips at runtime
  mtd: spi-nor: aspeed: Don't automatically attach reserved chips
  ARM: dts: aspeed: Add e3c246d4i BIOS flash device

 .../ABI/stable/sysfs-driver-aspeed-smc        |  17 ++
 .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  |  16 ++
 drivers/mtd/mtdcore.c                         |   7 +-
 drivers/mtd/spi-nor/controllers/aspeed-smc.c  | 177 +++++++++++++++---
 drivers/of/base.c                             |  53 +++++-
 include/linux/of.h                            |   6 +
 6 files changed, 238 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-aspeed-smc

-- 
2.33.0

