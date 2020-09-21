From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 Sep 2020 11:36:40 +0930
Subject: [PATCH v2 2/3] soc: aspeed: Add soc info driver
In-Reply-To: <20200921020641.48733-1-joel@jms.id.au>
References: <20200921020641.48733-1-joel@jms.id.au>
Message-ID: <20200921020641.48733-3-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds a SOC_BUS info driver for the ASPEED platform.

The full ID table is preserved in this commit message in case someone
finds a need to change the implemntation in the future.

	{ "AST1100-A0", 0x00000200 },
	{ "AST1100-A1", 0x00000201 },
	{ "AST1100-A2", 0x00000202 },
	{ "AST1100-A3", 0x00000202 },

	{ "AST2050-A0", 0x00000200 },
	{ "AST2050-A1", 0x00000201 },
	{ "AST2050-A2", 0x00000202 },
	{ "AST2050-A3", 0x00000202 },

	{ "AST2100-A0", 0x00000300 },
	{ "AST2100-A1", 0x00000301 },
	{ "AST2100-A2", 0x00000302 },
	{ "AST2100-A3", 0x00000302 },

	{ "AST2150-A0", 0x00000202 },
	{ "AST2150-A1", 0x00000202 },

	{ "AST2200-A0", 0x00000102 },
	{ "AST2200-A1", 0x00000102 },

	{ "AST2300-A0", 0x01000003 },
	{ "AST2300-A1", 0x01010303 },

	{ "AST1300-A1", 0x01010003 },
	{ "AST1050-A1", 0x01010203 },

	{ "AST2400-A0", 0x02000303 },
	{ "AST2400-A1", 0x02010303 },
	{ "AST1400-A1", 0x02010103 },
	{ "AST1250-A1", 0x02010303 },

	{ "AST2500-A0", 0x04000303 },
	{ "AST2510-A0", 0x04000103 },
	{ "AST2520-A0", 0x04000203 },
	{ "AST2530-A0", 0x04000403 },
	{ "AST2500-A1", 0x04010303 },
	{ "AST2510-A1", 0x04010103 },
	{ "AST2520-A1", 0x04010203 },
	{ "AST2530-A1", 0x04010403 },
	{ "AST2500-A2", 0x04030303 },
	{ "AST2510-A2", 0x04030103 },
	{ "AST2520-A2", 0x04030203 },
	{ "AST2530-A2", 0x04030403 },

	{ "AST2600-A0", 0x05000303 },
	{ "AST2600-A1", 0x05010303 },
	{ "AST2600-A2", 0x05020303 },
	{ "AST2620-A1", 0x05010203 },
	{ "AST2620-A2", 0x05020203 },

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 - Fix of_node_puts
 - Skip kasprintf where it's not needed
---
 drivers/soc/aspeed/Kconfig          |   7 ++
 drivers/soc/aspeed/Makefile         |   1 +
 drivers/soc/aspeed/aspeed-socinfo.c | 135 ++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-socinfo.c

diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
index 9ce252445605..7ece0675b1fa 100644
--- a/drivers/soc/aspeed/Kconfig
+++ b/drivers/soc/aspeed/Kconfig
@@ -31,6 +31,13 @@ config ASPEED_P2A_CTRL
 	  driver also provides an interface for userspace mappings to a
 	  pre-defined region.
 
+config ASPEED_SOCINFO
+	bool "ASPEED SoC Information driver"
+	default ARCH_ASPEED
+	select SOC_BUS
+	help
+	  Say yes to support decoding of ASPEED BMC information.
+
 endmenu
 
 endif
diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b64be47f2b1f..fcab7192e1a4 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)	+= aspeed-p2a-ctrl.o
+obj-$(CONFIG_ASPEED_SOCINFO)	+= aspeed-socinfo.o
diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
new file mode 100644
index 000000000000..690810bc4a9b
--- /dev/null
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright 2019 IBM Corp. */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+static struct {
+	const char *name;
+	const u32 id;
+} const rev_table[] = {
+	/* AST2400 */
+	{ "AST2400", 0x02000303 },
+	{ "AST1400", 0x02010103 },
+	{ "AST1250", 0x02010303 },
+	/* AST2500 */
+	{ "AST2500", 0x04000303 },
+	{ "AST2510", 0x04000103 },
+	{ "AST2520", 0x04000203 },
+	{ "AST2530", 0x04000403 },
+	/* AST2600 */
+	{ "AST2600", 0x05000303 },
+	{ "AST2620", 0x05010203 },
+};
+
+static const char *siliconid_to_name(u32 siliconid)
+{
+	unsigned int id = siliconid & 0xff00ffff;
+	unsigned int i;
+
+	for (i = 0 ; i < ARRAY_SIZE(rev_table) ; ++i) {
+		if (rev_table[i].id == id)
+			return rev_table[i].name;
+	}
+
+	return "Unknown";
+}
+
+static const char *siliconid_to_rev(u32 siliconid)
+{
+	unsigned int rev = (siliconid >> 16) & 0xff;
+
+	switch (rev) {
+	case 0:
+		return "A0";
+	case 1:
+		return "A1";
+	case 3:
+		return "A2";
+	};
+
+	return "??";
+}
+
+static int __init aspeed_socinfo_init(void)
+{
+	struct soc_device_attribute *attrs;
+	struct soc_device *soc_dev;
+	struct device_node *np;
+	void __iomem *reg;
+	bool has_chipid = false;
+	u32 siliconid;
+	u32 chipid[2];
+	const char *machine = NULL;
+
+	np = of_find_compatible_node(NULL, NULL, "aspeed,silicon-id");
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return -ENODEV;
+	}
+
+	reg = of_iomap(np, 0);
+	if (!reg)
+		return -ENODEV;
+	siliconid = readl(reg);
+	iounmap(reg);
+
+	/* This is optional, the ast2400 does not have it */
+	reg = of_iomap(np, 1);
+	if (reg) {
+		has_chipid = true;
+		chipid[0] = readl(reg);
+		chipid[1] = readl(reg + 4);
+		iounmap(reg);
+	}
+	of_node_put(np);
+
+	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENODEV;
+
+	/*
+	 * Machine: Romulus BMC
+	 * Family: AST2500
+	 * Revision: A1
+	 * SoC ID: raw silicon revision id
+	 * Serial Number: 64-bit chipid
+	 */
+
+	np = of_find_node_by_path("/");
+	of_property_read_string(np, "model", &machine);
+	if (machine)
+		attrs->machine = kstrdup(machine, GFP_KERNEL);
+	of_node_put(np);
+
+	attrs->family = siliconid_to_name(siliconid);
+	attrs->revision = siliconid_to_rev(siliconid);
+	attrs->soc_id = kasprintf(GFP_KERNEL, "%08x", siliconid);
+
+	if (has_chipid)
+		attrs->serial_number = kasprintf(GFP_KERNEL, "%08x%08x",
+						 chipid[1], chipid[0]);
+
+	soc_dev = soc_device_register(attrs);
+	if (IS_ERR(soc_dev)) {
+		kfree(attrs->family);
+		kfree(attrs->revision);
+		kfree(attrs->soc_id);
+		kfree(attrs->serial_number);
+		kfree(attrs);
+		return PTR_ERR(soc_dev);
+	}
+
+	pr_info("ASPEED BMC %s rev %s (%s)\n",
+			attrs->family,
+			attrs->revision,
+			attrs->soc_id);
+
+	return 0;
+}
+early_initcall(aspeed_socinfo_init);
-- 
2.28.0

