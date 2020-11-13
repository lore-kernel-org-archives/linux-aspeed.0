From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
Date: Thu, 12 Nov 2020 23:59:26 -0600
Subject: [PATCH 4/6] ARM: dts: aspeed: rainier: Add leds that are off PIC16F882
In-Reply-To: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
References: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
Message-ID: <1605247168-1028-4-git-send-email-vishwa@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are many LEDs that are connected to PIC16F882.
PIC has the software implementation of PCA9552

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 690 +++++++++++++++++++++++++++
 1 file changed, 690 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index b7d7246..88fefc0 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -209,6 +209,336 @@
 			default-state = "keep";
 			gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
 		};
+
+		ddimm0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 0 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm1 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 1 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm2 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 2 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm3 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 3 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm4 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 4 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm5 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 5 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm6 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 6 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm7 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 7 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm8 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 8 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm9 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 9 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm10 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 10 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm11 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 11 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm12 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 12 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm13 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 13 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm14 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 14 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm15 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic1 15 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm16 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 0 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm17 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 1 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm18 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 2 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm19 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 3 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm20 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 4 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm21 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 5 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm22 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 6 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm23 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 7 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm24 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 8 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm25 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 9 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm26 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 10 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm27 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 11 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm28 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 12 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm29 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 13 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm30 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 14 GPIO_ACTIVE_LOW>;
+		};
+
+		ddimm31 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic2 15 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic3 0 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot1 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic3 1 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot2 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic3 2 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot3 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic3 3 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot4 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic3 4 GPIO_ACTIVE_LOW>;
+		};
+
+		cpu1 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic3 5 GPIO_ACTIVE_LOW>;
+		};
+
+		cpu1-vrm0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic3 6 GPIO_ACTIVE_LOW>;
+		};
+
+		lcd-russel {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic3 8 GPIO_ACTIVE_LOW>;
+		};
+
+		planar {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 0 GPIO_ACTIVE_LOW>;
+		};
+
+		cpu0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 1 GPIO_ACTIVE_LOW>;
+		};
+
+		dasd-pyramid0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 3 GPIO_ACTIVE_LOW>;
+		};
+
+		dasd-pyramid1 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 4 GPIO_ACTIVE_LOW>;
+		};
+
+		dasd-pyramid2 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 5 GPIO_ACTIVE_LOW>;
+		};
+
+		cpu0-vrm0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 6 GPIO_ACTIVE_LOW>;
+		};
+
+		rtc-battery {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 7 GPIO_ACTIVE_LOW>;
+		};
+
+		base-blyth {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 8 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot6 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 9 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot7 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 10 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot8 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 11 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot9 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 12 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot10 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 13 GPIO_ACTIVE_LOW>;
+		};
+
+		pcieslot11 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 14 GPIO_ACTIVE_LOW>;
+		};
+
+		tpm-wilson {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pic4 15 GPIO_ACTIVE_LOW>;
+		};
 	};
 };
 
@@ -981,6 +1311,366 @@
 		reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	pic1: pca9952 at 32 {
+		compatible = "ibm,pca9552";
+		reg = <0x32>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio at 0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 3 {
+			reg = <3>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 4 {
+			reg = <4>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 5 {
+			reg = <5>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 6 {
+			reg = <6>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 7 {
+			reg = <7>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 8 {
+			reg = <8>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 9 {
+			reg = <9>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 10 {
+			reg = <10>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 11 {
+			reg = <11>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 12 {
+			reg = <12>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 13 {
+			reg = <13>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 14 {
+			reg = <14>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 15 {
+			reg = <15>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	pic2: pca9552 at 31 {
+		compatible = "ibm,pca9552";
+		reg = <0x31>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio at 0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 3 {
+			reg = <3>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 4 {
+			reg = <4>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 5 {
+			reg = <5>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 6 {
+			reg = <6>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 7 {
+			reg = <7>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 8 {
+			reg = <8>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 9 {
+			reg = <9>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 10 {
+			reg = <10>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 11 {
+			reg = <11>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 12 {
+			reg = <12>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 13 {
+			reg = <13>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 14 {
+			reg = <14>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 15 {
+			reg = <15>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	pic3: pca9552 at 30 {
+		compatible = "ibm,pca9552";
+		reg = <0x30>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio at 0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 3 {
+			reg = <3>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 4 {
+			reg = <4>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 5 {
+			reg = <5>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 6 {
+			reg = <6>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 7 {
+			reg = <7>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 8 {
+			reg = <8>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 9 {
+			reg = <9>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 10 {
+			reg = <10>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 11 {
+			reg = <11>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 12 {
+			reg = <12>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 13 {
+			reg = <13>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 14 {
+			reg = <14>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 15 {
+			reg = <15>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
+	pic4: pca9552 at 33 {
+		compatible = "ibm,pca9552";
+		reg = <0x33>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio at 0 {
+			reg = <0>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 1 {
+			reg = <1>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 2 {
+			reg = <2>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 3 {
+			reg = <3>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 4 {
+			reg = <4>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 5 {
+			reg = <5>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 6 {
+			reg = <6>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 7 {
+			reg = <7>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 8 {
+			reg = <8>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 9 {
+			reg = <9>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 10 {
+			reg = <10>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 11 {
+			reg = <11>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 12 {
+			reg = <12>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 13 {
+			reg = <13>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 14 {
+			reg = <14>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+
+		gpio at 15 {
+			reg = <15>;
+			type = <PCA955X_TYPE_GPIO>;
+		};
+	};
+
 	dps: dps310 at 76 {
 		compatible = "infineon,dps310";
 		reg = <0x76>;
-- 
1.8.3.1

