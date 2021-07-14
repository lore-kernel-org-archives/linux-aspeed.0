From: Sasha Levin <sashal@kernel.org>
Date: Wed, 14 Jul 2021 15:37:18 -0400
Subject: [PATCH AUTOSEL 5.13 066/108] ARM: dts: aspeed: Everest: Fix cable
 card PCA chips
In-Reply-To: <20210714193800.52097-1-sashal@kernel.org>
References: <20210714193800.52097-1-sashal@kernel.org>
Message-ID: <20210714193800.52097-66-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Santosh Puranik <santosh.puranik@in.ibm.com>

[ Upstream commit 010da3daf9278ed03d38b7dcb0422f1a7df1bdd3 ]

Correct two PCA chips which were placed on the wrong I2C bus and
address.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Santosh Puranik <santosh.puranik@in.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 168 +++++++++----------
 1 file changed, 83 insertions(+), 85 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 3295c8c7c05c..27af28c8847d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -353,10 +353,47 @@ gpio at 15 {
 
 &i2c1 {
 	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
 
-	pca2: pca9552 at 61 {
+&i2c3 {
+	status = "okay";
+
+	eeprom at 54 {
+		compatible = "atmel,24c128";
+		reg = <0x54>;
+	};
+
+	power-supply at 68 {
+		compatible = "ibm,cffps";
+		reg = <0x68>;
+	};
+
+	power-supply at 69 {
+		compatible = "ibm,cffps";
+		reg = <0x69>;
+	};
+
+	power-supply at 6a {
+		compatible = "ibm,cffps";
+		reg = <0x6a>;
+	};
+
+	power-supply at 6b {
+		compatible = "ibm,cffps";
+		reg = <0x6b>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	pca2: pca9552 at 65 {
 		compatible = "nxp,pca9552";
-		reg = <0x61>;
+		reg = <0x65>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -424,12 +461,54 @@ gpio at 9 {
 			reg = <9>;
 			type = <PCA955X_TYPE_GPIO>;
 		};
+	};
 
+	i2c-switch at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c4mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+		};
+
+		i2c4mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c4mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
 	};
+};
 
-	pca3: pca9552 at 62 {
+&i2c5 {
+	status = "okay";
+
+	pca3: pca9552 at 66 {
 		compatible = "nxp,pca9552";
-		reg = <0x62>;
+		reg = <0x66>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -512,87 +591,6 @@ gpio at 11 {
 
 	};
 
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2c3 {
-	status = "okay";
-
-	eeprom at 54 {
-		compatible = "atmel,24c128";
-		reg = <0x54>;
-	};
-
-	power-supply at 68 {
-		compatible = "ibm,cffps";
-		reg = <0x68>;
-	};
-
-	power-supply at 69 {
-		compatible = "ibm,cffps";
-		reg = <0x69>;
-	};
-
-	power-supply at 6a {
-		compatible = "ibm,cffps";
-		reg = <0x6a>;
-	};
-
-	power-supply at 6b {
-		compatible = "ibm,cffps";
-		reg = <0x6b>;
-	};
-};
-
-&i2c4 {
-	status = "okay";
-
-	i2c-switch at 70 {
-		compatible = "nxp,pca9546";
-		reg = <0x70>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		status = "okay";
-		i2c-mux-idle-disconnect;
-
-		i2c4mux0chn0: i2c at 0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-			eeprom at 52 {
-				compatible = "atmel,24c64";
-				reg = <0x52>;
-			};
-		};
-
-		i2c4mux0chn1: i2c at 1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-			eeprom at 50 {
-				compatible = "atmel,24c64";
-				reg = <0x50>;
-			};
-		};
-
-		i2c4mux0chn2: i2c at 2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-			eeprom at 51 {
-				compatible = "atmel,24c64";
-				reg = <0x51>;
-			};
-		};
-	};
-};
-
-&i2c5 {
-	status = "okay";
-
 	i2c-switch at 70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;
-- 
2.30.2

