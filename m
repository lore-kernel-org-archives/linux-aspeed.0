From: Lei YU <yulei.sh@bytedance.com>
Date: Fri, 10 Dec 2021 17:34:43 +0800
Subject: [PATCH] ARM: dts: Add openbmc-flash-layout-64-alt.dtsi
Message-ID: <20211210093443.2140557-1-yulei.sh@bytedance.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add openbmc-flash-layout-64-alt.dtsi to describe the partitions of the
secondary flash for OpenBMC's 64M static layout.
The layout is the same as openbmc-flash-layout-64.dtsi and the labels
are prepended with "alt-" for the partitions.

Signed-off-by: Lei YU <yulei.sh@bytedance.com>
---
 .../boot/dts/openbmc-flash-layout-64-alt.dtsi | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi

diff --git a/arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi b/arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi
new file mode 100644
index 000000000000..650525867561
--- /dev/null
+++ b/arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Bytedance.
+ */
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	u-boot at 0 {
+		reg = <0x0 0xe0000>; // 896KB
+		label = "alt-u-boot";
+	};
+
+	u-boot-env at e0000 {
+		reg = <0xe0000 0x20000>; // 128KB
+		label = "alt-u-boot-env";
+	};
+
+	kernel at 100000 {
+		reg = <0x100000 0x900000>; // 9MB
+		label = "alt-kernel";
+	};
+
+	rofs at a00000 {
+		reg = <0xa00000 0x2000000>; // 32MB
+		label = "alt-rofs";
+	};
+
+	rwfs at 6000000 {
+		reg = <0x2a00000 0x1600000>; // 22MB
+		label = "alt-rwfs";
+	};
+};
-- 
2.25.1

