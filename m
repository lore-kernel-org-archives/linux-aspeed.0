From: Liao Chen <liaochen4@huawei.com>
Date: Tue, 3 Sep 2024 13:15:03 +0000
Subject: [PATCH -next] serial: 8250_aspeed_vuart: Enable module autoloading
Message-ID: <20240903131503.961178-1-liaochen4@huawei.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 53d8eee9b1c8..25c201cfb91e 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -561,6 +561,7 @@ static const struct of_device_id aspeed_vuart_table[] = {
 	{ .compatible = "aspeed,ast2500-vuart" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, aspeed_vuart_table);
 
 static struct platform_driver aspeed_vuart_driver = {
 	.driver = {
-- 
2.34.1

