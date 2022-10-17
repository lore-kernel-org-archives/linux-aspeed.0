From: Joel Stanley <joel@jms.id.au>
Date: Mon, 17 Oct 2022 16:00:06 +1030
Subject: [PATCH] usb: gadget: aspeed: Fix probe regression
Message-ID: <20221017053006.358520-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since commit fc274c1e9973 ("USB: gadget: Add a new bus for gadgets"),
the gadget devices are proper driver core devices, which caused each
device to request pinmux settings:

 aspeed_vhub 1e6a0000.usb-vhub: Initialized virtual hub in USB2 mode
 aspeed-g5-pinctrl 1e6e2080.pinctrl: pin A7 already requested by 1e6a0000.usb-vhub; cannot claim for gadget.0
 aspeed-g5-pinctrl 1e6e2080.pinctrl: pin-232 (gadget.0) status -22
 aspeed-g5-pinctrl 1e6e2080.pinctrl: could not request pin 232 (A7) from group USB2AD  on device aspeed-g5-pinctrl
 g_mass_storage gadget.0: Error applying setting, reverse things back

The vhub driver has already claimed the pins, so prevent the gadgets
from requesting them too by setting the magic of_node_reused flag. This
causes the driver core to skip the mux request.

Reported-by: Zev Weiss <zev@bewilderbeest.net>
Reported-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
Cc: stable at vger.kernel.org
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index b0dfca43fbdc..4f3bc27c1c62 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -591,6 +591,7 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 		d->gadget.max_speed = USB_SPEED_HIGH;
 	d->gadget.speed = USB_SPEED_UNKNOWN;
 	d->gadget.dev.of_node = vhub->pdev->dev.of_node;
+	d->gadget.dev.of_node_reused = true;
 
 	rc = usb_add_gadget_udc(d->port_dev, &d->gadget);
 	if (rc != 0)
-- 
2.35.1

