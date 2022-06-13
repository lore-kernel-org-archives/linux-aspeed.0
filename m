From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 13 Jun 2022 17:51:50 +0800
Subject: [PATCH 4/4] ARM: dts: aspeed: bletchley: update fusb302 nodes
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
Message-ID: <20220613095150.21917-5-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

1. Add interrupt pin of fusb302 on each sled.
2. Add vbus-supply property in each fusb302 node.
3. Fix BMC power-role at source and data-role at host.
4. Disable PD to avoid "HARD Reset" due to incompatible PD ver.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 150 ++++++++++++------
 1 file changed, 102 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 7b6de9b51547..9fdb3d17596b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -225,6 +225,60 @@
 			linux,code = <ASPEED_GPIO(H, 7)>;
 		};
 	};
+
+	vbus_sled1: vbus_sled1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled1_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled2: vbus_sled2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled2";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled2_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled3: vbus_sled3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled3";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled3_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled4: vbus_sled4 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled4";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled4_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled5: vbus_sled5 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled5";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled5_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vbus_sled6: vbus_sled6 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbus_sled6";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&sled6_ioexp 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &mac2 {
@@ -336,17 +390,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 0) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled1>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -422,17 +476,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 1) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled2>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -508,17 +562,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(B, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled3>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -594,17 +648,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(S, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled4>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -680,17 +734,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(Y, 3) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled5>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
@@ -766,17 +820,17 @@
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
 
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 7) IRQ_TYPE_LEVEL_LOW>;
+		vbus-supply = <&vbus_sled6>;
+
 		connector {
 			compatible = "usb-c-connector";
 			label = "USB-C";
-			power-role = "dual";
-			try-power-role = "sink";
-			data-role = "dual";
-			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
-			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
-					PDO_VAR(3000, 12000, 3000)
-					PDO_PPS_APDO(3000, 11000, 3000)>;
-			op-sink-microwatt = <10000000>;
+			power-role = "source";
+			data-role = "host";
+			pd-disable;
+			typec-power-opmode = "default";
 		};
 	};
 
-- 
2.17.1

