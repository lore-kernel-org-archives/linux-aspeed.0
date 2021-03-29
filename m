From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:06 -0500
Subject: [PATCH 08/22] ARM: dts: aspeed: rainier: Add leds on optional PCI
 cable cards
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-9-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>

These are LEDs on the cable cards that plug into PCIE slots.
The LEDs are controlled by pca9552 i2c expander

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 264 +++++++++++++++++++
 1 file changed, 264 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 0a420170b3b4..78238ffc8997 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -789,6 +789,70 @@ nvme23 {
 			gpios = <&pca4 7 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	leds-optional-cablecard0 {
+		compatible = "gpio-leds";
+
+		cablecard0-cxp-top {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca5 0 GPIO_ACTIVE_LOW>;
+		};
+
+		cablecard0-cxp-bot {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca5 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds-optional-cablecard3 {
+		compatible = "gpio-leds";
+
+		cablecard3-cxp-top {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca6 0 GPIO_ACTIVE_LOW>;
+		};
+
+		cablecard3-cxp-bot {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca6 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds-optional-cablecard4 {
+		compatible = "gpio-leds";
+
+		cablecard4-cxp-top {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca7 0 GPIO_ACTIVE_LOW>;
+		};
+
+		cablecard4-cxp-bot {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca7 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds-optional-cablecard10 {
+		compatible = "gpio-leds";
+
+		cablecard10-cxp-top {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca8 0 GPIO_ACTIVE_LOW>;
+		};
+
+		cablecard10-cxp-bot {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca8 1 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &ehci1 {
@@ -1544,6 +1608,56 @@ eeprom at 52 {
 		compatible = "atmel,24c64";
 		reg = <0x52>;
 	};
+
+	pca5: pca9551 at 60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
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
+	};
 };
 
 &i2c5 {
@@ -1568,6 +1682,106 @@ eeprom at 51 {
 		compatible = "atmel,24c64";
 		reg = <0x51>;
 	};
+
+	pca6: pca9551 at 60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
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
+	};
+
+	pca7: pca9551 at 61 {
+		compatible = "nxp,pca9551";
+		reg = <0x61>;
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
+	};
 };
 
 &i2c6 {
@@ -2360,6 +2574,56 @@ eeprom at 51 {
 		compatible = "atmel,24c64";
 		reg = <0x51>;
 	};
+
+	pca8: pca9551 at 60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
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
+	};
 };
 
 &i2c12 {
-- 
2.27.0

