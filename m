From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 22 Apr 2021 16:08:41 +0700
Subject: [PATCH v4 2/4] mfd: simple-mfd-i2c: Adds Ampere's Altra SMpro support
In-Reply-To: <20210422090843.4614-1-quan@os.amperecomputing.com>
References: <20210422090843.4614-1-quan@os.amperecomputing.com>
Message-ID: <20210422090843.4614-3-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adds simple register map MFD driver for SMpro co-processor found on the
Mt.Jade hardware reference platform with Ampere's Altra processor family.

Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v4:
  + Add "depends on I2C" to fix build issue found by kernel test robot [Guenter]

Changes in v3:
  + None

Changes in v2:
  + Used 'struct of_device_id's .data attribute [Lee Jones]

 drivers/mfd/Kconfig          | 11 +++++++++++
 drivers/mfd/simple-mfd-i2c.c |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d07e8cf93286..10713b0e260e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -77,6 +77,17 @@ config MFD_AS3711
 	help
 	  Support for the AS3711 PMIC from AMS
 
+config MFD_SMPRO
+	tristate "Ampere Computing MFD SMpro core driver"
+	depends on I2C
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  Say yes here to enable SMpro driver support for Ampere's Altra
+	  processor family.
+
+	  Ampere's Altra SMpro exposes an I2C regmap interface that can
+	  be accessed by child devices.
+
 config MFD_AS3722
 	tristate "ams AS3722 Power Management IC"
 	select MFD_CORE
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 87f684cff9a1..9a44655f5592 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -21,6 +21,11 @@ static const struct regmap_config simple_regmap_config = {
 	.val_bits = 8,
 };
 
+static const struct regmap_config simple_word_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+};
+
 static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 {
 	const struct regmap_config *config;
@@ -39,6 +44,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
+	{ .compatible = "ampere,smpro", .data = &simple_word_regmap_config },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.28.0

