From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 29 Sep 2021 04:54:07 -0700
Subject: [PATCH 5/6] mtd: spi-nor: aspeed: Don't automatically attach reserved
 chips
In-Reply-To: <20210929115409.21254-1-zev@bewilderbeest.net>
References: <20210929115409.21254-1-zev@bewilderbeest.net>
Message-ID: <20210929115409.21254-6-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With this change, any flash chips under the controller that are marked
with a DT status of "reserved" will be created, but not automatically
attached.  Userspace can later request that they be attached using the
attach_chip sysfs file.

This is to accommodate situations where a chip may be (for example)
shared with another controller external to the SoC and require
userspace to arbitrate access to it prior to actually attaching it.
(such as a firmware SPI flash shared between a BMC and the host
system).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/mtd/spi-nor/controllers/aspeed-smc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/aspeed-smc.c b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
index da49192a8220..328b008fafb2 100644
--- a/drivers/mtd/spi-nor/controllers/aspeed-smc.c
+++ b/drivers/mtd/spi-nor/controllers/aspeed-smc.c
@@ -826,10 +826,14 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
 	unsigned int cs;
 	int ret = -ENODEV;
 
-	for_each_available_child_of_node(np, child) {
+	for_each_child_of_node(np, child) {
 		struct aspeed_smc_chip *chip;
 		struct spi_nor *nor;
 
+		/* Skip disabled nodes, but include reserved ones for later attachment */
+		if (!of_device_is_available(child) && !of_device_is_reserved(child))
+			continue;
+
 		/* This driver does not support NAND or NOR flash devices. */
 		if (!of_device_is_compatible(child, "jedec,spi-nor"))
 			continue;
@@ -873,6 +877,9 @@ static int aspeed_smc_setup_flash(struct aspeed_smc_controller *controller,
 
 		controller->chips[cs] = chip;
 
+		if (of_device_is_reserved(child))
+			continue;
+
 		ret = aspeed_smc_register_chip(chip);
 		if (ret)
 			break;
-- 
2.33.0

