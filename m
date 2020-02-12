From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Wed, 12 Feb 2020 13:57:12 -0800
Subject: [PATCH v2 0/5] aspeed-g6: enable usb support
Message-ID: <20200212215717.9474-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series aims at enabling USB Host and Gadget support on AST2600
platforms.

Patch #1 replaces hardcoded vhub port/endpoint number with device tree
properties, so that it's more convenient to add support for ast2600-vhub
which provides more downstream ports and endpoints.

Patch #2 and #3 add vhub port/endpoint properties into aspeed-g4 and
aspeed-g5 dtsi.

Patch #4 enables ast2600 support in aspeed-vhub usb gadget driver.

Patch #5 adds USB devices and according pin groups in aspeed-g6 dtsi.

The patch series is sanity tested on AST2520 (Yamp) BMC and AST2600-A0
eval board:
  - AST2520: created 5 gadget devices with 15 endpoints, and all of them
    can be enumerated from usb-host side.
  - AST2600: created 7 gadget devices with 20 endpoints, and all of them
    can be enumerated from usb-host side.

Tao Ren (5):
  usb: gadget: aspeed: read vhub properties from device tree
  ARM: dts: aspeed-g4: add vhub port and endpoint properties
  ARM: dts: aspeed-g5: add vhub port and endpoint properties
  usb: gadget: aspeed: add ast2600 vhub support
  ARM: dts: aspeed-g6: add usb functions

 arch/arm/boot/dts/aspeed-g4.dtsi           |  2 +
 arch/arm/boot/dts/aspeed-g5.dtsi           |  2 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   | 25 ++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi           | 45 ++++++++++++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c  | 71 ++++++++++++++--------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c   | 30 ++++++---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c   |  4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c   | 26 +++++---
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h  | 23 +++----
 10 files changed, 170 insertions(+), 62 deletions(-)

-- 
2.17.1

