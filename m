From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
Date: Thu, 12 Nov 2020 23:59:27 -0600
Subject: [PATCH 5/6] ARM: dts: aspeed: rainier: Add leds on optional DASD cards
In-Reply-To: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
References: <1605247168-1028-1-git-send-email-vishwa@linux.vnet.ibm.com>
Message-ID: <1605247168-1028-5-git-send-email-vishwa@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These cards are not hot pluggable and must be installed
prior to boot. LEDs on these are controlled by PCA9552
I2C expander

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 426 +++++++++++++++++++++++++++
 1 file changed, 426 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 88fefc0..67c8c40 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -540,6 +540,162 @@
 			gpios = <&pic4 15 GPIO_ACTIVE_LOW>;
 		};
 	};
+
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
@@ -1885,6 +2041,96 @@
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
@@ -1894,6 +2140,96 @@
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
@@ -1903,6 +2239,96 @@
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
1.8.3.1

