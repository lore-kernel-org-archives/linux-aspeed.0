From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 01 Jul 2024 14:15:03 -0000
Subject: [PATCH 3/9] mtd: add support to handle EEPROM devices
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
Message-ID: <20240701-b4-v6-10-topic-usbc-tcpci-v1-3-3fd5f4a193cc@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

At the moment EEPROMs are covered by misc/driver/eeprom/* drivers. This
commit prepares the MTD framework to handle EEPROM devices within the
MTD layer.

To keep the backward compatibility with the current misc drivers the
master device must be exposed always. Furthermore the NVMEM device
parent must be set to the I2C device instead of the MTD device and the
name must be either the I2C device name or the name specified via the
label.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/mtd/mtdcore.c      | 32 +++++++++++++++++++++++++++++++-
 include/uapi/mtd/mtd-abi.h |  2 ++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index dcd97e59425e..e2a996ccd17e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -149,6 +149,9 @@ static ssize_t mtd_type_show(struct device *dev,
 	case MTD_ROM:
 		type = "rom";
 		break;
+	case MTD_EEPROM:
+		type = "eeprom";
+		break;
 	case MTD_NORFLASH:
 		type = "nor";
 		break;
@@ -578,6 +581,33 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.ignore_wp = true;
 	config.priv = mtd;
 
+	switch (mtd->type) {
+	case MTD_EEPROM:
+		config.type = NVMEM_TYPE_EEPROM;
+		/*
+		 * The master device must be backward compatible with the
+		 * predecessor (misc/eeprom/at24.c) driver. Therefore we need to
+		 * adapt the naming scheme.
+		 *
+		 * Initialize config.id to NVMEM_DEVID_AUTO even if the
+		 * mtd->name is provided via an label as some platform can have
+		 * multiple eeproms with same label and we can not register each
+		 * of those with same label. Failing to register those eeproms
+		 * trigger cascade failure on such platform.
+		 */
+		if (mtd_is_master(mtd)) {
+			config.id = NVMEM_DEVID_AUTO;
+			config.compat = true;
+			config.name = mtd->name;
+			config.dev = mtd->dev.parent;
+			config.base_dev = mtd->dev.parent;
+		}
+		break;
+	default:
+		config.type = NVMEM_TYPE_UNKNOWN;
+		break;
+	}
+
 	mtd->nvmem = nvmem_register(&config);
 	if (IS_ERR(mtd->nvmem)) {
 		/* Just ignore if there is no NVMEM support in the kernel */
@@ -1076,7 +1106,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 	if (ret)
 		goto out;
 
-	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER)) {
+	if (IS_ENABLED(CONFIG_MTD_PARTITIONED_MASTER) || mtd->type == MTD_EEPROM) {
 		ret = add_mtd_device(mtd);
 		if (ret)
 			goto out;
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index 714d55b49d2a..59bf43d58ddb 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -146,6 +146,7 @@ struct mtd_read_req {
 #define MTD_DATAFLASH		6
 #define MTD_UBIVOLUME		7
 #define MTD_MLCNANDFLASH	8	/* MLC NAND (including TLC) */
+#define MTD_EEPROM		9
 
 #define MTD_WRITEABLE		0x400	/* Device is writeable */
 #define MTD_BIT_WRITEABLE	0x800	/* Single bits can be flipped */
@@ -159,6 +160,7 @@ struct mtd_read_req {
 #define MTD_CAP_NORFLASH	(MTD_WRITEABLE | MTD_BIT_WRITEABLE)
 #define MTD_CAP_NANDFLASH	(MTD_WRITEABLE)
 #define MTD_CAP_NVRAM		(MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_NO_ERASE)
+#define MTD_CAP_EEPROM		(MTD_WRITEABLE | MTD_BIT_WRITEABLE | MTD_NO_ERASE)
 
 /* Obsolete ECC byte placement modes (used with obsolete MEMGETOOBSEL) */
 #define MTD_NANDECC_OFF		0	/* Switch off ECC (Not recommended) */

-- 
2.39.2

