From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 21 Mar 2023 10:16:41 -0500
Subject: [PATCH v2 3/4] eeprom: ee1004: Add devicetree binding
In-Reply-To: <20230321151642.461618-1-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
Message-ID: <20230321151642.461618-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an OF match table for devicetree instantiation of EE1004
devices.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/misc/eeprom/ee1004.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 950813821087..72068bb72621 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -59,6 +59,12 @@ static const struct i2c_device_id ee1004_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ee1004_ids);
 
+static const struct of_device_id ee1004_of_match[] = {
+	{ .compatible = "atmel,at30tse" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ee1004_of_match);
+
 /*-------------------------------------------------------------------------*/
 
 static int ee1004_get_current_page(struct ee1004_bus *bus)
@@ -270,6 +276,7 @@ static struct i2c_driver ee1004_driver = {
 	.driver = {
 		.name = "ee1004",
 		.dev_groups = ee1004_groups,
+		.of_match_table = ee1004_of_match,
 	},
 	.probe_new = ee1004_probe,
 	.remove = ee1004_remove,
-- 
2.31.1

