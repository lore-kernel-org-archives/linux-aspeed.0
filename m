From: Neal Liu <neal_liu@aspeedtech.com>
Date: Fri, 13 May 2022 14:57:25 +0800
Subject: [PATCH 0/3] add Aspeed udc driver for ast2600
Message-ID: <20220513065728.857722-1-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series aim to add Aspeed USB 2.0 Device Controller (udc)
driver, including driver itself, device tree node and documentation.

*** BLURB HERE ***

Neal Liu (3):
  usb: gadget: add Aspeed ast2600 udc driver
  ARM: dts: aspeed: Add USB2.0 device controller node
  dt-bindings: usb: add documentation for aspeed udc

 .../devicetree/bindings/usb/aspeed,udc.yaml   |   52 +
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/aspeed-g6.dtsi              |   10 +
 drivers/usb/gadget/udc/Kconfig                |   13 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/aspeed_udc.c           | 1594 +++++++++++++++++
 6 files changed, 1677 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/aspeed,udc.yaml
 create mode 100644 drivers/usb/gadget/udc/aspeed_udc.c

-- 
2.25.1

