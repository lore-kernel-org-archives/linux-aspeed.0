From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:20 -0500
Subject: [PATCH 22/22] ARM: dts: aspeed: Add Rainier 1S4U machine
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-23-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 1S4U version of the Rainier system has only 4 fans. Create a new
tree, include the 4U version, and delete the 2 extra fans.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/Makefile                        |  1 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts | 14 ++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts      |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c2c8ec8c1cd5..8e1819fb4497 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1424,6 +1424,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ibm-everest.dtb \
 	aspeed-bmc-ibm-rainier.dtb \
 	aspeed-bmc-ibm-rainier-v2.dtb \
+	aspeed-bmc-ibm-rainier-1s4u.dtb \
 	aspeed-bmc-ibm-rainier-4u.dtb \
 	aspeed-bmc-ibm-rainier-4u-v2.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts
new file mode 100644
index 000000000000..78b2dab63624
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2021 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-bmc-ibm-rainier-4u-v2.dts"
+
+/ {
+	model = "Rainier 1S4U";
+};
+
+&max {
+	/delete-node/ fan4;
+	/delete-node/ fan5;
+};
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index a8c0ed4d37c3..089358704e64 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -1979,7 +1979,7 @@ tmp275 at 48 {
 		reg = <0x48>;
 	};
 
-	max31785 at 52 {
+	max: max31785 at 52 {
 		compatible = "maxim,max31785a";
 		reg = <0x52>;
 		#address-cells = <1>;
-- 
2.27.0

