From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Fri, 26 Mar 2021 00:02:14 -0700
Subject: [PATCH] usb: gadget: aspeed: set port_dev dma mask
Message-ID: <20210326070214.6719-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Set aspeed-usb vhub port_dev's dma mask to pass the dma_mask test in
"dma_map_page_attrs" function, and the dma_mask test was added in
'commit f959dcd6ddfd ("dma-direct: Fix potential NULL pointer
dereference")'.

Below is the backtrace without the patch:
[<80106550>] show_stack+0x20/0x24
[<80106868>] dump_stack+0x28/0x30
[<80823540>] __warn+0xfc/0x110
[<8011ac30>] warn_slowpath_fmt+0xb0/0xc0
[<8011ad44>] dma_map_page_attrs+0x24c/0x314
[<8016a27c>] usb_gadget_map_request_by_dev+0x100/0x1e4
[<805cedd8>] usb_gadget_map_request+0x1c/0x20
[<805cefbc>] ast_vhub_epn_queue+0xa0/0x1d8
[<7f02f710>] usb_ep_queue+0x48/0xc4
[<805cd3e8>] ecm_do_notify+0xf8/0x248
[<7f145920>] ecm_set_alt+0xc8/0x1d0
[<7f145c34>] composite_setup+0x680/0x1d30
[<7f00deb8>] ast_vhub_ep0_handle_setup+0xa4/0x1bc
[<7f02ee94>] ast_vhub_dev_irq+0x58/0x84
[<7f0309e0>] ast_vhub_irq+0xb0/0x1c8
[<7f02e118>] __handle_irq_event_percpu+0x50/0x19c
[<8015e5bc>] handle_irq_event_percpu+0x38/0x8c
[<8015e758>] handle_irq_event+0x38/0x4c

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index d268306a7bfe..9eb3904a6ff9 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -569,6 +569,7 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	device_initialize(d->port_dev);
 	d->port_dev->release = ast_vhub_dev_release;
 	d->port_dev->parent = parent;
+	d->port_dev->dma_mask = parent->dma_mask;
 	dev_set_name(d->port_dev, "%s:p%d", dev_name(parent), idx + 1);
 	rc = device_add(d->port_dev);
 	if (rc)
-- 
2.17.1

