From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Mar 2022 10:36:28 +1030
Subject: [PATCH v2 1/2] ARM: aspeed: Add debugfs directory
In-Reply-To: <20220310000629.119699-1-joel@jms.id.au>
References: <20220310000629.119699-1-joel@jms.id.au>
Message-ID: <20220310000629.119699-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This will be used by other drivers to hold machine specific debugfs
information.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/mach-aspeed/debugfs.c | 16 ++++++++++++++++
 arch/arm/mach-aspeed/Makefile  |  1 +
 2 files changed, 17 insertions(+)
 create mode 100644 arch/arm/mach-aspeed/debugfs.c

diff --git a/arch/arm/mach-aspeed/debugfs.c b/arch/arm/mach-aspeed/debugfs.c
new file mode 100644
index 000000000000..b7d1b8f28435
--- /dev/null
+++ b/arch/arm/mach-aspeed/debugfs.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 IBM Corp.
+
+#include <linux/debugfs.h>
+#include <linux/export.h>
+#include <linux/init.h>
+
+struct dentry *arch_debugfs_dir;
+EXPORT_SYMBOL(arch_debugfs_dir);
+
+static int __init aspeed_debugfs_init(void)
+{
+	arch_debugfs_dir = debugfs_create_dir("aspeed", NULL);
+	return 0;
+}
+arch_initcall(aspeed_debugfs_init);
diff --git a/arch/arm/mach-aspeed/Makefile b/arch/arm/mach-aspeed/Makefile
index 1951b3317a76..3db448ccdfe1 100644
--- a/arch/arm/mach-aspeed/Makefile
+++ b/arch/arm/mach-aspeed/Makefile
@@ -3,3 +3,4 @@
 # Copyright IBM Corp.
 
 obj-$(CONFIG_SMP) += platsmp.o
+obj-$(CONFIG_DEBUG_FS) += debugfs.o
-- 
2.34.1

