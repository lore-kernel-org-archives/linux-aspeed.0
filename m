From: Nishka Dasgupta <nishkadg.linux@gmail.com>
Date: Thu, 08 Aug 2019 07:51:22 -0000
Subject: [PATCH] mtd: spi-nor: aspeed-smc: Add of_node_put()
Message-ID: <20190808075104.15928-1-nishkadg.linux@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Each iteration of for_each_available_child_of_node puts the previous
node, but in the case of a break from the middle of the loop, there is
no put, thus causing a memory leak. Upon termination of the loop
(whether by break or a natural exit), either ret will have a non-zero
value or child will be NULL. Hence add an of_node_put() that will
execute only when ret has a non-zero value, as calling of_node_put() on
a possible NULL value does not cause any further issues.
Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/mtd/spi-nor/aspeed-smc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/aspeed-smc.c b/drivers/mtd/spi-nor/aspeed-smc.c
index 19b8757325d2..009c1da8574c 100644
--- a/drivers/mtd/spi-nor/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/aspeed-smc.c
@@ -836,8 +836,10 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
 		controller->chips[cs] = chip;
 	}
 
-	if (ret)
+	if (ret) {
+		of_node_put(child);
 		aspeed_smc_unregister(controller);
+	}
 
 	return ret;
 }
-- 
2.19.1

