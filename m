From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 26 Aug 2022 14:51:41 -0500
Subject: [PATCH] ARM: dts: aspeed: Add IBM Bonnell system BMC devicetree
Message-ID: <20220826195141.165631-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Bonnell is an IBM Power10 server system with an AST2600 BMC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Jim Wright <wrightj@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 909 +++++++++++++++++++
 2 files changed, 910 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e49185119b5b..add4d52ab718 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1594,6 +1594,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-wedge400.dtb \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-facebook-yosemitev2.dtb \
+	aspeed-bmc-ibm-bonnell.dtb \
 	aspeed-bmc-ibm-everest.dtb \
 	aspeed-bmc-ibm-rainier.dtb \
 	aspeed-bmc-ibm-rainier-1s4u.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
new file mode 100644
index 000000000000..6789c1ec286a
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
@@ -0,0 +1,909 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2022 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+
+/ {
+	model = "Bonnell";
+	compatible = "ibm,bonnell-bmc", "aspeed,ast2600";
+
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
+
+		serial4 = &uart5;
+		i2c16 = &i2c11mux0chn0;
+		i2c17 = &i2c11mux0chn1;
+		i2c18 = &i2c11mux0chn2;
+		i2c19 = &i2c11mux0chn3;
+
+		spi10 = &cfam0_spi0;
+		spi11 = &cfam0_spi1;
+		spi12 = &cfam0_spi2;
+		spi13 = &cfam0_spi3;
+		spi20 = &cfam1_spi0;
+		spi21 = &cfam1_spi1;
+		spi22 = &cfam1_spi2;
+		spi23 = &cfam1_spi3;
+
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200n8 earlycon";
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		flash_memory: region at b8000000 {
+			no-map;
+			reg = <0xb8000000 0x04000000>; /* 64M */
+		};
+
+		ramoops at bc000000 {
+			compatible = "ramoops";
+			reg = <0xbc000000 0x200000>; /* 16 * (4 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
+		vga_memory: region at bf000000 {
+			no-map;
+			compatible = "shared-dma-pool";
+			reg = <0xbf000000 0x01000000>;  /* 16M */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fan0 {
+			gpios = <&gpio0 ASPEED_GPIO(G, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		fan1 {
+			gpios = <&gpio0 ASPEED_GPIO(G, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		rear-enc-id0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		rear-enc-fault0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <1000>;
+
+		fan0-presence {
+			label = "fan0-presence";
+			gpios = <&gpio0 ASPEED_GPIO(F, 4) GPIO_ACTIVE_LOW>;
+			linux,code = <6>;
+		};
+
+		fan1-presence {
+			label = "fan1-presence";
+			gpios = <&gpio0 ASPEED_GPIO(F, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <7>;
+		};
+	};
+
+	iio-hwmon-battery {
+		compatible = "iio-hwmon";
+		io-channels = <&adc1 7>;
+	};
+};
+
+&adc1 {
+	status = "okay";
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+		/*A0-A7*/	"","","","","","","","",
+		/*B0-B7*/	"","","","","","","checkstop","",
+		/*C0-C7*/	"","","","","","","","",
+		/*D0-D7*/	"","","","","","","","",
+		/*E0-E7*/	"","","","","","","","",
+		/*F0-F7*/	"","","rtc-battery-voltage-read-enable","reset-cause-pinhole","","","","",
+		/*G0-G7*/	"fan0","fan1","","","","","","",
+		/*H0-H7*/	"","","rear-enc-id0","rear-enc-fault0","","","","",
+		/*I0-I7*/	"","","","","","","bmc-secure-boot","",
+		/*J0-J7*/	"","","","","","","","",
+		/*K0-K7*/	"","","","","","","","",
+		/*L0-L7*/	"","","","","","","","",
+		/*M0-M7*/	"","","","","","","","",
+		/*N0-N7*/	"","","","","","","","",
+		/*O0-O7*/	"","","","usb-power","","","","",
+		/*P0-P7*/	"","","","","","","","",
+		/*Q0-Q7*/	"cfam-reset","","regulator-standby-faulted","","","","","",
+		/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","","","",
+		/*S0-S7*/	"presence-ps0","presence-ps1","","","power-ffs-sync-history","","","",
+		/*T0-T7*/	"","","","","","","","",
+		/*U0-U7*/	"","","","","","","","",
+		/*V0-V7*/	"","","","","","","","",
+		/*W0-W7*/	"","","","","","","","",
+		/*X0-X7*/	"","","","","","","","",
+		/*Y0-Y7*/	"","","","","","","","",
+		/*Z0-Z7*/	"","","","","","","","";
+
+	usb_power {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
+		output-high;
+	};
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&pinctrl_emmc_default {
+	bias-disable;
+};
+
+&emmc {
+	status = "okay";
+	clk-phase-mmc-hs200 = <180>, <180>;
+};
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
+			compatible = "ibm,fsi-i2c-master";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam0_i2c0: i2c-bus at 0 {
+				reg = <0>;	/* OMI01 */
+			};
+
+			cfam0_i2c1: i2c-bus at 1 {
+				reg = <1>;	/* OMI23 */
+			};
+
+			cfam0_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam0_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam0_i2c12: i2c-bus at c {
+				reg = <12>;	/* OP4A */
+			};
+
+			cfam0_i2c13: i2c-bus at d {
+				reg = <13>;	/* OP4B */
+			};
+
+			cfam0_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam0_i2c15: i2c-bus at f {
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
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam0_spi1: spi at 20 {
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam0_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible = "ibm,fsi2spi-restricted";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam0_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible = "ibm,fsi2spi-restricted";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
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
+			};
+		};
+
+		fsi_hub0: hub at 3400 {
+			compatible = "fsi-master-hub";
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
+			compatible = "ibm,fsi-i2c-master";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam1_i2c2: i2c-bus at 2 {
+				reg = <2>;	/* OMI45 */
+			};
+
+			cfam1_i2c3: i2c-bus at 3 {
+				reg = <3>;	/* OMI67 */
+			};
+
+			cfam1_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam1_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam1_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam1_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
+
+			cfam1_i2c16: i2c-bus at 10 {
+				reg = <16>;	/* OP6A */
+			};
+
+			cfam1_i2c17: i2c-bus at 11 {
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
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam1_spi1: spi at 20 {
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam1_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible = "ibm,fsi2spi-restricted";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam1_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible = "ibm,fsi2spi-restricted";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
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
+&ibt {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+
+	tca9554 at 20 {
+		compatible = "ti,tca9554";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names = "",
+			"RUSSEL_FW_I2C_ENABLE_N",
+			"RUSSEL_OPPANEL_PRESENCE_N",
+			"BLYTH_OPPANEL_PRESENCE_N",
+			"CPU_TPM_CARD_PRESENT_N",
+			"",
+			"",
+			"DASD_BP_PRESENT_N";
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	ucd90160 at 64 {
+		compatible = "ti,ucd90160";
+		reg = <0x64>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	power-supply at 58 {
+		compatible = "ibm,cffps";
+		reg = <0x58>;
+	};
+
+	power-supply at 59 {
+		compatible = "ibm,cffps";
+		reg = <0x59>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	multi-master;
+	status = "okay";
+
+	si7021-a20 at 40 {
+		compatible = "silabs,si7020";
+		reg = <0x40>;
+	};
+
+	tmp275 at 48 {
+		compatible = "ti,tmp275";
+		reg = <0x48>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	eeprom at 51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+
+	max31785 at 52 {
+		compatible = "maxim,max31785a";
+		reg = <0x52>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fan0: fan at 0 {
+			compatible = "pmbus-fan";
+			reg = <0>;
+			tach-pulses = <2>;
+		};
+
+		fan1: fan at 1 {
+			compatible = "pmbus-fan";
+			reg = <1>;
+			tach-pulses = <2>;
+		};
+	};
+
+	pca9551 at 60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "front-sys-id0";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "front-check-log0";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "front-enc-fault1";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "front-sys-pwron0";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	ibm-panel at 62 {
+		compatible = "ibm,op-panel";
+		reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	dps: dps310 at 76 {
+		compatible = "infineon,dps310";
+		reg = <0x76>;
+		#io-channel-cells = <0>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	rtc at 32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+
+	tmp275 at 48 {
+		compatible = "ti,tmp275";
+		reg = <0x48>;
+	};
+
+	eeprom at 51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+
+	pca9551 at 60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names = "",
+			"APSS_RESET_N",
+			"",
+			"N_MODE_CPU_N",
+			"",
+			"",
+			"P10_DCM_PRESENT",
+			"";
+	};
+};
+
+&i2c9 {
+	status = "okay";
+
+	tmp423a at 4c {
+		compatible = "ti,tmp423";
+		reg = <0x4c>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+
+	tca9554 at 20 {
+		compatible = "ti,tca9554";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names = "BOOT_RCVRY_TWI",
+			"BOOT_RCVRY_UART",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"PE_SWITCH_RSTB_N";
+	};
+
+	tmp435 at 4c {
+		compatible = "ti,tmp435";
+		reg = <0x4c>;
+	};
+
+	pca9849 at 75 {
+		compatible = "nxp,pca9849";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c11mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c11mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c11mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c11mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	tpm at 2e {
+		compatible = "nuvoton,npct75x";
+		reg = <0x2e>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	pca9551 at 60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "nvme0";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "nvme1";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "nvme2";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "nvme3";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+};
+
+&vuart2 {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
+		 <&syscon ASPEED_CLK_MAC3RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
+&mac3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii4_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>,
+		 <&syscon ASPEED_CLK_MAC4RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
+&wdt1 {
+	aspeed,reset-type = "none";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&xdma {
+	status = "okay";
+	memory-region = <&vga_memory>;
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca8 0xcac>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
-- 
2.31.1

