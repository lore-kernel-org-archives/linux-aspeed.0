From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 01 Jul 2024 14:14:48 -0000
Subject: [PATCH 1/9] mtd: core: add nvmem_write support
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
Message-ID: <20240701-b4-v6-10-topic-usbc-tcpci-v1-1-3fd5f4a193cc@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The MTD framework does support the NVMEM framework already but only the
read support was implemented. This commit adds the write support if the
MTD device supports writing (MTD_WRITEABLE is set).

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/mtd/mtdcore.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 724f917f91ba..dcd97e59425e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -544,6 +544,20 @@ static int mtd_nvmem_reg_read(void *priv, unsigned int offset,
 	return retlen == bytes ? 0 : -EIO;
 }
 
+static int mtd_nvmem_reg_write(void *priv, unsigned int offset,
+			       void *val, size_t bytes)
+{
+	struct mtd_info *mtd = priv;
+	size_t retlen;
+	int err;
+
+	err = mtd_write(mtd, offset, bytes, &retlen, val);
+	if (err && err != -EUCLEAN)
+		return err;
+
+	return retlen == bytes ? 0 : -EIO;
+}
+
 static int mtd_nvmem_add(struct mtd_info *mtd)
 {
 	struct device_node *node = mtd_get_of_node(mtd);
@@ -555,10 +569,11 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	config.owner = THIS_MODULE;
 	config.add_legacy_fixed_of_cells = of_device_is_compatible(node, "nvmem-cells");
 	config.reg_read = mtd_nvmem_reg_read;
+	config.reg_write = mtd_nvmem_reg_write;
 	config.size = mtd->size;
 	config.word_size = 1;
 	config.stride = 1;
-	config.read_only = true;
+	config.read_only = !(mtd->flags & MTD_WRITEABLE);
 	config.root_only = true;
 	config.ignore_wp = true;
 	config.priv = mtd;

-- 
2.39.2

