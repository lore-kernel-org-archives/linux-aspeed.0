From: Neal Liu <neal_liu@aspeedtech.com>
Date: Tue, 30 Nov 2021 18:42:54 +0800
Subject: [PATCH v2 2/4] usb: aspeed-vhub: support auto remote wakeup feature
In-Reply-To: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
References: <20211130104256.3106797-1-neal_liu@aspeedtech.com>
Message-ID: <20211130104256.3106797-3-neal_liu@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remote wakeup signaling will be automatically issued
whenever any write commands has been received in suspend
state.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 7a635c499777..122ee7ef0b03 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -240,6 +240,9 @@ void ast_vhub_init_hw(struct ast_vhub *vhub)
 	if (vhub->force_usb1)
 		ctrl |= VHUB_CTRL_FULL_SPEED_ONLY;
 
+	/* Enable auto remote wakeup */
+	ctrl |= VHUB_CTRL_AUTO_REMOTE_WAKEUP;
+
 	ctrl |= VHUB_CTRL_UPSTREAM_CONNECT;
 	writel(ctrl, vhub->regs + AST_VHUB_CTRL);
 
-- 
2.25.1

