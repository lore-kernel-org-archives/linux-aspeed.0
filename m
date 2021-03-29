From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:01 -0500
Subject: [PATCH 03/22] ARM: dts: aspeed: rainier: Add gpio-keys-polled for fans
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Brandon Wyman <bjwyman@gmail.com>

Add a gpio-keys-polled section to the Rainier device tree for the fan
presence signals on the PCA9552 I2C device on bus 7.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
Signed-off-by: Matthew Barth <msbarth@linux.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 1515f81a6c9f..757b45e2eddc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -183,6 +183,49 @@ front-sys-pwron0 {
 			gpios = <&pca_oppanel 3 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <1000>;
+
+		fan0-presence {
+			label = "fan0-presence";
+			gpios = <&pca0 6 GPIO_ACTIVE_LOW>;
+			linux,code = <6>;
+		};
+
+		fan1-presence {
+			label = "fan1-presence";
+			gpios = <&pca0 7 GPIO_ACTIVE_LOW>;
+			linux,code = <7>;
+		};
+
+		fan2-presence {
+			label = "fan2-presence";
+			gpios = <&pca0 8 GPIO_ACTIVE_LOW>;
+			linux,code = <8>;
+		};
+
+		fan3-presence {
+			label = "fan3-presence";
+			gpios = <&pca0 9 GPIO_ACTIVE_LOW>;
+			linux,code = <9>;
+		};
+
+		fan4-presence {
+			label = "fan4-presence";
+			gpios = <&pca0 10 GPIO_ACTIVE_LOW>;
+			linux,code = <10>;
+		};
+
+		fan5-presence {
+			label = "fan5-presence";
+			gpios = <&pca0 11 GPIO_ACTIVE_LOW>;
+			linux,code = <11>;
+		};
+	};
 };
 
 &ehci1 {
-- 
2.27.0

