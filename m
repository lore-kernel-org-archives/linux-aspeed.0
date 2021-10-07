From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed,  6 Oct 2021 17:09:45 -0700
Subject: [PATCH 0/9] Dynamic DT device nodes
Message-ID: <20211007000954.30621-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This patch series is in some ways kind of a v2 for the "Dynamic
aspeed-smc flash chips via 'reserved' DT status" series I posted
previously [0], but takes a fairly different approach suggested by Rob
Herring [1] and doesn't actually touch the aspeed-smc driver or
anything in the MTD subsystem, so I haven't marked it as such.

To recap a bit of the context from that series, in OpenBMC there's a
need for certain devices (described by device-tree nodes) to be able
to be attached and detached at runtime (for example the SPI flash for
the host's firmware, which is shared between the BMC and the host but
can only be accessed by one or the other at a time).  To provide that
ability, this series adds support for a new common device-tree
property, a boolean "dynamic" that indicates that the device may come
and go at runtime.  When present on a node, the sysfs file for that
node's "status" property is made writable, allowing userspace to do
things like:

  $ echo okay > /sys/firmware/devicetree/.../status
  $ echo reserved > /sys/firmware/devicetree/.../status

to activate and deactivate a dynamic device.

Because it leans on the OF_DYNAMIC machinery internally, this
functionality will only work on busses that register for OF reconfig
notifications and handle them appropriately (presently platform, i2c,
and spi).  This series does not attempt to solve the "dynamic devices
further down the tree" problem [2]; my hope is that handling for OF
reconfig notifications can be extended to other families of devices
(e.g. individual MTD spi-nor flash chips) in the future.

The central change of the series is patch 6; patches 1-5 are various
small infrastructure bits and plumbing tweaks in preparation for #6;
patches 7-9 are Kconfig, documentation, and an inaugural use of the
new property in the ASRock e3c246d4i BMC device tree.

Note that this series requires the duplicate-declaration removal patch
that was recently merged in Rob's tree [3]; it changes one of the
duplicated declarations and hence will not compile without that patch
(because the declarations no longer match).

[0] https://lore.kernel.org/openbmc/20210929115409.21254-1-zev at bewilderbeest.net/
[1] https://lore.kernel.org/openbmc/CAL_JsqJH+b5oFuSP+KBLBsN5QTA6xASuqXJWXUaDkHhugXPpnQ at mail.gmail.com/
[2] https://lore.kernel.org/openbmc/20210929220038.GS17315 at packtop/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?id=6663ae07d995f5fbe2988a19858b2f87e68cf929

Zev Weiss (9):
  sysfs: add sysfs_remove_bin_file_self() function
  sysfs: add growable flag to struct bin_attribute
  lib/string: add sysfs_buf_streq()
  of: add self parameter to __of_sysfs_remove_bin_file()
  of: add self parameter to of_update_property()
  of: add support for 'dynamic' DT property
  of: make OF_DYNAMIC selectable independently of OF_UNITTEST
  dt-bindings: document new 'dynamic' common property
  ARM: dts: aspeed: Add e3c246d4i BIOS flash device

 .../devicetree/bindings/common-properties.txt | 18 ++++
 .../boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  | 23 ++++++
 drivers/of/Kconfig                            |  8 +-
 drivers/of/base.c                             |  7 +-
 drivers/of/dynamic.c                          |  2 +-
 drivers/of/kobj.c                             | 82 +++++++++++++++++--
 drivers/of/of_private.h                       |  6 +-
 fs/sysfs/file.c                               | 15 +++-
 include/linux/of.h                            |  7 +-
 include/linux/string.h                        |  1 +
 include/linux/sysfs.h                         |  2 +
 lib/string.c                                  | 34 ++++++++
 12 files changed, 187 insertions(+), 18 deletions(-)

-- 
2.33.0

