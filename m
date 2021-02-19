From: Andrew Jeffery <andrew@aj.id.au>
Date: Sat, 20 Feb 2021 00:55:04 +1030
Subject: [PATCH 00/19] ipmi: Allow raw access to KCS devices
Message-ID: <20210219142523.3464540-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series is a bit of a mix of things, but its primary purpose is to
expose BMC KCS IPMI devices to userspace in a way that enables userspace
to talk to host firmware using protocols that are not IPMI.  The new
chardev implementation exposes the Input Data Register (IDR), Output
Data Register (ODR) and Status Register (STR) via read() and write(),
and implements poll() for event monitoring.

The existing /dev/ipmi-kcs* chardev interface exposes the KCS devices in
a way which encoded the IPMI protocol in its behaviour. However, as
LPC[0] KCS devices give us bi-directional interrupts between the host
and a BMC with both a data and status byte, they are useful for purposes
beyond IPMI.

As a concrete example, libmctp[1] implements a vendor-defined
host-interface MCTP[2] binding using a combination of LPC Firmware
cycles for bulk data transfer and a KCS device via LPC IO cycles for
out-of-band protocol control messages[3]. This gives a throughput
improvement over the standard KCS binding[4] while continuing to exploit
the ease of setup of the LPC bus for early boot firmware on the host
processor.

The series takes a bit of a winding path to achieve its aim:

1. It begins with patches 1-5 put together by Chia-Wei, which I've
rebased on v5.11. These fix the ASPEED LPC bindings and other non-KCS
LPC-related ASPEED device drivers in a way that enables the SerIRQ
patches at the end of the series. With Joel's review I'm hoping these 5
can go through the aspeed tree, and that the rest can go through the
IPMI tree.

2. Next, patches 6-13 fairly heavily refactor the KCS support in the
IPMI part of the tree, re-architecting things such that it's possible to
support multiple chardev implementations sitting on top of the ASPEED
and Nuvoton device drivers. However, the KCS code didn't really have
great separation of concerns as it stood, so even if we disregard the
multiple-chardev support I think the cleanups are worthwhile.

3. Patch 14 adds some interrupt management capabilities to the KCS
device drivers in preparation for patch 15, which introduces the new
"raw" KCS device interface. I'm not stoked about the device name/path,
so if people are looking to bikeshed something then feel free to lay
into that.

4. The remaining patches switch the ASPEED KCS devicetree binding to
dt-schema, add a new interrupt property to describe the SerIRQ behaviour
of the device and finally clean up Serial IRQ support in the ASPEED KCS
driver.

Rob: The dt-binding patches still come before the relevant driver
changes, I tried to keep the two close together in the series, hence the
bindings changes not being patches 1 and 2.

I've exercised the series under qemu with the rainier-bmc machine plus
some preliminary KCS support[5]. I've also substituted this series in
place of a hacky out-of-tree driver that we've been using for the
libmctp stack and successfully booted the host processor under our
internal full-platform simulation tools for a Rainier system.

Note that this work touches the Nuvoton driver as well as ASPEED's, but
I don't have the capability to test those changes or the IPMI chardev
path. Tested-by tags would be much appreciated if you can exercise one
or both.

Please review!

Andrew

[0] https://www.intel.com/content/dam/www/program/design/us/en/documents/low-pin-count-interface-specification.pdf
[1] https://github.com/openbmc/libmctp/
[2] https://www.dmtf.org/sites/default/files/standards/documents/DSP0236_1.3.1.pdf
[3] https://github.com/openbmc/libmctp/blob/master/docs/bindings/vendor-astlpc.md
[4] https://www.dmtf.org/sites/default/files/standards/documents/DSP0254_1.0.0.pdf
[5] https://github.com/amboar/qemu/tree/kcs

Andrew Jeffery (14):
  ipmi: kcs_bmc_aspeed: Use of match data to extract KCS properties
  ipmi: kcs_bmc: Make status update atomic
  ipmi: kcs_bmc: Rename {read,write}_{status,data}() functions
  ipmi: kcs_bmc: Split out kcs_bmc_cdev_ipmi
  ipmi: kcs_bmc: Turn the driver data-structures inside-out
  ipmi: kcs_bmc: Split headers into device and client
  ipmi: kcs_bmc: Strip private client data from struct kcs_bmc
  ipmi: kcs_bmc: Decouple the IPMI chardev from the core
  ipmi: kcs_bmc: Allow clients to control KCS IRQ state
  ipmi: kcs_bmc: Add a "raw" character device interface
  dt-bindings: ipmi: Convert ASPEED KCS binding to schema
  dt-bindings: ipmi: Add optional SerIRQ property to ASPEED KCS devices
  ipmi: kcs_bmc_aspeed: Implement KCS SerIRQ configuration
  ipmi: kcs_bmc_aspeed: Fix IBFIE typo from datasheet

Chia-Wei, Wang (5):
  dt-bindings: aspeed-lpc: Remove LPC partitioning
  ARM: dts: Remove LPC BMC and Host partitions
  ipmi: kcs: aspeed: Adapt to new LPC DTS layout
  pinctrl: aspeed-g5: Adapt to new LPC device tree layout
  soc: aspeed: Adapt to new LPC device tree layout

 Documentation/ABI/testing/dev-raw-kcs         |  25 +
 .../bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml | 106 ++++
 .../bindings/ipmi/aspeed-kcs-bmc.txt          |  33 -
 .../devicetree/bindings/mfd/aspeed-lpc.txt    | 100 +--
 arch/arm/boot/dts/aspeed-g4.dtsi              |  68 +--
 arch/arm/boot/dts/aspeed-g5.dtsi              | 119 ++--
 arch/arm/boot/dts/aspeed-g6.dtsi              | 121 ++--
 drivers/char/ipmi/Kconfig                     |  30 +
 drivers/char/ipmi/Makefile                    |   2 +
 drivers/char/ipmi/kcs_bmc.c                   | 532 +++++-----------
 drivers/char/ipmi/kcs_bmc.h                   |  94 +--
 drivers/char/ipmi/kcs_bmc_aspeed.c            | 536 ++++++++++------
 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c         | 570 ++++++++++++++++++
 drivers/char/ipmi/kcs_bmc_cdev_raw.c          | 442 ++++++++++++++
 drivers/char/ipmi/kcs_bmc_client.h            |  47 ++
 drivers/char/ipmi/kcs_bmc_device.h            |  20 +
 drivers/char/ipmi/kcs_bmc_npcm7xx.c           |  98 ++-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c    |  17 +-
 drivers/soc/aspeed/aspeed-lpc-ctrl.c          |  20 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c         |  23 +-
 20 files changed, 2021 insertions(+), 982 deletions(-)
 create mode 100644 Documentation/ABI/testing/dev-raw-kcs
 create mode 100644 Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
 create mode 100644 drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
 create mode 100644 drivers/char/ipmi/kcs_bmc_cdev_raw.c
 create mode 100644 drivers/char/ipmi/kcs_bmc_client.h
 create mode 100644 drivers/char/ipmi/kcs_bmc_device.h

-- 
2.27.0

