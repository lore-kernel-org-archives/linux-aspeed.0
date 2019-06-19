From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 19 Jun 2019 14:56:23 +0200
Subject: [PATCH] soc: aspeed: fix probe error handling
Message-ID: <20190619125636.1109665-1-arnd@arndb.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

gcc warns that a mising "flash" phandle node leads to undefined
behavior later:

drivers/soc/aspeed/aspeed-lpc-ctrl.c: In function 'aspeed_lpc_ctrl_probe':
drivers/soc/aspeed/aspeed-lpc-ctrl.c:201:18: error: '*((void *)&resm+8)' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The device cannot work without this node, so just error out here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
index 239520bb207e..81109d22af6a 100644
--- a/drivers/soc/aspeed/aspeed-lpc-ctrl.c
+++ b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
@@ -212,6 +212,7 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 	node = of_parse_phandle(dev->of_node, "flash", 0);
 	if (!node) {
 		dev_dbg(dev, "Didn't find host pnor flash node\n");
+		return -ENXIO;
 	} else {
 		rc = of_address_to_resource(node, 1, &resm);
 		of_node_put(node);
-- 
2.20.0

