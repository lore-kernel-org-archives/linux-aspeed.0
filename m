From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 09:59:59 -0500
Subject: [PATCH 01/22] ARM: dts: aspeed: rainier: Add Operator Panel LEDs
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-2-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishwanatha Subbanna <vishwa@linux.ibm.com>

These LEDs are on the op-panel and are connected via a pca9551 i2c
LED expander.

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 82 ++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 6c9804d2f3b4..e775ad026d8b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -131,6 +131,38 @@ i2c2mux3: i2c at 3 {
 			reg = <3>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		/* System ID LED that is at front on Op Panel */
+		front-sys-id0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca_oppanel 0 GPIO_ACTIVE_LOW>;
+		};
+
+		/* System Attention Indicator ID LED that is at front on Op Panel */
+		front-check-log0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca_oppanel 1 GPIO_ACTIVE_LOW>;
+		};
+
+		/* Enclosure Fault LED that is at front on Op Panel */
+		front-enc-fault1 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca_oppanel 2 GPIO_ACTIVE_LOW>;
+		};
+
+		/* System PowerOn LED that is at front on Op Panel */
+		front-sys-pwron0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca_oppanel 3 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &ehci1 {
@@ -849,6 +881,56 @@ ibm-panel at 62 {
 		reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	pca_oppanel: pca9551 at 60 {
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
 	dps: dps310 at 76 {
 		compatible = "infineon,dps310";
 		reg = <0x76>;
-- 
2.27.0

