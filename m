From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Tue, 18 Feb 2020 15:55:58 -0800
Subject: [PATCH 0/2] usb: gadget: aspeed: allow to customize vhub device
Message-ID: <20200218235600.6763-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

This patch series allows people to customize IDs/strings in vhub's
device descriptor through device tree properties.

Patch #1 overrides IDs and strings in device descriptor if according
device tree properties are defined.

Patch #2 moves fixup-usb1-device-descriptor logic from get_descriptor
handler to "ast_vhub_fixup_dev_desc" function for consistency.

The patch series needs to be applied on top of "aspeed-g6: enable usb
support" patch set to avoid merge conflicts.

Tao Ren (2):
  usb: gadget: aspeed: allow to customize vhub device IDs/strings
  usb: gadget: aspeed: fixup usb1 device descriptor at init time

 drivers/usb/gadget/udc/aspeed-vhub/hub.c | 93 +++++++++++++++++-------
 1 file changed, 68 insertions(+), 25 deletions(-)

-- 
2.17.1

