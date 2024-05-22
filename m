From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 May 2024 14:25:21 -0500
Subject: [PATCH v6 17/20] ARM: dts: aspeed: Add IBM Huygens BMC system
In-Reply-To: <20240522192524.3286237-1-eajames@linux.ibm.com>
References: <20240522192524.3286237-1-eajames@linux.ibm.com>
Message-ID: <20240522192524.3286237-18-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Huygens is a Rainier with modifed FSI wiring.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-ibm-huygens.dts     | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-huygens.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 5e3392621697a..ac2804c96554a 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ibm-bonnell.dtb \
 	aspeed-bmc-ibm-everest.dtb \
 	aspeed-bmc-ibm-fuji.dtb \
+	aspeed-bmc-ibm-huygens.dtb \
 	aspeed-bmc-ibm-rainier.dtb \
 	aspeed-bmc-ibm-rainier-1s4u.dtb \
 	aspeed-bmc-ibm-rainier-4u.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-huygens.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-huygens.dts
new file mode 100644
index 0000000000000..4a731b772fc0b
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-huygens.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2024 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-bmc-ibm-rainier.dts"
+
+/ {
+	model = "Huygens";
+};
+
+&fsim0 {
+	/delete-node/ cfam at 0,0;
+	/delete-property/ cfam-reset-gpios;
+
+	bus-frequency = <100000000>;
+};
+
+&fsim1 {
+	#address-cells = <2>;
+	#size-cells = <0>;
+	status = "okay";
+	bus-frequency = <100000000>;
+};
-- 
2.39.3

