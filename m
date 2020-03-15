From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 15 Mar 2020 12:16:26 -0700
Subject: [PATCH v2 0/6] usb: gadget: aspeed: allow to customize vhub device
Message-ID: <20200315191632.12536-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

This patch series allows people to customize aspeed-usb-vhub device IDs
and strings via device tree.

Patch #1 converts the single "usb_gadget_strings" instance to a list of
"usb_gadget_strings" so it's more convenient to support miltiple
languages.

Patch #2 moves LANGID validation code from configfs.c to usbstring.c so
it can be used by aspeed-vhub driver.

Patch #3 initializes aspeed-vhub strings with default, or from device
tree if according device tree properties are defined.

Patch #4 overrides aspeed-vhub's device IDs if according properties are
defined in device tree.

Patch #5 moves fixup-usb1-dev-desc logic from get-descriptor handler to
vhub-init time so the descriptor is patched only once.

Patch #6 documents new device tree properties in dt-binding document.

Tao Ren (6):
  usb: gadget: aspeed: support multiple language strings
  usb: gadget: add "usb_validate_langid" function
  usb: gadget: aspeed: allow to set usb strings in device tree
  usb: gadget: aspeed: allow to set device IDs in device tree
  usb: gadget: aspeed: fixup usb1 device descriptor at init time
  dt-bindings: usb: document aspeed vhub device ID/string properties

 .../bindings/usb/aspeed,usb-vhub.yaml         |  68 +++++
 drivers/usb/gadget/configfs.c                 |  14 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c     |   4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c      | 236 ++++++++++++++++--
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h     |   4 +-
 drivers/usb/gadget/usbstring.c                |  24 ++
 include/linux/usb/gadget.h                    |   3 +
 7 files changed, 312 insertions(+), 41 deletions(-)

-- 
2.17.1

