From: Kunwu Chan <chentao@kylinos.cn>
Date: Wed, 22 Nov 2023 09:42:12 +0800
Subject: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in ast_vhub_alloc_epn
Message-ID: <20231122014212.304254-1-chentao@kylinos.cn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
index 148d7ec3ebf4..e0854e878411 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
@@ -826,6 +826,8 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct ast_vhub_dev *d, u8 addr)
 	ep->vhub = vhub;
 	ep->ep.ops = &ast_vhub_epn_ops;
 	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
+	if (!ep->ep.name)
+		return NULL;
 	d->epns[addr-1] = ep;
 	ep->epn.g_idx = i;
 	ep->epn.regs = vhub->regs + 0x200 + (i * 0x10);
-- 
2.34.1

