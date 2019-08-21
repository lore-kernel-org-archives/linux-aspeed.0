From: Joel Stanley <joel@jms.id.au>
Date: Wed, 21 Aug 2019 15:25:27 +0930
Subject: [PATCH 4/7] ARM: aspeed: Enable SMP boot
In-Reply-To: <20190821055530.8720-1-joel@jms.id.au>
References: <20190821055530.8720-1-joel@jms.id.au>
Message-ID: <20190821055530.8720-5-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This brings the secondary CPU into Linux. It depends on the setup
performed by ASPEED's u-boot.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/Makefile              |  1 +
 arch/arm/mach-aspeed/Makefile  |  5 +++
 arch/arm/mach-aspeed/platsmp.c | 61 ++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 arch/arm/mach-aspeed/Makefile
 create mode 100644 arch/arm/mach-aspeed/platsmp.c

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f96419135d35..be2fc3e79434 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -155,6 +155,7 @@ textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 machine-$(CONFIG_ARCH_ACTIONS)		+= actions
 machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
+machine-$(CONFIG_ARCH_ASPEED)           += aspeed
 machine-$(CONFIG_ARCH_AT91)		+= at91
 machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
diff --git a/arch/arm/mach-aspeed/Makefile b/arch/arm/mach-aspeed/Makefile
new file mode 100644
index 000000000000..1951b3317a76
--- /dev/null
+++ b/arch/arm/mach-aspeed/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) ASPEED Technology Inc.
+# Copyright IBM Corp.
+
+obj-$(CONFIG_SMP) += platsmp.o
diff --git a/arch/arm/mach-aspeed/platsmp.c b/arch/arm/mach-aspeed/platsmp.c
new file mode 100644
index 000000000000..2324becf7991
--- /dev/null
+++ b/arch/arm/mach-aspeed/platsmp.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (C) ASPEED Technology Inc.
+// Copyright IBM Corp.
+
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+
+#define BOOT_ADDR	0x00
+#define BOOT_SIG	0x04
+
+static struct device_node *secboot_node;
+
+static int aspeed_g6_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	void __iomem *base;
+
+	base = of_iomap(secboot_node, 0);
+	if (!base) {
+		pr_err("could not map the secondary boot base!");
+		return -ENODEV;
+	}
+
+	writel_relaxed(0, base + BOOT_ADDR);
+	writel_relaxed(__pa_symbol(secondary_startup_arm), base + BOOT_ADDR);
+	writel_relaxed((0xABBAAB00 | (cpu & 0xff)), base + BOOT_SIG);
+
+	dsb_sev();
+
+	iounmap(base);
+
+	return 0;
+}
+
+static void __init aspeed_g6_smp_prepare_cpus(unsigned int max_cpus)
+{
+	void __iomem *base;
+
+	secboot_node = of_find_compatible_node(NULL, NULL, "aspeed,ast2600-smpmem");
+	if (!secboot_node) {
+		pr_err("secboot device node found!!\n");
+		return;
+	}
+
+	base = of_iomap(secboot_node, 0);
+	if (!base) {
+		pr_err("could not map the secondary boot base!");
+		return;
+	}
+	__raw_writel(0xBADABABA, base + BOOT_SIG);
+
+	iounmap(base);
+}
+
+static const struct smp_operations aspeed_smp_ops __initconst = {
+	.smp_prepare_cpus	= aspeed_g6_smp_prepare_cpus,
+	.smp_boot_secondary	= aspeed_g6_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(aspeed_smp, "aspeed,ast2600-smp", &aspeed_smp_ops);
-- 
2.23.0.rc1

