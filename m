From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Fri, 31 Jan 2020 14:21:54 -0800
Subject: [PATCH 0/3] aspeed-g6: enable usb support
Message-ID: <20200131222157.20849-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series aims at enabling USB Host and Gadget support on AST2600
platforms.

Patch #1 moves hardcoded vhub attributes (number of downstream ports and
endpoints) to "struct ast_hub_config" which is then attached to "struct
of_device_id". By doing this, it will be easier to enable ast2600 vhub
which supports more ports and endpoints.

Patch #2 enables AST2600 support in aspeed-vhub gadget driver.

Patch #3 adds USB devices and according pin groups in aspeed-g6 dtsi.

Tao Ren (3):
  usb: gadget: aspeed: read vhub config from of_device_id
  usb: gadget: aspeed: add ast2600 vhub support
  ARM: dts: aspeed-g6: add usb functions

 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   |  25 +++++
 arch/arm/boot/dts/aspeed-g6.dtsi           |  43 ++++++++
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig |   4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c  | 109 ++++++++++++++-------
 drivers/usb/gadget/udc/aspeed-vhub/dev.c   |  30 ++++--
 drivers/usb/gadget/udc/aspeed-vhub/epn.c   |   4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c   |  26 +++--
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h  |  23 ++---
 8 files changed, 191 insertions(+), 73 deletions(-)

-- 
2.17.1

