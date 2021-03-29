From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:02 -0500
Subject: [PATCH 04/22] ARM: dts: aspeed: rainier: Add additional processor
 CFAMs
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-5-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rainier has two dual-chip modules and therefore four CFAMs with their
associated engines. Add these to the devicetree with the i2c busses
that have devices on them.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 283 ++++++++++++++++++-
 1 file changed, 281 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 757b45e2eddc..aaedd817e1cb 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -12,6 +12,39 @@ / {
 	compatible = "ibm,rainier-bmc", "aspeed,ast2600";
 
 	aliases {
+		i2c100 = &cfam0_i2c0;
+		i2c101 = &cfam0_i2c1;
+		i2c110 = &cfam0_i2c10;
+		i2c111 = &cfam0_i2c11;
+		i2c112 = &cfam0_i2c12;
+		i2c113 = &cfam0_i2c13;
+		i2c114 = &cfam0_i2c14;
+		i2c115 = &cfam0_i2c15;
+		i2c202 = &cfam1_i2c2;
+		i2c203 = &cfam1_i2c3;
+		i2c210 = &cfam1_i2c10;
+		i2c211 = &cfam1_i2c11;
+		i2c214 = &cfam1_i2c14;
+		i2c215 = &cfam1_i2c15;
+		i2c216 = &cfam1_i2c16;
+		i2c217 = &cfam1_i2c17;
+		i2c300 = &cfam2_i2c0;
+		i2c301 = &cfam2_i2c1;
+		i2c310 = &cfam2_i2c10;
+		i2c311 = &cfam2_i2c11;
+		i2c312 = &cfam2_i2c12;
+		i2c313 = &cfam2_i2c13;
+		i2c314 = &cfam2_i2c14;
+		i2c315 = &cfam2_i2c15;
+		i2c402 = &cfam3_i2c2;
+		i2c403 = &cfam3_i2c3;
+		i2c410 = &cfam3_i2c10;
+		i2c411 = &cfam3_i2c11;
+		i2c414 = &cfam3_i2c14;
+		i2c415 = &cfam3_i2c15;
+		i2c416 = &cfam3_i2c16;
+		i2c417 = &cfam3_i2c17;
+
 		serial4 = &uart5;
 		i2c16 = &i2c2mux0;
 		i2c17 = &i2c2mux1;
@@ -30,6 +63,10 @@ aliases {
 		spi31 = &cfam2_spi1;
 		spi32 = &cfam2_spi2;
 		spi33 = &cfam2_spi3;
+		spi40 = &cfam3_spi0;
+		spi41 = &cfam3_spi1;
+		spi42 = &cfam3_spi2;
+		spi43 = &cfam3_spi3;
 	};
 
 	chosen {
@@ -321,6 +358,38 @@ i2c at 1800 {
 			reg = <0x1800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			cfam0_i2c0: i2c-bus at 0 {
+				reg = <0>;	/* OMI01 */
+			};
+
+			cfam0_i2c1: i2c-bus at 1 {
+				reg = <1>;	/* OMI23 */
+			};
+
+			cfam0_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam0_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam0_i2c12: i2c-bus at c {
+				reg = <12>;	/* OP4A */
+			};
+
+			cfam0_i2c13: i2c-bus at d {
+				reg = <13>;	/* OP4B */
+			};
+
+			cfam0_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam0_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
 		};
 
 		fsi2spi at 1c00 {
@@ -412,8 +481,6 @@ fsi_hub0: hub at 3400 {
 			reg = <0x3400 0x400>;
 			#address-cells = <2>;
 			#size-cells = <0>;
-
-			no-scan-on-init;
 		};
 	};
 };
@@ -435,6 +502,38 @@ i2c at 1800 {
 			reg = <0x1800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			cfam1_i2c2: i2c-bus at 2 {
+				reg = <2>;	/* OMI45 */
+			};
+
+			cfam1_i2c3: i2c-bus at 3 {
+				reg = <3>;	/* OMI67 */
+			};
+
+			cfam1_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam1_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam1_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam1_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
+
+			cfam1_i2c16: i2c-bus at 10 {
+				reg = <16>;	/* OP6A */
+			};
+
+			cfam1_i2c17: i2c-bus at 11 {
+				reg = <17>;	/* OP6B */
+			};
 		};
 
 		fsi2spi at 1c00 {
@@ -547,6 +646,38 @@ i2c at 1800 {
 			reg = <0x1800 0x400>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			cfam2_i2c0: i2c-bus at 0 {
+				reg = <0>;	/* OM01 */
+			};
+
+			cfam2_i2c1: i2c-bus at 1 {
+				reg = <1>;	/* OM23 */
+			};
+
+			cfam2_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam2_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam2_i2c12: i2c-bus at c {
+				reg = <12>;	/* OP4A */
+			};
+
+			cfam2_i2c13: i2c-bus at d {
+				reg = <13>;	/* OP4B */
+			};
+
+			cfam2_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam2_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
 		};
 
 		fsi2spi at 1c00 {
@@ -642,6 +773,150 @@ fsi_hub2: hub at 3400 {
 			no-scan-on-init;
 		};
 	};
+
+	cfam at 3,0 {
+		reg = <3 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <3>;
+
+		scom at 1000 {
+			compatible = "ibm,fsi2pib";
+			reg = <0x1000 0x400>;
+		};
+
+		i2c at 1800 {
+			compatible = "ibm,fsi-i2c-master";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam3_i2c2: i2c-bus at 2 {
+				reg = <2>;	/* OM45 */
+			};
+
+			cfam3_i2c3: i2c-bus at 3 {
+				reg = <3>;	/* OM67 */
+			};
+
+			cfam3_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam3_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam3_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam3_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
+
+			cfam3_i2c16: i2c-bus at 10 {
+				reg = <16>;	/* OP6A */
+			};
+
+			cfam3_i2c17: i2c-bus at 11 {
+				reg = <17>;	/* OP6B */
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam3_spi0: spi at 0 {
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam3_spi1: spi at 20 {
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam3_spi2: spi at 40 {
+				reg = <0x40>;
+				compatible = "ibm,fsi2spi-restricted";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+
+			cfam3_spi3: spi at 60 {
+				reg = <0x60>;
+				compatible = "ibm,fsi2spi-restricted";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom at 0 {
+					at25,byte-len = <0x80000>;
+					at25,addr-mode = <4>;
+					at25,page-size = <256>;
+
+					compatible = "atmel,at25";
+					reg = <0>;
+					spi-max-frequency = <1000000>;
+				};
+			};
+		};
+
+		sbefifo at 2400 {
+			compatible = "ibm,p9-sbefifo";
+			reg = <0x2400 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			fsi_occ3: occ {
+				compatible = "ibm,p10-occ";
+			};
+		};
+
+		fsi_hub3: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
 };
 
 /* Legacy OCC numbering (to get rid of when userspace is fixed) */
@@ -657,6 +932,10 @@ &fsi_occ2 {
 	reg = <3>;
 };
 
+&fsi_occ3 {
+	reg = <4>;
+};
+
 &ibt {
 	status = "okay";
 };
-- 
2.27.0

