From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 Mar 2023 09:03:47 -0500
Subject: [PATCH v3 3/4] eeprom: ee1004: Add OF matching support
In-Reply-To: <20230322140348.569397-1-eajames@linux.ibm.com>
References: <20230322140348.569397-1-eajames@linux.ibm.com>
Message-ID: <20230322140348.569397-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an OF match table for devicetree instantiation of the
AT30TSE004A EEPROM.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v2:
 - Use full model number
 - Fix commit name

 drivers/misc/eeprom/ee1004.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index 0aed5760e370..b7566c1d6edd 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -58,6 +58,12 @@ static const struct i2c_device_id ee1004_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ee1004_ids);
 
+static const struct of_device_id ee1004_of_match[] = {
+	{ .compatible = "atmel,at30tse004a" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ee1004_of_match);
+
 /*-------------------------------------------------------------------------*/
 
 static int ee1004_get_current_page(struct ee1004_bus *bus)
@@ -269,6 +275,7 @@ static struct i2c_driver ee1004_driver = {
 	.driver = {
 		.name = "ee1004",
 		.dev_groups = ee1004_groups,
+		.of_match_table = ee1004_of_match,
 	},
 	.probe_new = ee1004_probe,
 	.remove = ee1004_remove,
-- 
2.31.1

