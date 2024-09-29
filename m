From: Charles Han <hanchunchao@inspur.com>
Date: Sun, 29 Sep 2024 09:25:03 +0800
Subject: [PATCH] soc: aspeed: Add check devm_kasprintf() returned value
Message-ID: <20240929012503.18636-1-hanchunchao@inspur.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

devm_kasprintf() can return a NULL pointer on failure in
aspeed_lpc_enable_snoop()  but this returned value is not checked.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 888b5840c015..68317b2e44b5 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -200,6 +200,9 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 	lpc_snoop->chan[channel].miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_snoop->chan[channel].miscdev.name =
 		devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME, channel);
+	if (!lpc_snoop->chan[channel].miscdev.name)
+		return -ENOMEM;
+
 	lpc_snoop->chan[channel].miscdev.fops = &snoop_fops;
 	lpc_snoop->chan[channel].miscdev.parent = dev;
 	rc = misc_register(&lpc_snoop->chan[channel].miscdev);
-- 
2.31.1

