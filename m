From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:19 -0500
Subject: [PATCH 21/22] ARM: dts: aspeed: rainier: Support pass 2 planar
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-22-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Alpana Kumari <alpankum@in.ibm.com>

Add device trees for the second version of the Rainier system planar.
Include the original dts and make the necessary changes.

Signed-off-by: Alpana Kumari <alpankum@in.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/Makefile                    |   2 +
 .../boot/dts/aspeed-bmc-ibm-rainier-4u-v2.dts | 198 ++++++++++++++++++
 .../boot/dts/aspeed-bmc-ibm-rainier-v2.dts    | 198 ++++++++++++++++++
 3 files changed, 398 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u-v2.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-rainier-v2.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9fb6086a53c9..c2c8ec8c1cd5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1423,7 +1423,9 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-yosemitev2.dtb \
 	aspeed-bmc-ibm-everest.dtb \
 	aspeed-bmc-ibm-rainier.dtb \
+	aspeed-bmc-ibm-rainier-v2.dtb \
 	aspeed-bmc-ibm-rainier-4u.dtb \
+	aspeed-bmc-ibm-rainier-4u-v2.dtb \
 	aspeed-bmc-intel-s2600wf.dtb \
 	aspeed-bmc-inspur-fp5280g2.dtb \
 	aspeed-bmc-lenovo-hr630.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u-v2.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u-v2.dts
new file mode 100644
index 000000000000..6712b2e7e7b5
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u-v2.dts
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2021 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-bmc-ibm-rainier-4u.dts"
+
+/ {
+	i2c20 = &i2c4mux0chn0;
+	i2c21 = &i2c4mux0chn1;
+	i2c22 = &i2c4mux0chn2;
+	i2c23 = &i2c5mux0chn0;
+	i2c24 = &i2c5mux0chn1;
+	i2c25 = &i2c6mux0chn0;
+	i2c26 = &i2c6mux0chn1;
+	i2c27 = &i2c6mux0chn2;
+	i2c28 = &i2c6mux0chn3;
+	i2c29 = &i2c11mux0chn0;
+	i2c30 = &i2c11mux0chn1;
+};
+
+&i2c4 {
+	/delete-node/ eeprom at 50;
+	/delete-node/ eeprom at 51;
+	/delete-node/ eeprom at 52;
+
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c4mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c4mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+
+		i2c4mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+	};
+};
+
+&i2c5 {
+	/delete-node/ eeprom at 50;
+	/delete-node/ eeprom at 51;
+
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c5mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c5mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+	};
+};
+
+&i2c6 {
+	/delete-node/ eeprom at 50;
+	/delete-node/ eeprom at 51;
+	/delete-node/ eeprom at 52;
+	/delete-node/ eeprom at 53;
+
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c6mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+
+		i2c6mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+		};
+
+		i2c6mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+	};
+};
+
+&i2c11 {
+	/delete-node/ eeprom at 50;
+	/delete-node/ eeprom at 51;
+
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c11mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-v2.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-v2.dts
new file mode 100644
index 000000000000..24cf12150919
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier-v2.dts
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2021 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-bmc-ibm-rainier.dts"
+
+/ {
+	i2c20 = &i2c4mux0chn0;
+	i2c21 = &i2c4mux0chn1;
+	i2c22 = &i2c4mux0chn2;
+	i2c23 = &i2c5mux0chn0;
+	i2c24 = &i2c5mux0chn1;
+	i2c25 = &i2c6mux0chn0;
+	i2c26 = &i2c6mux0chn1;
+	i2c27 = &i2c6mux0chn2;
+	i2c28 = &i2c6mux0chn3;
+	i2c29 = &i2c11mux0chn0;
+	i2c30 = &i2c11mux0chn1;
+};
+
+&i2c4 {
+	/delete-node/ eeprom at 50;
+	/delete-node/ eeprom at 51;
+	/delete-node/ eeprom at 52;
+
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c4mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c4mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+
+		i2c4mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+	};
+};
+
+&i2c5 {
+	/delete-node/ eeprom at 50;
+	/delete-node/ eeprom at 51;
+
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c5mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c5mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+	};
+};
+
+&i2c6 {
+	/delete-node/ eeprom at 50;
+	/delete-node/ eeprom at 51;
+	/delete-node/ eeprom at 52;
+	/delete-node/ eeprom at 53;
+
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c6mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+
+		i2c6mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+		};
+
+		i2c6mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+	};
+};
+
+&i2c11 {
+	/delete-node/ eeprom at 50;
+	/delete-node/ eeprom at 51;
+
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c11mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+	};
+};
-- 
2.27.0

