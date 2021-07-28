From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Wed, 28 Jul 2021 16:37:50 -0700
Subject: [PATCH 1/6] ARM: dts: Add Facebook BMC 128MB flash layout
In-Reply-To: <20210728233755.17963-1-rentao.bupt@gmail.com>
References: <20210728233755.17963-1-rentao.bupt@gmail.com>
Message-ID: <20210728233755.17963-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

This is the layout used by Facebook BMC systems. It describes the fixed
flash layout of a 128MB mtd device.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../dts/facebook-bmc-flash-layout-128.dtsi    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi

diff --git a/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi b/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi
new file mode 100644
index 000000000000..7f3652dea550
--- /dev/null
+++ b/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/*
+	 * u-boot partition: 896KB.
+	 */
+	u-boot at 0 {
+		reg = <0x0 0xe0000>;
+		label = "u-boot";
+	};
+
+	/*
+	 * u-boot environment variables: 64KB.
+	 */
+	u-boot-env at e0000 {
+		reg = <0xe0000 0x10000>;
+		label = "env";
+	};
+
+	/*
+	 * image metadata partition (64KB), used by Facebook internal
+	 * tools.
+	 */
+	image-meta at f0000 {
+		reg = <0xf0000 0x10000>;
+		label = "meta";
+	};
+
+	/*
+	 * FIT image: 119 MB.
+	 */
+	fit at 100000 {
+		reg = <0x100000 0x7700000>;
+		label = "fit";
+	};
+
+	/*
+	 * "data0" partition (8MB) is used by Facebook BMC platforms as
+	 * persistent data store.
+	 */
+	data0 at 7800000 {
+		reg = <0x7800000 0x800000>;
+		label = "data0";
+	};
+
+	/*
+	 * Although the master partition can be created by enabling
+	 * MTD_PARTITIONED_MASTER option, below "flash0" partition is
+	 * explicitly created to avoid breaking legacy applications.
+	 */
+	flash0 at 0 {
+		reg = <0x0 0x8000000>;
+		label = "flash0";
+	};
+};
-- 
2.17.1

