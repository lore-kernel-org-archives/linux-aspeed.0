From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 25 Apr 2024 16:36:59 -0500
Subject: [PATCH v3 12/14] ARM: dts: aspeed: Add IBM P11 FSI devices
In-Reply-To: <20240425213701.655540-1-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
Message-ID: <20240425213701.655540-13-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the P11 FSI device tree for use in upcoming BMC systems.
Unlike P10, there is no system with only two processors, so
only the quad processor FSI layout is necessary.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1696 +++++++++++++++++
 1 file changed, 1696 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi

diff --git a/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
new file mode 100644
index 000000000000..c3a0ecf12aa0
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
@@ -0,0 +1,1696 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2024 IBM Corp.
+
+&fsim0 {
+	status = "okay";
+
+	#address-cells = <2>;
+	#size-cells = <0>;
+
+	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
+
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
+			compatible = "ibm,i2c-fsi";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam0_i2c0: i2c-bus at 0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;	/* OMI01 */
+			};
+
+			cfam0_i2c1: i2c-bus at 1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;	/* OMI23 */
+			};
+
+			cfam0_i2c10: i2c-bus at a {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam0_i2c11: i2c-bus at b {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam0_i2c12: i2c-bus at c {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <12>;	/* OP4A */
+			};
+
+			cfam0_i2c13: i2c-bus at d {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <13>;	/* OP4B */
+			};
+
+			cfam0_i2c14: i2c-bus at e {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam0_i2c15: i2c-bus at f {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <15>;	/* OP5B */
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam0_spi0: spi at 0 {
+				compatible = "ibm,p10-spi";
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam0_spi1: spi at 20 {
+				compatible = "ibm,p10-spi";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam0_spi2: spi at 40 {
+				compatible = "ibm,p10-spi";
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam0_spi3: spi at 60 {
+				compatible = "ibm,p10-spi";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
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
+				compatible = "ibm,p10-occ";
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub0: hub at 3400 {
+			compatible = "ibm,hub-fsi-controller";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
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
+			compatible = "ibm,i2c-fsi";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam1_i2c2: i2c-bus at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;	/* OMI45 */
+			};
+
+			cfam1_i2c3: i2c-bus at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;	/* OMI67 */
+			};
+
+			cfam1_i2c10: i2c-bus at a {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam1_i2c11: i2c-bus at b {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam1_i2c14: i2c-bus at e {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam1_i2c15: i2c-bus at f {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <15>;	/* OP5B */
+			};
+
+			cfam1_i2c16: i2c-bus at 10 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <16>;	/* OP6A */
+			};
+
+			cfam1_i2c17: i2c-bus at 11 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <17>;	/* OP6B */
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam1_spi0: spi at 0 {
+				compatible = "ibm,p10-spi";
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam1_spi1: spi at 20 {
+				compatible = "ibm,p10-spi";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam1_spi2: spi at 40 {
+				compatible = "ibm,p10-spi";
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam1_spi3: spi at 60 {
+				compatible = "ibm,p10-spi";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
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
+				compatible = "ibm,p10-occ";
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub1: hub at 3400 {
+			compatible = "ibm,hub-fsi-controller";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+
+	cfam at 2,0 {
+		reg = <2 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <2>;
+
+		scom at 1000 {
+			compatible = "ibm,fsi2pib";
+			reg = <0x1000 0x400>;
+		};
+
+		i2c at 1800 {
+			compatible = "ibm,i2c-fsi";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam2_i2c0: i2c-bus at 0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;	/* OM01 */
+			};
+
+			cfam2_i2c1: i2c-bus at 1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;	/* OM23 */
+			};
+
+			cfam2_i2c10: i2c-bus at a {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam2_i2c11: i2c-bus at b {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam2_i2c12: i2c-bus at c {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <12>;	/* OP4A */
+			};
+
+			cfam2_i2c13: i2c-bus at d {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <13>;	/* OP4B */
+			};
+
+			cfam2_i2c14: i2c-bus at e {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam2_i2c15: i2c-bus at f {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <15>;	/* OP5B */
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam2_spi0: spi at 0 {
+				compatible = "ibm,p10-spi";
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam2_spi1: spi at 20 {
+				compatible = "ibm,p10-spi";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam2_spi2: spi at 40 {
+				compatible = "ibm,p10-spi";
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam2_spi3: spi at 60 {
+				compatible = "ibm,p10-spi";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+		};
+
+		sbefifo at 2400 {
+			compatible = "ibm,p9-sbefifo";
+			reg = <0x2400 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			fsi_occ2: occ {
+				compatible = "ibm,p10-occ";
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub2: hub at 3400 {
+			compatible = "ibm,hub-fsi-controller";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+
+	cfam at 3,0 {
+		reg = <3 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <3>;
+
+		scom at 1000 {
+			compatible = "ibm,fsi2pib";
+			reg = <0x1000 0x400>;
+		};
+
+		i2c at 1800 {
+			compatible = "ibm,i2c-fsi";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam3_i2c2: i2c-bus at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;	/* OM45 */
+			};
+
+			cfam3_i2c3: i2c-bus at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;	/* OM67 */
+			};
+
+			cfam3_i2c10: i2c-bus at a {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam3_i2c11: i2c-bus at b {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam3_i2c14: i2c-bus at e {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam3_i2c15: i2c-bus at f {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <15>;	/* OP5B */
+			};
+
+			cfam3_i2c16: i2c-bus at 10 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <16>;	/* OP6A */
+			};
+
+			cfam3_i2c17: i2c-bus at 11 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <17>;	/* OP6B */
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam3_spi0: spi at 0 {
+				compatible = "ibm,p10-spi";
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam3_spi1: spi at 20 {
+				compatible = "ibm,p10-spi";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam3_spi2: spi at 40 {
+				compatible = "ibm,p10-spi";
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam3_spi3: spi at 60 {
+				compatible = "ibm,p10-spi";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					size = <0x80000>;
+					address-width = <24>;
+					pagesize = <256>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+		};
+
+		sbefifo at 2400 {
+			compatible = "ibm,p9-sbefifo";
+			reg = <0x2400 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			fsi_occ3: occ {
+				compatible = "ibm,p10-occ";
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub3: hub at 3400 {
+			compatible = "ibm,hub-fsi-controller";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+};
+
+&cfam0_i2c0 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom100: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo100: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam0_i2c1 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom101: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo101: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam0_i2c10 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom110: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo110: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam0_i2c11 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom111: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo111: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam0_i2c12 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom112: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo112: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam0_i2c13 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom113: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo113: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam0_i2c14 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom114: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo114: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam0_i2c15 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom115: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo115: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam1_i2c2 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom202: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo202: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam1_i2c3 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom203: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo203: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam1_i2c10 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom210: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo210: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam1_i2c11 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom211: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo211: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam1_i2c14 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom214: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo214: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam1_i2c15 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom215: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo215: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam1_i2c16 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom216: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo216: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam1_i2c17 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom217: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo217: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam2_i2c0 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom300: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo300: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam2_i2c1 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom301: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo301: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam2_i2c10 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom310: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo310: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam2_i2c11 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom311: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo311: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam2_i2c12 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom312: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo312: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam2_i2c13 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom313: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo313: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam2_i2c14 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom314: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo314: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam2_i2c15 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom315: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo315: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam3_i2c2 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom402: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo402: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam3_i2c3 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom403: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo403: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam3_i2c10 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom410: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo410: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam3_i2c11 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom411: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo411: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam3_i2c14 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom414: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo414: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam3_i2c15 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom415: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo415: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam3_i2c16 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom416: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo416: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&cfam3_i2c17 {
+	fsi-i2cr at 20 {
+		compatible = "ibm,i2cr-fsi-master";
+		reg = <0x20>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cfam at 0,0 {
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			chip-id = <0>;
+
+			scom417: scom at 1000 {
+				compatible = "ibm,i2cr-scom";
+				reg = <0x1000 0x400>;
+			};
+
+			sbefifo417: sbefifo at 2400 {
+				compatible = "ibm,odyssey-sbefifo";
+				reg = <0x2400 0x400>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
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
+&fsi_occ2 {
+	reg = <3>;
+};
+
+&fsi_occ3 {
+	reg = <4>;
+};
+
+/ {
+	aliases {
+		i2c100 = &cfam0_i2c0;
+		i2c101 = &cfam0_i2c1;
+		i2c110 = &cfam0_i2c10;
+		i2c111 = &cfam0_i2c11;
+		i2c112 = &cfam0_i2c12;
+		i2c113 = &cfam0_i2c13;
+		i2c114 = &cfam0_i2c14;
+		i2c115 = &cfam0_i2c15;
+		i2c202 = &cfam1_i2c2;
+		i2c203 = &cfam1_i2c3;
+		i2c210 = &cfam1_i2c10;
+		i2c211 = &cfam1_i2c11;
+		i2c214 = &cfam1_i2c14;
+		i2c215 = &cfam1_i2c15;
+		i2c216 = &cfam1_i2c16;
+		i2c217 = &cfam1_i2c17;
+		i2c300 = &cfam2_i2c0;
+		i2c301 = &cfam2_i2c1;
+		i2c310 = &cfam2_i2c10;
+		i2c311 = &cfam2_i2c11;
+		i2c312 = &cfam2_i2c12;
+		i2c313 = &cfam2_i2c13;
+		i2c314 = &cfam2_i2c14;
+		i2c315 = &cfam2_i2c15;
+		i2c402 = &cfam3_i2c2;
+		i2c403 = &cfam3_i2c3;
+		i2c410 = &cfam3_i2c10;
+		i2c411 = &cfam3_i2c11;
+		i2c414 = &cfam3_i2c14;
+		i2c415 = &cfam3_i2c15;
+		i2c416 = &cfam3_i2c16;
+		i2c417 = &cfam3_i2c17;
+
+		sbefifo100 = &sbefifo100;
+		sbefifo101 = &sbefifo101;
+		sbefifo110 = &sbefifo110;
+		sbefifo111 = &sbefifo111;
+		sbefifo112 = &sbefifo112;
+		sbefifo113 = &sbefifo113;
+		sbefifo114 = &sbefifo114;
+		sbefifo115 = &sbefifo115;
+		sbefifo202 = &sbefifo202;
+		sbefifo203 = &sbefifo203;
+		sbefifo210 = &sbefifo210;
+		sbefifo211 = &sbefifo211;
+		sbefifo214 = &sbefifo214;
+		sbefifo215 = &sbefifo215;
+		sbefifo216 = &sbefifo216;
+		sbefifo217 = &sbefifo217;
+		sbefifo300 = &sbefifo300;
+		sbefifo301 = &sbefifo301;
+		sbefifo310 = &sbefifo310;
+		sbefifo311 = &sbefifo311;
+		sbefifo312 = &sbefifo312;
+		sbefifo313 = &sbefifo313;
+		sbefifo314 = &sbefifo314;
+		sbefifo315 = &sbefifo315;
+		sbefifo402 = &sbefifo402;
+		sbefifo403 = &sbefifo403;
+		sbefifo410 = &sbefifo410;
+		sbefifo411 = &sbefifo411;
+		sbefifo414 = &sbefifo414;
+		sbefifo415 = &sbefifo415;
+		sbefifo416 = &sbefifo416;
+		sbefifo417 = &sbefifo417;
+
+		scom100 = &scom100;
+		scom101 = &scom101;
+		scom110 = &scom110;
+		scom111 = &scom111;
+		scom112 = &scom112;
+		scom113 = &scom113;
+		scom114 = &scom114;
+		scom115 = &scom115;
+		scom202 = &scom202;
+		scom203 = &scom203;
+		scom210 = &scom210;
+		scom211 = &scom211;
+		scom214 = &scom214;
+		scom215 = &scom215;
+		scom216 = &scom216;
+		scom217 = &scom217;
+		scom300 = &scom300;
+		scom301 = &scom301;
+		scom310 = &scom310;
+		scom311 = &scom311;
+		scom312 = &scom312;
+		scom313 = &scom313;
+		scom314 = &scom314;
+		scom315 = &scom315;
+		scom402 = &scom402;
+		scom403 = &scom403;
+		scom410 = &scom410;
+		scom411 = &scom411;
+		scom414 = &scom414;
+		scom415 = &scom415;
+		scom416 = &scom416;
+		scom417 = &scom417;
+
+		spi10 = &cfam0_spi0;
+		spi11 = &cfam0_spi1;
+		spi12 = &cfam0_spi2;
+		spi13 = &cfam0_spi3;
+		spi20 = &cfam1_spi0;
+		spi21 = &cfam1_spi1;
+		spi22 = &cfam1_spi2;
+		spi23 = &cfam1_spi3;
+		spi30 = &cfam2_spi0;
+		spi31 = &cfam2_spi1;
+		spi32 = &cfam2_spi2;
+		spi33 = &cfam2_spi3;
+		spi40 = &cfam3_spi0;
+		spi41 = &cfam3_spi1;
+		spi42 = &cfam3_spi2;
+		spi43 = &cfam3_spi3;
+	};
+};
-- 
2.39.3

