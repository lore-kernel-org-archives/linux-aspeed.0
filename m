From: Joel Stanley <joel@jms.id.au>
Date: Fri, 15 Dec 2017 16:54:39 +1030
Subject: [PATCH v2 15/19] ARM: dts: aspeed: Add Witherspoon BMC machine
In-Reply-To: <20171215062443.23059-1-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
Message-ID: <20171215062443.23059-16-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The Witherspoon BMC is an ASPEED ast2500 based BMC that is part of an
OpenPower Power9 server.

This adds the device tree description for most upstream components. It
is a squashed commit from the OpenBMC kernel tree.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
Signed-off-by: Matt Spinler <spinler@us.ibm.com>
Signed-off-by: Brad Bishop <bradleyb@fuzziesquirrel.com>
Signed-off-by: Edward A. James <eajames@us.ibm.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Brandon Wyman <bjwyman@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
--
 v2:
  Add Brandon's reviewed-by tag
---
 arch/arm/boot/dts/Makefile                       |   4 +-
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts | 547 +++++++++++++++++++=
++++
 2 files changed, 550 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5d1e9d37bf3a..15a9207319c1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1104,5 +1104,7 @@ dtb-$(CONFIG_ARCH_ZX) +=3D zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) +=3D \
 	aspeed-ast2500-evb.dtb \
 	aspeed-bmc-opp-palmetto.dtb \
