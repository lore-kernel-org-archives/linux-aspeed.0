From: Andrew Peng <pengms1@lenovo.com>
Date: Thu, 26 Dec 2019 16:57:46 +0800
Subject: [PATCH linux dev-5.4 v1 1/1] ARM: dts: aspeed: update Hr855xg2 device
 tree
Message-ID: <1577350666-128981-1-git-send-email-pengms1@lenovo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update i2c aliases.
Change flash_memory mapping address and size.
Add in a gpio-keys section.
Enable vhub, vuart, spi1 and spi2.
Add raa228006, ir38164 and sn1701022 hwmon sensors.
Remove some unuse gpio from gpio section.

Signed-off-by: Andrew Peng <pengms1@lenovo.com>
Signed-off-by: Derek Lin <dlin23@lenovo.com>
Signed-off-by: Yonghui Liu <liuyh21@lenovo.com>
---
v1: initial version

 arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts | 555 ++++++++++++++++-------
 1 file changed, 381 insertions(+), 174 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
index 084c455..e1386d4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-lenovo-hr855xg2.dts
@@ -15,14 +15,21 @@
 	compatible = "lenovo,hr855xg2-bmc", "aspeed,ast2500";
 
 	aliases {
-		i2c14 = &i2c_riser1;
-		i2c15 = &i2c_riser2;
-		i2c16 = &i2c_riser3;
-		i2c17 = &i2c_M2;
-		i2c18 = &channel_0;
-		i2c19 = &channel_1;
-		i2c20 = &channel_2;
-		i2c21 = &channel_3;
+		i2c14 = &pcie_slot8;
+		i2c15 = &pcie_slot9;
+		i2c16 = &pcie_slot10;
+		i2c17 = &pcie_slot11;
+		i2c18 = &pcie_slot12;
+		i2c19 = &switch0_i2c5;
+		i2c22 = &switch1_i2c0;
+		i2c23 = &pcie_slot6;
+		i2c24 = &pcie_slot7;
+		i2c30 = &pcie_slot1;
+		i2c31 = &pcie_slot2;
+		i2c32 = &pcie_slot3;
+		i2c33 = &pcie_slot4;
+		i2c34 = &pcie_slot5;
+		i2c35 = &switch2_i2c5;
 	};
 
 	chosen {
@@ -40,9 +47,9 @@
 		#size-cells = <1>;
 		ranges;
 
-		flash_memory: region at 98000000 {
+		flash_memory: region at 9EFF0000 {
 			no-map;
-			reg = <0x98000000 0x00100000>; /* 1M */
+			reg = <0x9EFF0000 0x00010000>; /* 64K */
 		};
 
 		gfx_memory: framebuffer {
@@ -78,6 +85,87 @@
 		io-channels = <&adc 15>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		id-button {
+			label = "id-button";
+			gpios = <&gpio ASPEED_GPIO(Y, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(Y, 2)>;
+		};
+
+		pwr-button {
+			label = "pwr-button";
+			gpios = <&gpio ASPEED_GPIO(I, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(I, 1)>;
+		};
+
+		cpu-caterr {
+			label = "cpu-caterr";
+			gpios = <&gpio ASPEED_GPIO(G, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(G, 1)>;
+		};
+
+		int-fpga-bmc {
+			label = "int-fpga-bmc";
+			gpios = <&gpio ASPEED_GPIO(F, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(F, 5)>;
+		};
+
+		pdb-alt-n {
+			label = "pdb-alt-n";
+			gpios = <&gpio ASPEED_GPIO(AA, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(AA, 1)>;
+		};
+
+		p12v-aux1-alert1-n {
+			label = "p12v-aux1-alert1-n";
+			gpios = <&gpio ASPEED_GPIO(AA, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(AA, 7)>;
+		};
+
+		p12v-aux2-alert1-n {
+			label = "p12v-aux2-alert1-n";
+			gpios = <&gpio ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(J, 0)>;
+		};
+
+		p12v-aux3-alert1-n {
+			label = "p12v-aux3-alert1-n";
+			gpios = <&gpio ASPEED_GPIO(G, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(G, 5)>;
+		};
+
+		ddr-vr-bmc-alert-n {
+			label = "ddr-vr-bmc-alert-n";
+			gpios = <&gpio ASPEED_GPIO(L, 7) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(L, 7)>;
+		};
+
+		cpu-vr-bmc-alert-n {
+			label = "cpu-vr-bmc-alert-n";
+			gpios = <&gpio ASPEED_GPIO(L, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(L, 6)>;
+		};
+
+		riser1-vr-al-r {
+			label = "riser1-vr-al-r";
+			gpios = <&gpio ASPEED_GPIO(AB, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(AB, 1)>;
+		};
+
+		riser2-vr-al-r {
+			label = "riser2-vr-al-r";
+			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(F, 1)>;
+		};
+
+		riser3-vr-al-r {
+			label = "riser3-vr-al-r";
+			gpios = <&gpio ASPEED_GPIO(A, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <ASPEED_GPIO(A, 1)>;
+		};
+	};
 };
 
 &fmc {
@@ -91,10 +179,13 @@
 	};
 };
 
+&vhub {
+	status = "okay";
+};
+
 &lpc_ctrl {
 	status = "okay";
 	memory-region = <&flash_memory>;
-	flash = <&spi1>;
 };
 
 &lpc_snoop {
@@ -102,11 +193,39 @@
 	snoop-ports = <0x80>;
 };
 
-&uart1 {
+&spi1 {
+	status = "okay";
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <40000000>;
+	};
+};
+
+&spi2 {
 	status = "okay";
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd1_default
-			&pinctrl_rxd1_default>;
+	pinctrl-0 = <&pinctrl_spi2ck_default
+				&pinctrl_spi2cs0_default
+				&pinctrl_spi2miso_default
+				&pinctrl_spi2mosi_default>;
+
+		spidev at 0 {
+				status = "okay";
+				compatible = "aspeed,spidev";
+				reg = < 0 >;
+				spi-max-frequency = <50000000>;
+		};
+
+		flash at 0 {
+				compatible = "jedec,spi-nor";
+				m25p,fast-read;
+				label = "fpga";
+				reg = < 0 >;
+				spi-max-frequency = <50000000>;
+				status = "okay";
+		};
 };
 
 &uart2 {
@@ -123,12 +242,14 @@
 			&pinctrl_nri2_default>;
 };
 
-&uart3 {
+&uart5 {
 	status = "okay";
 };
 
-&uart5 {
+&vuart {
 	status = "okay";
+	auto-flow-control;
+	espi-enabled = <&syscon 0x70 25>;
 };
 
 &ibt {
@@ -172,37 +293,77 @@
 			&pinctrl_adc15_default>;
 };
 
+&peci0 {
+	status = "okay";
+	peci-client at 30 {
+		compatible = "intel,peci-client";
+		reg = <0x30>;
+	};
+
+	peci-client at 31 {
+		compatible = "intel,peci-client";
+		reg = <0x31>;
+	};
+
+	peci-client at 32 {
+		compatible = "intel,peci-client";
+		reg = <0x32>;
+	};
+
+	peci-client at 33 {
+		compatible = "intel,peci-client";
+		reg = <0x33>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
-	i2c-switch at 70 {
-		compatible = "nxp,pca9545";
-		reg = <0x70>;
+	i2c-switch at 71 {
+		compatible = "nxp,pca9548";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		reg = <0x71>;
 
-		i2c_riser1: i2c at 0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
+		pcie_slot8: i2c at 0{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
 		};
 
-		i2c_riser2: i2c at 1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
+		pcie_slot9: i2c at 1{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
 		};
 
-		i2c_riser3: i2c at 2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
+		pcie_slot10: i2c at 2{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;
 		};
 
-		i2c_M2: i2c at 3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
+		pcie_slot11: i2c at 3{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+		};
+
+		pcie_slot12: i2c at 4{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <4>;
+		};
+
+		switch0_i2c5:i2c at 5{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <5>;
+				eeprom at 54 {
+						compatible = "atmel,24c04";
+						pagesize = <16>;
+						reg = <0x54>;
+				};
 		};
 	};
 };
@@ -216,13 +377,43 @@
 	};
 
 	VR at 45 {
-		compatible = "pmbus";
+		compatible = "raa228006";
 		reg = <0x45>;
 	};
 };
 
 &i2c2 {
 	status = "okay";
+
+	i2c-switch at 71 {
+		compatible = "nxp,pca9545";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		switch1_i2c0:i2c at 0{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				eeprom at 54 {
+						compatible = "atmel,24c04";
+						pagesize = <16>;
+						reg = <0x54>;
+				};
+		};
+
+		pcie_slot6:i2c at 1{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+		};
+
+		pcie_slot7:i2c at 2{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;
+		};
+	};
 };
 
 &i2c3 {
@@ -265,6 +456,66 @@
 
 &i2c5 {
 	status = "okay";
+
+	CPU0_VCCIN at 60 {
+		compatible = "raa228006";
+		reg = <0x60>;
+	};
+
+	CPU1_VCCIN at 62 {
+		compatible = "raa228006";
+		reg = <0x62>;
+	};
+
+	CPU2_VCCIN at 64 {
+		compatible = "raa228006";
+		reg = <0x64>;
+	};
+
+	CPU3_VCCIN at 66 {
+		compatible = "raa228006";
+		reg = <0x66>;
+	};
+
+	CPU0_VCCSA at 46 {
+		compatible = "ir38164";
+		reg = <0x46>;
+	};
+
+	CPU1_VCCSA at 47 {
+		compatible = "ir38164";
+		reg = <0x47>;
+	};
+
+	CPU2_VCCSA at 48 {
+		compatible = "ir38164";
+		reg = <0x48>;
+	};
+
+	CPU3_VCCSA at 49 {
+		compatible = "ir38164";
+		reg = <0x49>;
+	};
+
+	CPU0_VCCIO at 41 {
+		compatible = "ir38164";
+		reg = <0x41>;
+	};
+
+	CPU1_VCCIO at 42 {
+		compatible = "ir38164";
+		reg = <0x42>;
+	};
+
+	CPU2_VCCIO at 43 {
+		compatible = "ir38164";
+		reg = <0x43>;
+	};
+
+	CPU3_VCCIO at 44 {
+		compatible = "ir38164";
+		reg = <0x44>;
+	};
 };
 
 &i2c6 {
@@ -284,7 +535,7 @@
 	eeprom at 54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
-		pagesize = <16>;
+		pagesize = <64>;
 	};
 };
 
@@ -306,10 +557,99 @@
 
 &i2c11 {
 	status = "okay";
+
+	i2c-switch at 71 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x71>;
+
+		pcie_slot1: i2c at 0{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+		};
+
+		pcie_slot2: i2c at 1{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+		};
+
+		pcie_slot3: i2c at 2{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <2>;
+		};
+
+		pcie_slot4: i2c at 3{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <3>;
+		};
+
+		pcie_slot5: i2c at 4{
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <4>;
+		};
+
+		switch2_i2c5:i2c at 5{
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+			eeprom at 54 {
+				compatible = "atmel,24c04";
+				pagesize = <16>;
+				reg = <0x54>;
+			};
+		};
+	};
 };
 
 &i2c13 {
 	status = "okay";
+
+	CPU0_VDDQ_ABC at 58 {
+		compatible = "sn1701022";
+		reg = <0x58>;
+	};
+
+	CPU0_VDDQ_DEF at 5a {
+		compatible = "sn1701022";
+		reg = <0x5a>;
+	};
+
+	CPU1_VDDQ_ABC at 5c {
+		compatible = "sn1701022";
+		reg = <0x5c>;
+	};
+
+	CPU1_VDDQ_DEF at 5e {
+		compatible = "sn1701022";
+		reg = <0x5e>;
+	};
+
+	CPU2_VDDQ_ABC at 68 {
+		compatible = "sn1701022";
+		reg = <0x68>;
+	};
+
+	CPU2_VDDQ_DEF at 6a {
+		compatible = "sn1701022";
+		reg = <0x6a>;
+	};
+
+	CPU3_VDDQ_ABC at 6c {
+		compatible = "sn1701022";
+		reg = <0x6c>;
+	};
+
+	CPU3_VDDQ_DEF at 6e {
+		compatible = "sn1701022";
+		reg = <0x6e>;
+	};
+
 };
 
 &ehci1 {
@@ -425,20 +765,6 @@
 
 &gpio {
 
-	pin_gpio_a1 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(A, 1) GPIO_ACTIVE_LOW>;
-		output-high;
-		line-name = "BMC_EMMC_RST_N";
-	};
-
-	pin_gpio_a3 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
-		output-high;
-		line-name = "PCH_PWROK_BMC_FPGA";
-	};
-
 	pin_gpio_b5 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
@@ -453,27 +779,6 @@
 		line-name = "CPU_SM_WP";
 	};
 
-	pin_gpio_e0 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(E, 0) GPIO_ACTIVE_HIGH>;
-		input;
-		line-name = "PDB_PSU_SEL";
-	};
-
-	pin_gpio_e2 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(E, 2) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "LOCATOR_LED_N";
-	};
-
-	pin_gpio_e5 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(E, 5) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "FM_BMC_DBP_PRESENT_R1_N";
-	};
-
 	pin_gpio_e6 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(E, 6) GPIO_ACTIVE_HIGH>;
@@ -481,18 +786,11 @@
 		line-name = "BMC_ME_SECURITY_OVERRIDE_N";
 	};
 
-	pin_gpio_f0 {
+	pin_gpio_g7 {
 		gpio-hog;
-		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_HIGH>;
+		gpios = <ASPEED_GPIO(G, 7) GPIO_ACTIVE_HIGH>;
 		output-high;
-		line-name = "IRQ_BMC_PCH_NMI_R";
-	};
-
-	pin_gpio_f1 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_HIGH>;
-		input;
-		line-name = "CPU2_PROCDIS_BMC_N";
+		line-name = "BMC_PCIE_I2C_MUX_RST_N";
 	};
 
 	pin_gpio_f2 {
@@ -516,34 +814,6 @@
 		line-name = "BMC_FORCE_NM_THROTTLE_N";
 	};
 
-	pin_gpio_f6 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(F, 6) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "FM_BMC_CPU_PWR_DEBUG_N";
-	};
-
-	pin_gpio_g7 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(G, 7) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "BMC_PCIE_I2C_MUX_RST_N";
-	};
-
-	pin_gpio_h6 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "FM_BMC_DBP_PRESENT_R2_N";
-	};
-
-	pin_gpio_i3 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "SPI_BMC_BIOS_WP_N";
-	};
-
 	pin_gpio_j1 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
@@ -565,20 +835,6 @@
 		line-name = "SPI_BMC_BIOS_HOLD_N";
 	};
 
-	pin_gpio_l0 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(L, 0) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "PDB_FAN_TACH_SEL";
-	};
-
-	pin_gpio_l1 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(L, 1) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "SYS_RESET_BMC_FPGA_N";
-	};
-
 	pin_gpio_l4 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
