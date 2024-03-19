From: Manojkiran Eda <manojkiran.eda@gmail.com>
Date: Tue, 19 Mar 2024 09:35:25 -0000
Subject: [PATCH v2 0/4] Add eSPI device driver (flash channel)
Message-ID: <20240319093405.39833-1-manojkiran.eda@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello everyone,

I'm presenting a revised version of the eSPI device driver patch series found at
the following link:

https://lore.kernel.org/openbmc/20220516005412.4844-1-chiawei_wang at aspeedtech.com/

This update addresses the issues identified during the review process.

While the previous patch series attempted to incorporate support for all four
different channels of eSPI using the ioctl interface , this new series focuses
on upstreaming the flash channel (using the mtd interface) initially, ensuring
that all review comments are duly addressed, before progressing further.

Diff between PACTH v1-v2:
1. The commit is split into multiple commits as per the review comments.
2. Explicity renamed the driver to indicate that it only support master attached
flash storage (mafs).
3. Added new kconfig options to enable/disable eSPI mafs support.


Results:

Successfully conducted a flash update via eSPI.




Manojkiran Eda (4):
  Add eSPI device driver (flash channel)
  mtd: Replace module_init with subsys_initcall
  ARM: dts: aspeed: Add eSPI node
  dt-bindings: aspeed: Add eSPI controller

 .../bindings/soc/aspeed/aspeed,espi.yaml      |  94 ++++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi       |  19 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |  20 +
 drivers/mtd/mtdcore.c                         |   2 +-
 drivers/soc/aspeed/Kconfig                    |  38 ++
 drivers/soc/aspeed/Makefile                   |   2 +
 drivers/soc/aspeed/aspeed-espi-ctrl.c         | 197 ++++++++
 drivers/soc/aspeed/aspeed-espi-ctrl.h         | 169 +++++++
 drivers/soc/aspeed/aspeed-espi-flash-mafs.c   | 467 ++++++++++++++++++
 drivers/soc/aspeed/aspeed-espi-flash.h        |  71 +++
 10 files changed, 1078 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,espi.yaml
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.h
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash-mafs.c
 create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.h

-- 
2.40.1

