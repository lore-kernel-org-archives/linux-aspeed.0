From: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Date: Tue, 9 Jan 2024 21:35:43 -0600
Subject: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx Platform
Message-ID: <20240110033543.799919-1-supreeth.venkatesh@amd.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds initial device tree and makefile updates for
AMD Onyx platform.

AMD Onyx platform is an AMD customer reference board with an Aspeed
ast2600 BMC manufactured by AMD.
It describes I2c devices, Fans, Kcs devices, Uarts, Mac, LEDs, etc.
present on AMD Onyx platform.

Signed-off-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../boot/dts/aspeed/aspeed-bmc-amd-onyx.dts   | 98 +++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index fb9cc95f1b60..2b27d377aae2 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -5,6 +5,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2600-evb.dtb \
 	aspeed-bmc-amd-daytonax.dtb \
 	aspeed-bmc-amd-ethanolx.dtb \
+	aspeed-bmc-amd-onyx.dtb \
 	aspeed-bmc-ampere-mtjade.dtb \
 	aspeed-bmc-ampere-mtmitchell.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
new file mode 100644
index 000000000000..a7056cd29553
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2021 - 2024 AMD Inc.
+// Author: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+       model = "AMD Onyx BMC";
+       compatible = "amd,onyx-bmc", "aspeed,ast2600";
+
+       aliases {
+               serial0 = &uart1;
+               serial4 = &uart5;
+      };
+
+       chosen {
+               stdout-path = &uart5;
+               bootargs = "console=ttyS4,115200 earlyprintk vmalloc=512MB";
+       };
+
+       memory at 80000000 {
+               device_type = "memory";
+               reg = <0x80000000 0x80000000>;
+       };
+
+};
+
+&mdio0 {
+       status = "okay";
+
+       ethphy0: ethernet-phy at 0 {
+               compatible = "ethernet-phy-ieee802.3-c22";
+               reg = <0>;
+       };
+};
+
+&mac3 {
+       status = "okay";
+       phy-mode = "rgmii";
+       phy-handle = <&ethphy0>;
+
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
+
+
+
+&fmc {
+       status = "okay";
+       flash at 0 {
+               compatible = "jedec,spi-nor";
+               status = "okay";
+               #include "openbmc-flash-layout-128.dtsi"
+       };
+};
+
+//Host Console
+&uart1 {
+       status = "okay";
+};
+
+//BMC Console
+&uart5 {
+       status = "okay";
+};
+
+&gpio0 {
+        gpio-line-names =
+        /*A0-A7*/       "","","","","","","","",
+        /*B0-B7*/       "","","","","MON_POST_COMPLETE","P0_PRESENT_L","","",
+        /*C0-C7*/       "","","","","","","","",
+        /*D0-D7*/       "","","","","","","","",
+        /*E0-E7*/       "","","","","","","","",
+        /*F0-F7*/       "","","","","","","","",
+        /*G0-G7*/       "","","","","","","","",
+        /*H0-H7*/       "","ASSERT_WARM_RST_BTN_L","ASSERT_SOC_RST_BTN_L","","","","","",
+        /*I0-I7*/       "","","","","","","","P0_I3C_APML_ALERT_L",
+        /*J0-J7*/       "","","","","","","","",
+        /*K0-K7*/       "","","","","","","","",
+        /*L0-L7*/       "","","","","","","","",
+        /*M0-M7*/       "","","","","","","","",
+        /*N0-N7*/       "","","","","","","PSP_SOFT_FUSE_NOTIFY","ASSERT_BMC_READY",
+        /*O0-O7*/       "","","HDT_SEL","HDT_XTRIG5","HDT_XTRIG6","JTAG_TRST_N","","",
+        /*P0-P7*/       "MON_RST_BTN_L","ASSERT_RST_BTN_L","MON_PWR_BTN_L","ASSERT_PWR_BTN_L","HPM_FPGA_LOCKOUT","ASSERT_NMI_BTN_L","MON_PWR_GOOD","",
+        /*Q0-Q7*/       "","","HDT_DBREQ_L","","BIOS_SPD_MUX_CTRL_RELEASED_L","","","",
+        /*R0-R7*/       "","","","","","","","",
+        /*S0-S7*/       "","","","","","","P0_DIMM_AF_ERROR","P0_DIMM_GL_ERROR",
+        /*T0-T7*/       "","","","","","","","",
+        /*U0-U7*/       "","","","","","","","",
+        /*V0-V7*/       "","","","","","","","",
+        /*W0-W7*/       "","","","","","","","",
+        /*X0-X7*/       "","","","","","","","",
+        /*Y0-Y7*/       "","","","","","","","",
+        /*Z0-Z7*/       "","","","","","","","";
+};
-- 
2.34.1

