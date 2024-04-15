From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 15 Apr 2024 15:49:51 -0000
Subject: [PATCH v2] ARM: dts: aspeed: Add IBM P11 BMC boards
Message-ID: <20240415154931.10775-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the Blueridge and Fuji BMC systems.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Change "ody" to "odyssey"

 arch/arm/boot/dts/aspeed/Makefile             |    2 +
 .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1752 +++++++
 .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 4016 +++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1704 +++++++
 4 files changed, 7474 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 715106b3baa1..783409b7c206 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -33,8 +33,10 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-facebook-yosemitev2.dtb \
 	aspeed-bmc-facebook-yosemite4.dtb \
+	aspeed-bmc-ibm-blueridge.dtb \
 	aspeed-bmc-ibm-bonnell.dtb \
 	aspeed-bmc-ibm-everest.dtb \
+	aspeed-bmc-ibm-fuji.dtb \
 	aspeed-bmc-ibm-rainier.dtb \
 	aspeed-bmc-ibm-rainier-1s4u.dtb \
 	aspeed-bmc-ibm-rainier-4u.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
new file mode 100644
index 000000000000..7b6b05a56173
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
@@ -0,0 +1,1752 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2024 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+
+/ {
+	model = "Blueridge";
+	compatible = "ibm,blueridge-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+		i2c16 = &i2c2mux0;
+		i2c17 = &i2c2mux1;
+		i2c18 = &i2c2mux2;
+		i2c19 = &i2c2mux3;
+		i2c20 = &i2c4mux0chn0;
+		i2c21 = &i2c4mux0chn1;
+		i2c22 = &i2c4mux0chn2;
+		i2c23 = &i2c5mux0chn0;
+		i2c24 = &i2c5mux0chn1;
+		i2c25 = &i2c6mux0chn0;
+		i2c26 = &i2c6mux0chn1;
+		i2c27 = &i2c6mux0chn2;
+		i2c28 = &i2c6mux0chn3;
+		i2c29 = &i2c11mux0chn0;
+		i2c30 = &i2c11mux0chn1;
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
+		event_log: tcg_event_log at b3d00000 {
+			no-map;
+			reg = <0xb3d00000 0x100000>;
+		};
+
+		ramoops at b3e00000 {
+			compatible = "ramoops";
+			reg = <0xb3e00000 0x200000>; /* 16 * (4 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
+		/* LPC FW cycle bridge region requires natural alignment */
+		flash_memory: region at b4000000 {
+			no-map;
+			reg = <0xb4000000 0x04000000>; /* 64M */
+		};
+
+		/* VGA region is dictated by hardware strapping */
+		vga_memory: region at bf000000 {
+			no-map;
+			compatible = "shared-dma-pool";
+			reg = <0xbf000000 0x01000000>;  /* 16M */
+		};
+	};
+
+	i2c2mux: i2cmux {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		i2c-parent = <&i2c2>;
+		mux-gpios = <&gpio0 ASPEED_GPIO(G, 4) GPIO_ACTIVE_HIGH>,
+			    <&gpio0 ASPEED_GPIO(G, 5) GPIO_ACTIVE_HIGH>;
+		idle-state = <0>;
+
+		i2c2mux0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c2mux1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c2mux2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c2mux3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		/* BMC Card fault LED at the back */
+		bmc-ingraham0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		/* Enclosure ID LED at the back */
+		rear-enc-id0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		/* Enclosure fault LED at the back */
+		rear-enc-fault0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+		};
+
+		/* PCIE slot power LED */
+		pcieslot-power {
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <1000>;
+
+		event-fan0-presence {
+			label = "fan0-presence";
+			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
+			linux,code = <6>;
+		};
+
+		event-fan1-presence {
+			label = "fan1-presence";
+			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
+			linux,code = <7>;
+		};
+
+		event-fan2-presence {
+			label = "fan2-presence";
+			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
+			linux,code = <8>;
+		};
+
+		event-fan3-presence {
+			label = "fan3-presence";
+			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
+			linux,code = <9>;
+		};
+
+		event-fan4-presence {
+			label = "fan4-presence";
+			gpios = <&pca0 10 GPIO_ACTIVE_LOW>;
+			linux,code = <10>;
+		};
+
+		event-fan5-presence {
+			label = "fan5-presence";
+			gpios = <&pca0 11 GPIO_ACTIVE_LOW>;
+			linux,code = <11>;
+		};
+	};
+
+	iio-hwmon {
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
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"","","","","","","checkstop","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","rtc-battery-voltage-read-enable","reset-cause-pinhole","","","factory-reset-toggle","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"","bmc-ingraham0","rear-enc-id0","rear-enc-fault0","","","","",
+	/*I0-I7*/	"","","","","","","bmc-secure-boot","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","usb-power","","","","",
+	/*P0-P7*/	"","","","","pcieslot-power","","","",
+	/*Q0-Q7*/	"cfam-reset","","regulator-standby-faulted","","","","","",
+	/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","","","",
+	/*S0-S7*/	"presence-ps0","presence-ps1","presence-ps2","presence-ps3",
+	"power-ffs-sync-history","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+
+	i2c3_mux_oe_n {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(G, 6) GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "I2C3_MUX_OE_N";
+	};
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
+	tca_pres1: tca9554 at 20{
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
+			"DASD_BP2_PRESENT_N",
+			"DASD_BP1_PRESENT_N",
+			"DASD_BP0_PRESENT_N";
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+
+	power-supply at 68 {
+		compatible = "ibm,cffps";
+		reg = <0x68>;
+	};
+
+	power-supply at 69 {
+		compatible = "ibm,cffps";
+		reg = <0x69>;
+	};
+
+	pca_pres1: pca9552 at 61 {
+		compatible = "nxp,pca9552";
+		reg = <0x61>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"SLOT0_PRSNT_EN_RSVD", "SLOT1_PRSNT_EN_RSVD",
+			"SLOT2_PRSNT_EN_RSVD", "SLOT3_PRSNT_EN_RSVD",
+			"SLOT4_PRSNT_EN_RSVD", "SLOT0_EXPANDER_PRSNT_N",
+			"SLOT1_EXPANDER_PRSNT_N", "SLOT2_EXPANDER_PRSNT_N",
+			"SLOT3_EXPANDER_PRSNT_N", "SLOT4_EXPANDER_PRSNT_N",
+			"", "", "", "", "", "";
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	tmp275 at 48 {
+		compatible = "ti,tmp275";
+		reg = <0x48>;
+	};
+
+	tmp275 at 49 {
+		compatible = "ti,tmp275";
+		reg = <0x49>;
+	};
+
+	tmp275 at 4a {
+		compatible = "ti,tmp275";
+		reg = <0x4a>;
+	};
+
+	i2c-mux at 70 {
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
+
+			pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard0-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard0-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
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
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	tmp275 at 48 {
+		compatible = "ti,tmp275";
+		reg = <0x48>;
+	};
+
+	tmp275 at 49 {
+		compatible = "ti,tmp275";
+		reg = <0x49>;
+	};
+
+	i2c-mux at 70 {
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
+
+			pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard3-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard3-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
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
+
+			pca9551 at 61 {
+				compatible = "nxp,pca9551";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard4-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard4-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	tmp275 at 48 {
+		compatible = "ti,tmp275";
+		reg = <0x48>;
+	};
+
+	tmp275 at 4a {
+		compatible = "ti,tmp275";
+		reg = <0x4a>;
+	};
+
+	tmp275 at 4b {
+		compatible = "ti,tmp275";
+		reg = <0x4b>;
+	};
+
+	i2c-mux at 70 {
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
+&i2c7 {
+	multi-master;
+	status = "okay";
+
+	pca9552 at 30 {
+		compatible = "ibm,pca9552";
+		reg = <0x30>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "pcieslot0";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "pcieslot1";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "pcieslot2";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "pcieslot3";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "pcieslot4";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "cpu1";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "cpu-vrm1";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "lcd-russel";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pca9552 at 31 {
+		compatible = "ibm,pca9552";
+		reg = <0x31>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "ddimm0";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "ddimm1";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "ddimm2";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "ddimm3";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "ddimm4";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "ddimm5";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "ddimm6";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "ddimm7";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "ddimm8";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "ddimm9";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "ddimm10";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "ddimm11";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "ddimm12";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "ddimm13";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "ddimm14";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "ddimm15";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pca9552 at 32 {
+		compatible = "ibm,pca9552";
+		reg = <0x32>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "ddimm16";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "ddimm17";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "ddimm18";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "ddimm19";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "ddimm20";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "ddimm21";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "ddimm22";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "ddimm23";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "ddimm24";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "ddimm25";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "ddimm26";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "ddimm27";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "ddimm28";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "ddimm29";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "ddimm30";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "ddimm31";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pca9552 at 33 {
+		compatible = "ibm,pca9552";
+		reg = <0x33>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "planar";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "cpu0";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "dasd-pyramid0";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "dasd-pyramid1";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "dasd-pyramid2";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "cpu0-vrm0";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "rtc-battery";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "base-blyth";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "pcieslot6";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "pcieslot7";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "pcieslot8";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "pcieslot9";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "pcieslot10";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "pcieslot11";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "tpm-wilson";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
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
+	max: max31785 at 52 {
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
+
+		fan2: fan at 2 {
+			compatible = "pmbus-fan";
+			reg = <2>;
+			tach-pulses = <2>;
+		};
+
+		fan3: fan at 3 {
+			compatible = "pmbus-fan";
+			reg = <3>;
+			tach-pulses = <2>;
+		};
+
+		fan4: fan at 4 {
+			compatible = "pmbus-fan";
+			reg = <4>;
+			tach-pulses = <2>;
+		};
+
+		fan5: fan at 5 {
+			compatible = "pmbus-fan";
+			reg = <5>;
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
+	pca0: pca9552 at 61 {
+		compatible = "nxp,pca9552";
+		reg = <0x61>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "fan0";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "fan1";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "fan2";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "fan3";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "fan4";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "fan5";
+			reg = <5>;
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
+};
+
+&i2c8 {
+	status = "okay";
+
+	ucd90320 at 11 {
+		compatible = "ti,ucd90320";
+		reg = <0x11>;
+	};
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
+	tmp275 at 4a {
+		compatible = "ti,tmp275";
+		reg = <0x4a>;
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
+	pca_pres3: pca9552 at 60 {
+		compatible = "nxp,pca9552";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"", "", "", "", "", "", "", "",
+			"", "", "", "", "", "", "power-config-full-load", "";
+	};
+
+	pca_pres2: pca9552 at 61 {
+		compatible = "nxp,pca9552";
+		reg = <0x61>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"SLOT6_PRSNT_EN_RSVD", "SLOT7_PRSNT_EN_RSVD",
+			"SLOT8_PRSNT_EN_RSVD", "SLOT9_PRSNT_EN_RSVD",
+			"SLOT10_PRSNT_EN_RSVD", "SLOT11_PRSNT_EN_RSVD",
+			"SLOT6_EXPANDER_PRSNT_N", "SLOT7_EXPANDER_PRSNT_N",
+			"SLOT8_EXPANDER_PRSNT_N", "SLOT9_EXPANDER_PRSNT_N",
+			"SLOT10_EXPANDER_PRSNT_N", "SLOT11_EXPANDER_PRSNT_N",
+			"", "", "", "";
+	};
+
+};
+
+&i2c9 {
+	status = "okay";
+
+	tmp423a at 4c {
+		compatible = "ti,tmp423";
+		reg = <0x4c>;
+	};
+
+	tmp423b at 4d {
+		compatible = "ti,tmp423";
+		reg = <0x4d>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	tmp423a at 4c {
+		compatible = "ti,tmp423";
+		reg = <0x4c>;
+	};
+
+	tmp423b at 4d {
+		compatible = "ti,tmp423";
+		reg = <0x4d>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	tmp275 at 48 {
+		compatible = "ti,tmp275";
+		reg = <0x48>;
+	};
+
+	tmp275 at 49 {
+		compatible = "ti,tmp275";
+		reg = <0x49>;
+	};
+
+	i2c-mux at 70 {
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
+
+			pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard10-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard10-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
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
+
+&i2c12 {
+	status = "okay";
+
+	tpm at 2e {
+		compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+		memory-region = <&event_log>;
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
+	pca9552 at 60 {
+		compatible = "nxp,pca9552";
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
+
+		led at 4 {
+			label = "nvme4";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "nvme5";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "nvme6";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "nvme7";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+};
+
+&i2c14 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	pca9552 at 60 {
+		compatible = "nxp,pca9552";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "nvme8";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "nvme9";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "nvme10";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "nvme11";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "nvme12";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "nvme13";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "nvme14";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "nvme15";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+};
+
+&i2c15 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	pca9552 at 60 {
+		compatible = "nxp,pca9552";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "nvme16";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "nvme17";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "nvme18";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "nvme19";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "nvme20";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "nvme21";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "nvme22";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "nvme23";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+};
+
+&uart2 {
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
+
+#include "ibm-power11-quad.dtsi"
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
new file mode 100644
index 000000000000..7e0a207936d4
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
@@ -0,0 +1,4016 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2024 IBM Corp.
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+
+/ {
+	model = "Fuji";
+	compatible = "ibm,fuji-bmc", "aspeed,ast2600";
+
+	aliases {
+		i2c500 = &cfam4_i2c0;
+		i2c501 = &cfam4_i2c1;
+		i2c510 = &cfam4_i2c10;
+		i2c511 = &cfam4_i2c11;
+		i2c512 = &cfam4_i2c12;
+		i2c513 = &cfam4_i2c13;
+		i2c514 = &cfam4_i2c14;
+		i2c515 = &cfam4_i2c15;
+		i2c602 = &cfam5_i2c2;
+		i2c603 = &cfam5_i2c3;
+		i2c610 = &cfam5_i2c10;
+		i2c611 = &cfam5_i2c11;
+		i2c614 = &cfam5_i2c14;
+		i2c615 = &cfam5_i2c15;
+		i2c616 = &cfam5_i2c16;
+		i2c617 = &cfam5_i2c17;
+		i2c700 = &cfam6_i2c0;
+		i2c701 = &cfam6_i2c1;
+		i2c710 = &cfam6_i2c10;
+		i2c711 = &cfam6_i2c11;
+		i2c712 = &cfam6_i2c12;
+		i2c713 = &cfam6_i2c13;
+		i2c714 = &cfam6_i2c14;
+		i2c715 = &cfam6_i2c15;
+		i2c802 = &cfam7_i2c2;
+		i2c803 = &cfam7_i2c3;
+		i2c810 = &cfam7_i2c10;
+		i2c811 = &cfam7_i2c11;
+		i2c814 = &cfam7_i2c14;
+		i2c815 = &cfam7_i2c15;
+		i2c816 = &cfam7_i2c16;
+		i2c817 = &cfam7_i2c17;
+
+		i2c16 = &i2c4mux0chn0;
+		i2c17 = &i2c4mux0chn1;
+		i2c18 = &i2c4mux0chn2;
+		i2c19 = &i2c5mux0chn0;
+		i2c20 = &i2c5mux0chn1;
+		i2c21 = &i2c5mux0chn2;
+		i2c22 = &i2c5mux0chn3;
+		i2c23 = &i2c6mux0chn0;
+		i2c24 = &i2c6mux0chn1;
+		i2c25 = &i2c6mux0chn2;
+		i2c26 = &i2c6mux0chn3;
+		i2c27 = &i2c14mux0chn0;
+		i2c28 = &i2c14mux0chn1;
+		i2c29 = &i2c14mux0chn2;
+		i2c30 = &i2c14mux0chn3;
+		i2c31 = &i2c14mux1chn0;
+		i2c32 = &i2c14mux1chn1;
+		i2c33 = &i2c14mux1chn2;
+		i2c34 = &i2c14mux1chn3;
+		i2c35 = &i2c15mux0chn0;
+		i2c36 = &i2c15mux0chn1;
+		i2c37 = &i2c15mux0chn2;
+		i2c38 = &i2c15mux0chn3;
+		i2c39 = &i2c15mux1chn0;
+		i2c40 = &i2c15mux1chn1;
+		i2c41 = &i2c15mux1chn2;
+		i2c42 = &i2c15mux1chn3;
+		i2c43 = &i2c15mux2chn0;
+		i2c44 = &i2c15mux2chn1;
+		i2c45 = &i2c15mux2chn2;
+		i2c46 = &i2c15mux2chn3;
+		i2c47 = &i2c8mux0chn0;
+		i2c48 = &i2c8mux0chn1;
+
+		serial4 = &uart5;
+
+		sbefifo500 = &sbefifo500;
+		sbefifo501 = &sbefifo501;
+		sbefifo510 = &sbefifo510;
+		sbefifo511 = &sbefifo511;
+		sbefifo512 = &sbefifo512;
+		sbefifo513 = &sbefifo513;
+		sbefifo514 = &sbefifo514;
+		sbefifo515 = &sbefifo515;
+		sbefifo602 = &sbefifo602;
+		sbefifo603 = &sbefifo603;
+		sbefifo610 = &sbefifo610;
+		sbefifo611 = &sbefifo611;
+		sbefifo614 = &sbefifo614;
+		sbefifo615 = &sbefifo615;
+		sbefifo616 = &sbefifo616;
+		sbefifo617 = &sbefifo617;
+		sbefifo700 = &sbefifo700;
+		sbefifo701 = &sbefifo701;
+		sbefifo710 = &sbefifo710;
+		sbefifo711 = &sbefifo711;
+		sbefifo712 = &sbefifo712;
+		sbefifo713 = &sbefifo713;
+		sbefifo714 = &sbefifo714;
+		sbefifo715 = &sbefifo715;
+		sbefifo802 = &sbefifo802;
+		sbefifo803 = &sbefifo803;
+		sbefifo810 = &sbefifo810;
+		sbefifo811 = &sbefifo811;
+		sbefifo814 = &sbefifo814;
+		sbefifo815 = &sbefifo815;
+		sbefifo816 = &sbefifo816;
+		sbefifo817 = &sbefifo817;
+
+		scom500 = &scom500;
+		scom501 = &scom501;
+		scom510 = &scom510;
+		scom511 = &scom511;
+		scom512 = &scom512;
+		scom513 = &scom513;
+		scom514 = &scom514;
+		scom515 = &scom515;
+		scom602 = &scom602;
+		scom603 = &scom603;
+		scom610 = &scom610;
+		scom611 = &scom611;
+		scom614 = &scom614;
+		scom615 = &scom615;
+		scom616 = &scom616;
+		scom617 = &scom617;
+		scom700 = &scom700;
+		scom701 = &scom701;
+		scom710 = &scom710;
+		scom711 = &scom711;
+		scom712 = &scom712;
+		scom713 = &scom713;
+		scom714 = &scom714;
+		scom715 = &scom715;
+		scom802 = &scom802;
+		scom803 = &scom803;
+		scom810 = &scom810;
+		scom811 = &scom811;
+		scom814 = &scom814;
+		scom815 = &scom815;
+		scom816 = &scom816;
+		scom817 = &scom817;
+
+		spi50 = &cfam4_spi0;
+		spi51 = &cfam4_spi1;
+		spi52 = &cfam4_spi2;
+		spi53 = &cfam4_spi3;
+		spi60 = &cfam5_spi0;
+		spi61 = &cfam5_spi1;
+		spi62 = &cfam5_spi2;
+		spi63 = &cfam5_spi3;
+		spi70 = &cfam6_spi0;
+		spi71 = &cfam6_spi1;
+		spi72 = &cfam6_spi2;
+		spi73 = &cfam6_spi3;
+		spi80 = &cfam7_spi0;
+		spi81 = &cfam7_spi1;
+		spi82 = &cfam7_spi2;
+		spi83 = &cfam7_spi3;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200n8";
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
+		event_log: tcg_event_log at b3d00000 {
+			no-map;
+			reg = <0xb3d00000 0x100000>;
+		};
+
+		ramoops at b3e00000 {
+			compatible = "ramoops";
+			reg = <0xb3e00000 0x200000>; /* 16 * (4 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
+		/* LPC FW cycle bridge region requires natural alignment */
+		flash_memory: region at b4000000 {
+			no-map;
+			reg = <0xb4000000 0x04000000>; /* 64M */
+		};
+
+		/* VGA region is dictated by hardware strapping */
+		vga_memory: region at bf000000 {
+			no-map;
+			compatible = "shared-dma-pool";
+			reg = <0xbf000000 0x01000000>; /* 16M */
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <1000>;
+
+		event-fan0-presence {
+			label = "fan0-presence";
+			gpios = <&pca0 15 GPIO_ACTIVE_LOW>;
+			linux,code = <15>;
+		};
+
+		event-fan1-presence {
+			label = "fan1-presence";
+			gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
+			linux,code = <14>;
+		};
+
+		event-fan2-presence {
+			label = "fan2-presence";
+			gpios = <&pca0 13 GPIO_ACTIVE_LOW>;
+			linux,code = <13>;
+		};
+
+		event-fan3-presence {
+			label = "fan3-presence";
+			gpios = <&pca0 12 GPIO_ACTIVE_LOW>;
+			linux,code = <12>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		/* RTC battery fault LED at the back */
+		led-rtc-battery {
+			gpios = <&gpio0 ASPEED_GPIO(H, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		/* BMC Card fault LED at the back */
+		led-bmc {
+			gpios = <&gpio0 ASPEED_GPIO(H, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		/* Enclosure Identify LED at the back */
+		led-rear-enc-id0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		/* Enclosure fault LED at the back */
+		led-rear-enc-fault0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+		};
+
+		/* PCIE slot power LED */
+		led-pcieslot-power {
+			gpios = <&gpio0 ASPEED_GPIO(P, 4) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	iio-hwmon {
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
+				 &pinctrl_adc10_default &pinctrl_adc11_default
+				 &pinctrl_adc12_default &pinctrl_adc13_default
+				 &pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"USERSPACE_RSTIND_BUFF","","","","","","checkstop","",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","rtc-battery-voltage-read-enable","reset-cause-pinhole","","","factory-reset-toggle","",
+	/*G0-G7*/	"","","","","","","","",
+	/*H0-H7*/	"led-rtc-battery","led-bmc","led-rear-enc-id0","led-rear-enc-fault0","","","","",
+	/*I0-I7*/	"","","","","","","bmc-secure-boot","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","usb-power","","","","",
+	/*P0-P7*/	"","","","","led-pcieslot-power","","","",
+	/*Q0-Q7*/	"","","regulator-standby-faulted","","","","","",
+	/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","","I2C_FLASH_MICRO_N","","",
+	/*S0-S7*/	"","","","","power-ffs-sync-history","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","BMC_3RESTART_ATTEMPT_P","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/   "","","","","","","","";
+
+	usb_power {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
+		output-high;
+	};
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
+	pca1: pca9552 at 62 {
+		compatible = "nxp,pca9552";
+		reg = <0x62>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"presence-ps0",
+			"presence-ps1",
+			"presence-ps2",
+			"presence-ps3",
+			"presence-pdb",
+			"presence-tpm",
+			"", "",
+			"presence-cp0",
+			"presence-cp1",
+			"presence-cp2",
+			"presence-cp3",
+			"presence-dasd",
+			"presence-lcd-op",
+			"presence-base-op",
+			"";
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+
+	eeprom at 54 {
+		compatible = "atmel,24c128";
+		reg = <0x54>;
+	};
+
+	power-supply at 68 {
+		compatible = "ibm,cffps";
+		reg = <0x68>;
+	};
+
+	power-supply at 69 {
+		compatible = "ibm,cffps";
+		reg = <0x69>;
+	};
+
+	power-supply at 6b {
+		compatible = "ibm,cffps";
+		reg = <0x6b>;
+	};
+
+	power-supply at 6d {
+		compatible = "ibm,cffps";
+		reg = <0x6d>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	pca2: pca9552 at 65 {
+		compatible = "nxp,pca9552";
+		reg = <0x65>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"presence-cable-card1",
+			"presence-cable-card2",
+			"presence-cable-card3",
+			"presence-cable-card4",
+			"presence-cable-card5",
+			"expander-cable-card1",
+			"expander-cable-card2",
+			"expander-cable-card3",
+			"expander-cable-card4",
+			"expander-cable-card5";
+	};
+
+	i2c-mux at 70 {
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
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+
+			pca_cable_card_c01: pca9551 at 62 {
+				compatible = "nxp,pca9551";
+				reg = <0x62>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c01-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c01-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c4mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+
+			pca_cable_card_c02: pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c02-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c02-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c4mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+
+			pca_cable_card_c03: pca9551 at 61 {
+				compatible = "nxp,pca9551";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c03-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c03-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	pca3: pca9552 at 66 {
+		compatible = "nxp,pca9552";
+		reg = <0x66>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"presence-cable-card6",
+			"presence-cable-card7",
+			"presence-cable-card8",
+			"presence-cable-card9",
+			"presence-cable-card10",
+			"presence-cable-card11",
+			"expander-cable-card6",
+			"expander-cable-card7",
+			"expander-cable-card8",
+			"expander-cable-card9",
+			"expander-cable-card10",
+			"expander-cable-card11";
+	};
+
+	i2c-mux at 70 {
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
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+
+			pca_cable_card_c04: pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c04-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c04-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c5mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+
+			pca_cable_card_c05: pca9551 at 61 {
+				compatible = "nxp,pca9551";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c05-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c05-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c5mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+
+			pca_cable_card_c06: pca9551 at 62 {
+				compatible = "nxp,pca9551";
+				reg = <0x62>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c06-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c06-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c5mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+
+			pca_cable_card_c07: pca9551 at 63 {
+				compatible = "nxp,pca9551";
+				reg = <0x63>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c07-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c07-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	i2c-mux at 70 {
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
+			eeprom at 50 {
+			compatible = "atmel,24c64";
+			reg = <0x50>;
+			};
+
+			pca_cable_card_c08: pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c08-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c08-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c6mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+
+			pca_cable_card_c09: pca9551 at 62 {
+				compatible = "nxp,pca9551";
+				reg = <0x62>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c09-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c09-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c6mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+
+			pca_cable_card_c10: pca9551 at 63 {
+				compatible = "nxp,pca9551";
+				reg = <0x63>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c10-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c10-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c6mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+
+			pca_cable_card_c11: pca9551 at 61 {
+				compatible = "nxp,pca9551";
+				reg = <0x61>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "cablecard-c11-cxp-top";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "cablecard-c11-cxp-bot";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+	};
+
+	pca_pcie_slot: pca9552 at 65 {
+		compatible = "nxp,pca9552";
+		reg = <0x65>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 1 {
+			label = "pcieslot-c01";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "pcieslot-c02";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "pcieslot-c03";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "pcieslot-c04";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "pcieslot-c05";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "pcieslot-c06";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "pcieslot-c07";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "pcieslot-c08";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "pcieslot-c09";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "pcieslot-c10";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "pcieslot-c11";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	pic0_dimm: pca9552 at 31 {
+		compatible = "ibm,pca9552";
+		reg = <0x31>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "ddimm0";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "ddimm1";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "ddimm2";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "ddimm3";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "ddimm4";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "ddimm5";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "ddimm6";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "ddimm7";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "ddimm8";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "ddimm9";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "ddimm10";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "ddimm11";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "ddimm12";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "ddimm13";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "ddimm14";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "ddimm15";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pic1_dimm: pca9552 at 32 {
+		compatible = "ibm,pca9552";
+		reg = <0x32>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "ddimm16";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "ddimm17";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "ddimm18";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "ddimm19";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "ddimm20";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "ddimm21";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "ddimm22";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "ddimm23";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "ddimm24";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "ddimm25";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "ddimm26";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "ddimm27";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "ddimm28";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "ddimm29";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "ddimm30";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "ddimm31";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pic2_dimm: pca9552 at 33 {
+		compatible = "ibm,pca9552";
+		reg = <0x33>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "ddimm32";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "ddimm33";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "ddimm34";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "ddimm35";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "ddimm36";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "ddimm37";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "ddimm38";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "ddimm39";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "ddimm40";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "ddimm41";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "ddimm42";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "ddimm43";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "ddimm44";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "ddimm45";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "ddimm46";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "ddimm47";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pic3_dimm: pca9552 at 30 {
+		compatible = "ibm,pca9552";
+		reg = <0x30>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "ddimm48";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "ddimm49";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "ddimm50";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "ddimm51";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "ddimm52";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "ddimm53";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "ddimm54";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 7 {
+			label = "ddimm55";
+			reg = <7>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "ddimm56";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "ddimm57";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "ddimm58";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "ddimm59";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "ddimm60";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "ddimm61";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "ddimm62";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "ddimm63";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pic0_vrm_misc: pca9552 at 34 {
+		compatible = "ibm,pca9552";
+		reg = <0x34>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "planar";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "tpm";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "cpu3-c61";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "cpu0-c14";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "opencapi-connector3";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "opencapi-connector4";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "opencapi-connector5";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "vrm4";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "vrm5";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "vrm6";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "vrm7";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "vrm12";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "vrm13";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "vrm14";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "vrm15";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	pic1_vrm_misc: pca9552 at 35 {
+		compatible = "ibm,pca9552";
+		reg = <0x35>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led at 0 {
+			label = "dasd-backplane";
+			reg = <0>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 1 {
+			label = "power-distribution";
+			reg = <1>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 2 {
+			label = "cpu1-c19";
+			reg = <2>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 3 {
+			label = "cpu2-c56";
+			reg = <3>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 4 {
+			label = "opencapi-connector0";
+			reg = <4>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 5 {
+			label = "opencapi-connector1";
+			reg = <5>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 6 {
+			label = "opencapi-connector2";
+			reg = <6>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 8 {
+			label = "vrm0";
+			reg = <8>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 9 {
+			label = "vrm1";
+			reg = <9>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 10 {
+			label = "vrm2";
+			reg = <10>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 11 {
+			label = "vrm3";
+			reg = <11>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 12 {
+			label = "vrm8";
+			reg = <12>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 13 {
+			label = "vrm9";
+			reg = <13>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 14 {
+			label = "vrm10";
+			reg = <14>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led at 15 {
+			label = "vrm11";
+			reg = <15>;
+			retain-state-shutdown;
+			default-state = "keep";
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	ucd90320 at 11 {
+		compatible = "ti,ucd90320";
+		reg = <0x11>;
+	};
+
+	rtc at 32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+
+	eeprom at 51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	i2c-mux at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c8mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c8mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+	};
+};
+
+&i2c9 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	eeprom at 53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	tpm at 2e {
+		compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+		memory-region = <&event_log>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+	};
+};
+
+&i2c14 {
+	multi-master;
+	status = "okay";
+
+	ibm-panel at 62 {
+		compatible = "ibm,op-panel";
+		reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		idle-state = <1>;
+
+		i2c14mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c14mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 51 {
+				compatible = "atmel,24c32";
+				reg = <0x51>;
+			};
+		};
+
+		i2c14mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+
+			pca_oppanel: pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "front-sys-id0";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "front-check-log0";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 2 {
+					label = "front-enc-fault1";
+					reg = <2>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 3 {
+					label = "front-sys-pwron0";
+					reg = <3>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+		};
+
+		i2c14mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			max31785 at 52 {
+				compatible = "maxim,max31785a";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x52>;
+
+				fan at 0 {
+					compatible = "pmbus-fan";
+					reg = <0>;
+					tach-pulses = <2>;
+				};
+
+				fan at 1 {
+					compatible = "pmbus-fan";
+					reg = <1>;
+					tach-pulses = <2>;
+				};
+
+				fan at 2 {
+					compatible = "pmbus-fan";
+					reg = <2>;
+					tach-pulses = <2>;
+				};
+
+				fan at 3 {
+					compatible = "pmbus-fan";
+					reg = <3>;
+					tach-pulses = <2>;
+				};
+			};
+
+			pca_fan_nvme: pca9552 at 60 {
+				compatible = "nxp,pca9552";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "nvme0";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "nvme1";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 2 {
+					label = "nvme2";
+					reg = <2>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 3 {
+					label = "nvme3";
+					reg = <3>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 4 {
+					label = "nvme4";
+					reg = <4>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 5 {
+					label = "nvme5";
+					reg = <5>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 6 {
+					label = "nvme6";
+					reg = <6>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 7 {
+					label = "nvme7";
+					reg = <7>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 8 {
+					label = "nvme8";
+					reg = <8>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 9 {
+					label = "nvme9";
+					reg = <9>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 10 {
+					label = "fan0";
+					reg = <10>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 11 {
+					label = "fan1";
+					reg = <11>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 12 {
+					label = "fan2";
+					reg = <12>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 13 {
+					label = "fan3";
+					reg = <13>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
+
+			pca0: pca9552 at 61 {
+				compatible = "nxp,pca9552";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x61>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				gpio-line-names =
+					"","","","",
+					"","","","",
+					"","","","",
+					"presence-fan3",
+					"presence-fan2",
+					"presence-fan1",
+					"presence-fan0";
+			};
+		};
+	};
+
+	i2c-mux at 71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c14mux1chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c14mux1chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c14mux1chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c14mux1chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+&i2c15 {
+	status = "okay";
+
+	i2c-mux at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c15mux0chn0: i2c at 0 {
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
+		i2c15mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+
+		i2c15mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+
+		i2c15mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+	};
+
+	i2c-mux at 71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c15mux1chn0: i2c at 0 {
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
+		i2c15mux1chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+
+		i2c15mux1chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+
+		i2c15mux1chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+	};
+
+	i2c-mux at 72 {
+		compatible = "nxp,pca9546";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c15mux2chn0: i2c at 0 {
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
+		i2c15mux2chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+
+		i2c15mux2chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c15mux2chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+	};
+};
+
+&ehci0 {
+	status = "okay";
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
+	clk-phase-mmc-hs200 = <210>, <228>;
+};
+
+&ibt {
+	status = "okay";
+};
+
+&uart2 {
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
+
+#include "ibm-power11-quad.dtsi"
+
+&fsi_hub0 {
+	cfam at 4,0 { /* DCM2_C0 */
+		reg = <4 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <4>;
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
+			cfam4_i2c0: i2c-bus at 0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;	/* OM01 */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom500: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo500: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam4_i2c1: i2c-bus at 1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;	/* OM23 */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom501: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo501: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam4_i2c10: i2c-bus at a {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10>;	/* OP3A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom510: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo510: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam4_i2c11: i2c-bus at b {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <11>;	/* OP3B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom511: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo511: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam4_i2c12: i2c-bus at c {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <12>;	/* OP4A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom512: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo512: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam4_i2c13: i2c-bus at d {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <13>;	/* OP4B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom513: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo513: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam4_i2c14: i2c-bus at e {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <14>;	/* OP5A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom514: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo514: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam4_i2c15: i2c-bus at f {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <15>;	/* OP5B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom515: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo515: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam4_spi0: spi at 0 {
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
+			cfam4_spi1: spi at 20 {
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
+			cfam4_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible = "ibm,fsi2spi";
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
+			cfam4_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible = "ibm,fsi2spi";
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
+			fsi_occ4: occ {
+				compatible = "ibm,p10-occ";
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub4: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+
+	cfam at 5,0 { /* DCM2_C1 */
+		reg = <5 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <5>;
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
+			cfam5_i2c2: i2c-bus at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;	/* OM45 */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom602: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo602: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam5_i2c3: i2c-bus at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;	/* OM67 */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom603: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo603: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam5_i2c10: i2c-bus at a {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10>;	/* OP3A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom610: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo610: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam5_i2c11: i2c-bus at b {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <11>;	/* OP3B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom611: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo611: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam5_i2c14: i2c-bus at e {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <14>;	/* OP5A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom614: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo614: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam5_i2c15: i2c-bus at f {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <15>;	/* OP5B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom615: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo615: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam5_i2c16: i2c-bus at 10 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <16>;	/* OP6A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom616: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo616: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam5_i2c17: i2c-bus at 11 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <17>;	/* OP6B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom617: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo617: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam5_spi0: spi at 0 {
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
+			cfam5_spi1: spi at 20 {
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
+			cfam5_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible = "ibm,fsi2spi";
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
+			cfam5_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible = "ibm,fsi2spi";
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
+			fsi_occ5: occ {
+				compatible = "ibm,p10-occ";
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub5: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+
+	cfam at 6,0 { /* DCM3_C0 */
+		reg = <6 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <6>;
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
+			cfam6_i2c0: i2c-bus at 0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;	/* OM01 */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom700: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo700: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam6_i2c1: i2c-bus at 1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;	/* OM23 */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom701: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo701: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam6_i2c10: i2c-bus at a {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10>;	/* OP3A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom710: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo710: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam6_i2c11: i2c-bus at b {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <11>;	/* OP3B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom711: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo711: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam6_i2c12: i2c-bus at c {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <12>;	/* OP4A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom712: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo712: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam6_i2c13: i2c-bus at d {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <13>;	/* OP4B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom713: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo713: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam6_i2c14: i2c-bus at e {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <14>;	/* OP5A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom714: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo714: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam6_i2c15: i2c-bus at f {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <15>;	/* OP5B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom715: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo715: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam6_spi0: spi at 0 {
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
+			cfam6_spi1: spi at 20 {
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
+			cfam6_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible = "ibm,fsi2spi";
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
+			cfam6_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible = "ibm,fsi2spi";
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
+			fsi_occ6: occ {
+				compatible = "ibm,p10-occ";
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub6: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+
+	cfam at 7,0 { /* DCM3_C1 */
+		reg = <7 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <7>;
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
+			cfam7_i2c2: i2c-bus at 2 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;	/* OM45 */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom802: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo802: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam7_i2c3: i2c-bus at 3 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;	/* OM67 */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom803: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo803: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam7_i2c10: i2c-bus at a {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10>;	/* OP3A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom810: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo810: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam7_i2c11: i2c-bus at b {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <11>;	/* OP3B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom811: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo811: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam7_i2c14: i2c-bus at e {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <14>;	/* OP5A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom814: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo814: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam7_i2c15: i2c-bus at f {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <15>;	/* OP5B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom815: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo815: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam7_i2c16: i2c-bus at 10 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <16>;	/* OP6A */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom816: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo816: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+
+			cfam7_i2c17: i2c-bus at 11 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <17>;	/* OP6B */
+
+				i2cr at 20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam at 0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom817: scom at 1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo817: sbefifo at 2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+							#address-cells = <1>;
+							#size-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam7_spi0: spi at 0 {
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
+			cfam7_spi1: spi at 20 {
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
+			cfam7_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible = "ibm,fsi2spi";
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
+			cfam7_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible = "ibm,fsi2spi";
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
+			fsi_occ7: occ {
+				compatible = "ibm,p10-occ";
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub7: hub at 3400 {
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
+&fsi_occ4 {
+	reg = <5>;
+};
+
+&fsi_occ5 {
+	reg = <6>;
+};
+
+&fsi_occ6 {
+	reg = <7>;
+};
+
+&fsi_occ7 {
+	reg = <8>;
+};
diff --git a/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
new file mode 100644
index 000000000000..b6cd6e84fa1b
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
@@ -0,0 +1,1704 @@
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
+			compatible = "ibm,fsi-i2c-master";
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
+				compatible =  "ibm,fsi2spi";
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
+				compatible =  "ibm,fsi2spi";
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
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
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
+				compatible =  "ibm,fsi2spi";
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
+				compatible =  "ibm,fsi2spi";
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
+
+				occ-hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
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
+			compatible = "ibm,fsi-i2c-master";
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
+			cfam2_spi1: spi at 20 {
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
+			cfam2_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible =  "ibm,fsi2spi";
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
+			cfam2_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible =  "ibm,fsi2spi";
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
+			compatible = "fsi-master-hub";
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
+			compatible = "ibm,fsi-i2c-master";
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
+			cfam3_spi1: spi at 20 {
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
+			cfam3_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible =  "ibm,fsi2spi";
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
+			cfam3_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible =  "ibm,fsi2spi";
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
+&cfam0_i2c0 {
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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
+	i2cr at 20 {
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