-	aspeed-bmc-opp-romulus.dtb
+	aspeed-bmc-opp-romulus.dtb \
+	aspeed-bmc-opp-witherspoon.dtb
+
 endif
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/bo=
ot/dts/aspeed-bmc-opp-witherspoon.dts
new file mode 100644
index 000000000000..9a0937512e5b
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/leds/leds-pca955x.h>
+
+/ {
+	model =3D "Witherspoon BMC";
+	compatible =3D "ibm,witherspoon-bmc", "aspeed,ast2500";
+
+	chosen {
+		stdout-path =3D &uart5;
+		bootargs =3D "console=3DttyS4,115200 earlyprintk";
+	};
+
+	memory {
+		reg =3D <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges;
+
+		flash_memory: region at 98000000 {
+			no-map;
+			reg =3D <0x98000000 0x04000000>; /* 64M */
+		};
+	};
+
+	gpio-keys-polled {
+		compatible =3D "gpio-keys-polled";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		poll-interval =3D <1000>;
+
+		fan0-presence {
+			label =3D "fan0-presence";
+			gpios =3D <&pca0 4 GPIO_ACTIVE_LOW>;
+			linux,code =3D <4>;
+		};
+
+		fan1-presence {
+			label =3D "fan1-presence";
+			gpios =3D <&pca0 5 GPIO_ACTIVE_LOW>;
+			linux,code =3D <5>;
+		};
+
+		fan2-presence {
+			label =3D "fan2-presence";
+			gpios =3D <&pca0 6 GPIO_ACTIVE_LOW>;
+			linux,code =3D <6>;
+		};
+
+		fan3-presence {
+			label =3D "fan3-presence";
+			gpios =3D <&pca0 7 GPIO_ACTIVE_LOW>;
+			linux,code =3D <7>;
+		};
+	};
+
+	leds {
+		compatible =3D "gpio-leds";
+
+		fan0 {
+			retain-state-shutdown;
+			default-state =3D "keep";
+			gpios =3D <&pca0 0 GPIO_ACTIVE_LOW>;
+		};
+
+		fan1 {
+			retain-state-shutdown;
+			default-state =3D "keep";
+			gpios =3D <&pca0 1 GPIO_ACTIVE_LOW>;
+		};
+
+		fan2 {
+			retain-state-shutdown;
+			default-state =3D "keep";
+			gpios =3D <&pca0 2 GPIO_ACTIVE_LOW>;
+		};
+
+		fan3 {
+			retain-state-shutdown;
+			default-state =3D "keep";
+			gpios =3D <&pca0 3 GPIO_ACTIVE_LOW>;
+		};
+
+		front-fault {
+			retain-state-shutdown;
+			default-state =3D "keep";
+			gpios =3D <&pca0 13 GPIO_ACTIVE_LOW>;
+		};
+
+		front-power {
+			retain-state-shutdown;
+			default-state =3D "keep";
+			gpios =3D <&pca0 14 GPIO_ACTIVE_LOW>;
+		};
+
+		front-id {
+			retain-state-shutdown;
+			default-state =3D "keep";
+			gpios =3D <&pca0 15 GPIO_ACTIVE_LOW>;
+		};
+
+		rear-fault {
+			gpios =3D <&gpio ASPEED_GPIO(N, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		rear-id {
+			gpios =3D <&gpio ASPEED_GPIO(N, 4) GPIO_ACTIVE_LOW>;
+		};
+
+		rear-power {
+			gpios =3D <&gpio ASPEED_GPIO(N, 3) GPIO_ACTIVE_LOW>;
+		};
+
+		power-button {
+			gpios =3D <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	fsi: gpio-fsi {
+		compatible =3D "fsi-master-gpio", "fsi-master";
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		clock-gpios =3D <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
+		data-gpios =3D <&gpio ASPEED_GPIO(E, 0) GPIO_ACTIVE_HIGH>;
+		mux-gpios =3D <&gpio ASPEED_GPIO(A, 6) GPIO_ACTIVE_HIGH>;
+		enable-gpios =3D <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
+		trans-gpios =3D <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
+	};
+
+	iio-hwmon-dps310 {
+		compatible =3D "iio-hwmon";
+		io-channels =3D <&dps 0>;
+	};
+
+	iio-hwmon-bmp280 {
+		compatible =3D "iio-hwmon";
+		io-channels =3D <&bmp 1>;
+	};
+
+};
+
+&fmc {
+	status =3D "okay";
+
+	flash at 0 {
+		status =3D "okay";
+		label =3D "bmc";
+		m25p,fast-read;
+#include "openbmc-flash-layout.dtsi"
+	};
+
+	flash at 1 {
+		status =3D "okay";
+		label =3D "alt";
+		m25p,fast-read;
+	};
+};
+
+&spi1 {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_spi1_default>;
+
+	flash at 0 {
+		status =3D "okay";
+		label =3D "pnor";
+		m25p,fast-read;
+	};
+};
+
+&uart1 {
+	/* Rear RS-232 connector */
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_txd1_default
+			&pinctrl_rxd1_default
+			&pinctrl_nrts1_default
+			&pinctrl_ndtr1_default
+			&pinctrl_ndsr1_default
+			&pinctrl_ncts1_default
+			&pinctrl_ndcd1_default
+			&pinctrl_nri1_default>;
+};
+
+&uart2 {
+	/* APSS */
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_txd2_default &pinctrl_rxd2_default>;
+};
+
+&uart5 {
+	status =3D "okay";
+};
+
+&lpc_ctrl {
+	status =3D "okay";
+	memory-region =3D <&flash_memory>;
+	flash =3D <&spi1>;
+};
+
+&mac0 {
+	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_rmii1_default>;
+	use-ncsi;
+};
+
+&i2c2 {
+	status =3D "okay";
+
+	/* MUX ->
+	 *    Samtec 1
+	 *    Samtec 2
+	 */
+};
+
+&i2c3 {
+	status =3D "okay";
+
+	bmp: bmp280 at 77 {
+		compatible =3D "bosch,bmp280";
+		reg =3D <0x77>;
+		#io-channel-cells =3D <1>;
+	};
+
+	max31785 at 52 {
+		compatible =3D "maxim,max31785a";
+		reg =3D <0x52>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+	};
+
+	dps: dps310 at 76 {
+		compatible =3D "infineon,dps310";
+		reg =3D <0x76>;
+		#io-channel-cells =3D <0>;
+	};
+
+	pca0: pca9552 at 60 {
+		compatible =3D "nxp,pca9552";
+		reg =3D <0x60>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		gpio-controller;
+		#gpio-cells =3D <2>;
+
+		gpio at 0 {
+			reg =3D <0>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 1 {
+			reg =3D <1>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 2 {
+			reg =3D <2>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 3 {
+			reg =3D <3>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 4 {
+			reg =3D <4>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 5 {
+			reg =3D <5>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 6 {
+			reg =3D <6>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 7 {
+			reg =3D <7>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 8 {
+			reg =3D <8>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 9 {
+			reg =3D <9>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 10 {
+			reg =3D <10>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 11 {
+			reg =3D <11>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 12 {
+			reg =3D <12>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 13 {
+			reg =3D <13>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 14 {
+			reg =3D <14>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 15 {
+			reg =3D <15>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	power-supply at 68 {
+		compatible =3D "ibm,cffps1";
+		reg =3D <0x68>;
+	};
+
+	power-supply at 69 {
+		compatible =3D "ibm,cffps1";
+		reg =3D <0x69>;
+	};
+};
+
+&i2c4 {
+	status =3D "okay";
+
+	tmp423a at 4c {
+		compatible =3D "ti,tmp423";
+		reg =3D <0x4c>;
+	};
+
+	ir35221 at 70 {
+		compatible =3D "infineon,ir35221";
+		reg =3D <0x70>;
+	};
+
+	ir35221 at 71 {
+		compatible =3D "infineon,ir35221";
+		reg =3D <0x71>;
+	};
+};
+
+
+&i2c5 {
+	status =3D "okay";
+
+	tmp423a at 4c {
+		compatible =3D "ti,tmp423";
+		reg =3D <0x4c>;
+	};
+
+	ir35221 at 70 {
+		compatible =3D "infineon,ir35221";
+		reg =3D <0x70>;
+	};
+
+	ir35221 at 71 {
+		compatible =3D "infineon,ir35221";
+		reg =3D <0x71>;
+	};
+};
+
+&i2c9 {
+	status =3D "okay";
+
+	tmp275 at 4a {
+		compatible =3D "ti,tmp275";
+		reg =3D <0x4a>;
+	};
+};
+
+&i2c10 {
+	/* MUX
+	 *   -> PCIe Slot 3
+	 *   -> PCIe Slot 4
+	 */
+	status =3D "okay";
+};
+
+&i2c11 {
+	status =3D "okay";
+
+	pca9552: pca9552 at 60 {
+		compatible =3D "nxp,pca9552";
+		reg =3D <0x60>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+
+		gpio-line-names =3D "PS_SMBUS_RESET_N", "APSS_RESET_N",
+			"GPU0_TH_OVERT_N_BUFF",	"GPU1_TH_OVERT_N_BUFF",
+			"GPU2_TH_OVERT_N_BUFF", "GPU3_TH_OVERT_N_BUFF",
+			"GPU4_TH_OVERT_N_BUFF",	"GPU5_TH_OVERT_N_BUFF",
+			"GPU0_PWR_GOOD_BUFF", "GPU1_PWR_GOOD_BUFF",
+			"GPU2_PWR_GOOD_BUFF", "GPU3_PWR_GOOD_BUFF",
+			"GPU4_PWR_GOOD_BUFF", "GPU5_PWR_GOOD_BUFF",
+			"12V_BREAKER_FLT_N", "THROTTLE_UNLATCHED_N";
+
+		gpio at 0 {
+			reg =3D <0>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 1 {
+			reg =3D <1>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 2 {
+			reg =3D <2>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 3 {
+			reg =3D <3>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 4 {
+			reg =3D <4>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 5 {
+			reg =3D <5>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 6 {
+			reg =3D <6>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 7 {
+			reg =3D <7>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 8 {
+			reg =3D <8>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 9 {
+			reg =3D <9>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 10 {
+			reg =3D <10>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 11 {
+			reg =3D <11>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 12 {
+			reg =3D <12>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 13 {
+			reg =3D <13>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 14 {
+			reg =3D <14>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 15 {
+			reg =3D <15>;
+			type =3D <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	rtc at 32 {
+		compatible =3D "epson,rx8900";
+		reg =3D <0x32>;
+	};
+
+	eeprom at 51 {
+		compatible =3D "atmel,24c64";
+		reg =3D <0x51>;
+	};
+
+	ucd90160 at 64 {
+		compatible =3D "ti,ucd90160";
+		reg =3D <0x64>;
+	};
+};
+
+&i2c12 {
+	status =3D "okay";
+};
+
+&i2c13 {
+	status =3D "okay";
+};
+
+&vuart {
+	status =3D "okay";
+};
+
+&gfx {
+	status =3D "okay";
+};
+
+&pinctrl {
+	aspeed,external-nodes =3D <&gfx &lhc>;
+};
+
+&wdt1 {
+	aspeed,reset-type =3D "none";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_wdtrst1_default>;
+};
--=20
2.14.1