@@ -593,27 +849,6 @@
 		line-name = "FM_EFUSE_FAN_G2_EN";
 	};
 
-	pin_gpio_r6 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(R, 6) GPIO_ACTIVE_HIGH>;
-		input;
-		line-name = "CPU3_PROCDIS_BMC_N";
-	};
-
-	pin_gpio_r7 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
-		input;
-		line-name = "CPU4_PROCDIS_BMC_N";
-	};
-
-	pin_gpio_s1 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "DBP_SYSPWROK_BMC";
-	};
-
 	pin_gpio_s2 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
@@ -621,13 +856,6 @@
 		line-name = "PCH_RST_RSMRST_N";
 	};
 
-	pin_gpio_s6 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "BMC_HW_STRAP_5";
-	};
-
 	pin_gpio_z3 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
@@ -638,29 +866,8 @@
 	pin_gpio_aa0 {
 		gpio-hog;
 		gpios = <ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "FW_PSU_ALERT_EN_N";
-	};
-
-	pin_gpio_aa4 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(AA, 4) GPIO_ACTIVE_HIGH>;
 		output-high;
-		line-name = "DBP_CPU_PREQ_N";
-	};
-
-	pin_gpio_ab3 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(AB, 3) GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "BMC_WDTRST";
-	};
-
-	pin_gpio_ac6 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(AC, 6) GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "ESPI_BMC_ALERT_N";
+		line-name = "FW_PSU_ALERT_EN_N";
 	};
 
 };
-- 
2.7.4

