From: Joel Stanley <joel@jms.id.au>
Date: Fri,  5 Apr 2019 13:44:16 +1030
Subject: [PATCH v2] ARM: dts: aspeed: Add Power9 and Power9 CFAM description
Message-ID: <20190405031416.10084-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

To be used by the OpenPower BMC machines.

This provides proper chip IDs but also adds the various sub-devices
necessary for the future OCC driver among other. All the added nodes
comply with the existing upstream FSI bindings.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: The first version of this used a bit more magic and was nak'd by
Olof. I've reworked it to not use macros. It still needs to be included
in the parent device tree after the fsi node is created.

 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts  |   2 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |  22 ++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |   8 +
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   |   2 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |   2 +
 arch/arm/boot/dts/ibm-power9-dual.dtsi        | 248 ++++++++++++++++++
 6 files changed, 284 insertions(+)
 create mode 100644 arch/arm/boot/dts/ibm-power9-dual.dtsi

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
index 024e52a6cd0f..de95112e2a04 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
@@ -322,3 +322,5 @@
 &adc {
 	status = "okay";
 };
+
+#include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
index b249da80fb83..b0cb34ccb135 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
@@ -347,3 +347,25 @@
 		line-name = "BMC_TPM_INT_N";
 	};
 };
+
+&fsi {
+	cfam at 0,0 {
+		reg = <0 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <0>;
+
+		scom at 1000 {
+			compatible = "ibm,fsi2pib";
+			reg = <0x1000 0x400>;
+		};
+
+		fsi_hub0: hub at 3400 {
+			compatible = "ibm,fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			no-scan-on-init;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 76fe994f2ba4..5a6bbb3b6640 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -296,3 +296,11 @@
 &adc {
 	status = "okay";
 };
+
+&gfx {
+     status = "okay";
+     memory-region = <&gfx_memory>;
+};
+
+#include "ibm-power9-dual.dtsi"
+
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index ad54117c075e..a0a4a0c6bc2a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -592,3 +592,5 @@
 &adc {
 	status = "okay";
 };
+
+#include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index 2c5aa90a546d..05df11cacb21 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -435,3 +435,5 @@
 &ibt {
 	status = "okay";
 };
+
+#include "ibm-power9-dual.dtsi"
diff --git a/arch/arm/boot/dts/ibm-power9-dual.dtsi b/arch/arm/boot/dts/ibm-power9-dual.dtsi
new file mode 100644
index 000000000000..2abc42eda7b0
--- /dev/null
+++ b/arch/arm/boot/dts/ibm-power9-dual.dtsi
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2018 IBM Corp
+
+&fsi {
+	cfam at 0,0 {
+		reg = <0 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <0>;
+
+		scom at 1000 {
+			compatible = "ibm,fsi2pib";
+			reg = <0x1000 0x400>;
+		};
+
+		i2c at 1800 {
+			compatible = "ibm,fsi-i2c-master";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam0_i2c0: i2c-bus at 0 {
+				reg = <0>;
+			};
+
+			cfam0_i2c1: i2c-bus at 1 {
+				reg = <1>;
+			};
+
+			cfam0_i2c2: i2c-bus at 2 {
+				reg = <2>;
+			};
+
+			cfam0_i2c3: i2c-bus at 3 {
+				reg = <3>;
+			};
+
+			cfam0_i2c4: i2c-bus at 4 {
+				reg = <4>;
+			};
+
+			cfam0_i2c5: i2c-bus at 5 {
+				reg = <5>;
+			};
+
+			cfam0_i2c6: i2c-bus at 6 {
+				reg = <6>;
+			};
+
+			cfam0_i2c7: i2c-bus at 7 {
+				reg = <7>;
+			};
+
+			cfam0_i2c8: i2c-bus at 8 {
+				reg = <8>;
+			};
+
+			cfam0_i2c9: i2c-bus at 9 {
+				reg = <9>;
+			};
+
+			cfam0_i2c10: i2c-bus at a {
+				reg = <10>;
+			};
+
+			cfam0_i2c11: i2c-bus at b {
+				reg = <11>;
+			};
+
+			cfam0_i2c12: i2c-bus at c {
+				reg = <12>;
+			};
+
+			cfam0_i2c13: i2c-bus at d {
+				reg = <13>;
+			};
+
+			cfam0_i2c14: i2c-bus at e {
+				reg = <14>;
+			};
+		};
+
+		sbefifo at 2400 {
+			compatible = "ibm,p9-sbefifo";
+			reg = <0x2400 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			fsi_occ0: occ {
+				compatible = "ibm,p9-occ";
+			};
+		};
+
+		fsi_hub0: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+};
+
+&fsi_hub0 {
+	cfam at 1,0 {
+		reg = <1 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <1>;
+
+		scom at 1000 {
+			compatible = "ibm,fsi2pib";
+			reg = <0x1000 0x400>;
+		};
+
+		i2c at 1800 {
+			compatible = "ibm,fsi-i2c-master";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam1_i2c0: i2c-bus at 0 {
+				reg = <0>;
+			};
+
+			cfam1_i2c1: i2c-bus at 1 {
+				reg = <1>;
+			};
+
+			cfam1_i2c2: i2c-bus at 2 {
+				reg = <2>;
+			};
+
+			cfam1_i2c3: i2c-bus at 3 {
+				reg = <3>;
+			};
+
+			cfam1_i2c4: i2c-bus at 4 {
+				reg = <4>;
+			};
+
+			cfam1_i2c5: i2c-bus at 5 {
+				reg = <5>;
+			};
+
+			cfam1_i2c6: i2c-bus at 6 {
+				reg = <6>;
+			};
+
+			cfam1_i2c7: i2c-bus at 7 {
+				reg = <7>;
+			};
+
+			cfam1_i2c8: i2c-bus at 8 {
+				reg = <8>;
+			};
+
+			cfam1_i2c9: i2c-bus at 9 {
+				reg = <9>;
+			};
+
+			cfam1_i2c10: i2c-bus at a {
+				reg = <10>;
+			};
+
+			cfam1_i2c11: i2c-bus at b {
+				reg = <11>;
+			};
+
+			cfam1_i2c12: i2c-bus at c {
+				reg = <12>;
+			};
+
+			cfam1_i2c13: i2c-bus at d {
+				reg = <13>;
+			};
+
+			cfam1_i2c14: i2c-bus at e {
+				reg = <14>;
+			};
+		};
+
+		sbefifo at 2400 {
+			compatible = "ibm,p9-sbefifo";
+			reg = <0x2400 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			fsi_occ1: occ {
+				compatible = "ibm,p9-occ";
+			};
+		};
+
+		fsi_hub1: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+};
+
+/* Legacy OCC numbering (to get rid of when userspace is fixed) */
+&fsi_occ0 {
+	reg = <1>;
+};
+
+&fsi_occ1 {
+	reg = <2>;
+};
+
+/ {
+	aliases {
+		i2c100 = &cfam0_i2c0;
+		i2c101 = &cfam0_i2c1;
+		i2c102 = &cfam0_i2c2;
+		i2c103 = &cfam0_i2c3;
+		i2c104 = &cfam0_i2c4;
+		i2c105 = &cfam0_i2c5;
+		i2c106 = &cfam0_i2c6;
+		i2c107 = &cfam0_i2c7;
+		i2c108 = &cfam0_i2c8;
+		i2c109 = &cfam0_i2c9;
+		i2c110 = &cfam0_i2c10;
+		i2c111 = &cfam0_i2c11;
+		i2c112 = &cfam0_i2c12;
+		i2c113 = &cfam0_i2c13;
+		i2c114 = &cfam0_i2c14;
+		i2c200 = &cfam1_i2c0;
+		i2c201 = &cfam1_i2c1;
+		i2c202 = &cfam1_i2c2;
+		i2c203 = &cfam1_i2c3;
+		i2c204 = &cfam1_i2c4;
+		i2c205 = &cfam1_i2c5;
+		i2c206 = &cfam1_i2c6;
+		i2c207 = &cfam1_i2c7;
+		i2c208 = &cfam1_i2c8;
+		i2c209 = &cfam1_i2c9;
+		i2c210 = &cfam1_i2c10;
+		i2c211 = &cfam1_i2c11;
+		i2c212 = &cfam1_i2c12;
+		i2c213 = &cfam1_i2c13;
+		i2c214 = &cfam1_i2c14;
+	};
+};
-- 
2.20.1

