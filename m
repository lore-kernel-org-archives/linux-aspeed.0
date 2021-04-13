From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 13 Apr 2021 14:43:08 -0500
Subject: [PATCH 4/4] ARM: dts: aspeed: Rainier: Update to pass 2 hardware
In-Reply-To: <20210413194308.36930-1-eajames@linux.ibm.com>
References: <20210413194308.36930-1-eajames@linux.ibm.com>
Message-ID: <20210413194308.36930-5-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the muxes present in pass 2 and remove the eeproms that were
removed.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 193 +++++++++++++++----
 1 file changed, 153 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index b13bd7ed18d1..941c0489479a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -50,6 +50,17 @@ aliases {
 		i2c17 = &i2c2mux1;
 		i2c18 = &i2c2mux2;
 		i2c19 = &i2c2mux3;
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
 
 		spi10 = &cfam0_spi0;
 		spi11 = &cfam0_spi1;
@@ -1118,19 +1129,46 @@ tmp275 at 4a {
 		reg = <0x4a>;
 	};
 
-	eeprom at 50 {
-		compatible = "atmel,24c64";
-		reg = <0x50>;
-	};
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
 
-	eeprom at 51 {
-		compatible = "atmel,24c64";
-		reg = <0x51>;
-	};
+		i2c4mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	eeprom at 52 {
-		compatible = "atmel,24c64";
-		reg = <0x52>;
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
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
 	};
 };
 
@@ -1147,14 +1185,35 @@ tmp275 at 49 {
 		reg = <0x49>;
 	};
 
-	eeprom at 50 {
-		compatible = "atmel,24c64";
-		reg = <0x50>;
-	};
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
 
-	eeprom at 51 {
-		compatible = "atmel,24c64";
-		reg = <0x51>;
+		i2c5mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
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
+		};
 	};
 };
 
@@ -1176,24 +1235,57 @@ tmp275 at 4b {
 		reg = <0x4b>;
 	};
 
-	eeprom at 50 {
-		compatible = "atmel,24c64";
-		reg = <0x50>;
-	};
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
 
-	eeprom at 51 {
-		compatible = "atmel,24c64";
-		reg = <0x51>;
-	};
+		i2c6mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	eeprom at 52 {
-		compatible = "atmel,24c64";
-		reg = <0x52>;
-	};
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
 
-	eeprom at 53 {
-		compatible = "atmel,24c64";
-		reg = <0x53>;
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
 	};
 };
 
@@ -1550,14 +1642,35 @@ tmp275 at 49 {
 		reg = <0x49>;
 	};
 
-	eeprom at 50 {
-		compatible = "atmel,24c64";
-		reg = <0x50>;
-	};
+	pca9546 at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
 
-	eeprom at 51 {
-		compatible = "atmel,24c64";
-		reg = <0x51>;
+		i2c11mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
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
 	};
 };
 
-- 
2.27.0

