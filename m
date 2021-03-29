From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:05 -0500
Subject: [PATCH 07/22] ARM: dts: aspeed: rainier: Add leds on optional DASD
 cards
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-8-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>

These cards are not hot pluggable and must be installed
prior to boot. LEDs on these are controlled by PCA9552
i2c expander

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 425 +++++++++++++++++++
 1 file changed, 425 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index b47b7b995170..0a420170b3b4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -634,6 +634,161 @@ tpm-wilson {
 		};
 	};
 
+	leds-optional-dasd-pyramid0 {
+		compatible = "gpio-leds";
+
+		nvme0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca2 0 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme1 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca2 1 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme2 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca2 2 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme3 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca2 3 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme4 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca2 4 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme5 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca2 5 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme6 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca2 6 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme7 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca2 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds-optional-dasd-pyramid1 {
+		compatible = "gpio-leds";
+
+		nvme8 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca3 0 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme9 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca3 1 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme10 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca3 2 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme11 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca3 3 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme12 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca3 4 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme13 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca3 5 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme14 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca3 6 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme15 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca3 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds-optional-dasd-pyramid2 {
+		compatible = "gpio-leds";
+
+		nvme16 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca4 0 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme17 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca4 1 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme18 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca4 2 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme19 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca4 3 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme20 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca4 4 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme21 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca4 5 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme22 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca4 6 GPIO_ACTIVE_LOW>;
+		};
+
+		nvme23 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca4 7 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &ehci1 {
@@ -2218,6 +2373,96 @@ eeprom at 50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
+
+	pca2: pca9552 at 60 {
+		compatible = "nxp,pca9552";
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
 };
 
 &i2c14 {
@@ -2227,6 +2472,96 @@ eeprom at 50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
+
+	pca3: pca9552 at 60 {
+		compatible = "nxp,pca9552";
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
 };
 
 &i2c15 {
@@ -2236,6 +2571,96 @@ eeprom at 50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 	};
+
+	pca4: pca9552 at 60 {
+		compatible = "nxp,pca9552";
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
 };
 
 &vuart1 {
-- 
2.27.0

