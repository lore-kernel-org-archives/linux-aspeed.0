From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:12 -0500
Subject: [PATCH 14/22] ARM: dts: Aspeed: Everest: Add FSI CFAMs and re-number
 engines
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-15-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add additional CFAMs and re-number the existing engines for the
extra processors present on the Everest system.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 648 ++++++++++++++++++-
 1 file changed, 644 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index cc45608b0cbc..de2606b416e6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -44,6 +44,38 @@ aliases {
 		i2c415 = &cfam3_i2c15;
 		i2c416 = &cfam3_i2c16;
 		i2c417 = &cfam3_i2c17;
+		i2c500 = &cfam4_i2c0;
+		i2c501 = &cfam4_i2c1;
+		i2c510 = &cfam4_i2c10;
+		i2c511 = &cfam4_i2c11;
+		i2c512 = &cfam4_i2c12;
+		i2c513 = &cfam4_i2c13;
+		i2c514 = &cfam4_i2c14;
+		i2c515 = &cfam4_i2c15;
+		i2c602 = &cfam5_i2c2;
+		i2c603 = &cfam5_i2c3;
+		i2c610 = &cfam5_i2c10;
+		i2c611 = &cfam5_i2c11;
+		i2c614 = &cfam5_i2c14;
+		i2c615 = &cfam5_i2c15;
+		i2c616 = &cfam5_i2c16;
+		i2c617 = &cfam5_i2c17;
+		i2c700 = &cfam6_i2c0;
+		i2c701 = &cfam6_i2c1;
+		i2c710 = &cfam6_i2c10;
+		i2c711 = &cfam6_i2c11;
+		i2c712 = &cfam6_i2c12;
+		i2c713 = &cfam6_i2c13;
+		i2c714 = &cfam6_i2c14;
+		i2c715 = &cfam6_i2c15;
+		i2c802 = &cfam7_i2c2;
+		i2c803 = &cfam7_i2c3;
+		i2c810 = &cfam7_i2c10;
+		i2c811 = &cfam7_i2c11;
+		i2c814 = &cfam7_i2c14;
+		i2c815 = &cfam7_i2c15;
+		i2c816 = &cfam7_i2c16;
+		i2c817 = &cfam7_i2c17;
 
 		i2c16 = &i2c4mux0chn0;
 		i2c17 = &i2c4mux0chn1;
@@ -83,6 +115,22 @@ aliases {
 		spi41 = &cfam3_spi1;
 		spi42 = &cfam3_spi2;
 		spi43 = &cfam3_spi3;
+		spi50 = &cfam4_spi0;
+		spi51 = &cfam4_spi1;
+		spi52 = &cfam4_spi2;
+		spi53 = &cfam4_spi3;
+		spi60 = &cfam5_spi0;
+		spi61 = &cfam5_spi1;
+		spi62 = &cfam5_spi2;
+		spi63 = &cfam5_spi3;
+		spi70 = &cfam6_spi0;
+		spi71 = &cfam6_spi1;
+		spi72 = &cfam6_spi2;
+		spi73 = &cfam6_spi3;
+		spi80 = &cfam7_spi0;
+		spi81 = &cfam7_spi1;
+		spi82 = &cfam7_spi2;
+		spi83 = &cfam7_spi3;
 	};
 
 	chosen {
@@ -604,7 +652,7 @@ &fsim0 {
 	 */
 	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
 
-	cfam at 0,0 {
+	cfam at 0,0 {	/* DCM0_C0 */
 		reg = <0 0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -748,7 +796,7 @@ fsi_hub0: hub at 3400 {
 };
 
 &fsi_hub0 {
-	cfam at 1,0 {
+	cfam at 1,0 { /* DCM0_C1 */
 		reg = <1 0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -892,7 +940,7 @@ fsi_hub1: hub at 3400 {
 		};
 	};
 
-	cfam at 2,0 {
+	cfam at 2,0 { /* DCM1_C0 */
 		reg = <2 0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -1036,7 +1084,7 @@ fsi_hub2: hub at 3400 {
 		};
 	};
 
-	cfam at 3,0 {
+	cfam at 3,0 { /* DCM1_C1 */
 		reg = <3 0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -1179,6 +1227,582 @@ fsi_hub3: hub at 3400 {
 			no-scan-on-init;
 		};
 	};
+
+	cfam at 4,0 { /* DCM2_C0 */
+		reg = <4 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <4>;
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
+			cfam4_i2c0: i2c-bus at 0 {
+				reg = <0>;	/* OM01 */
+			};
+
+			cfam4_i2c1: i2c-bus at 1 {
+				reg = <1>;	/* OM23 */
+			};
+
+			cfam4_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam4_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam4_i2c12: i2c-bus at c {
+				reg = <12>;	/* OP4A */
+			};
+
+			cfam4_i2c13: i2c-bus at d {
+				reg = <13>;	/* OP4B */
+			};
+
+			cfam4_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam4_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam4_spi0: spi at 0 {
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
+			cfam4_spi1: spi at 20 {
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
+			cfam4_spi2: spi at 40 {
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
+			cfam4_spi3: spi at 60 {
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
+			fsi_occ4: occ {
+				compatible = "ibm,p10-occ";
+			};
+		};
+
+		fsi_hub4: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+
+	cfam at 5,0 { /* DCM2_C1 */
+		reg = <5 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <5>;
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
+			cfam5_i2c2: i2c-bus at 2 {
+				reg = <2>;	/* OM45 */
+			};
+
+			cfam5_i2c3: i2c-bus at 3 {
+				reg = <3>;	/* OM67 */
+			};
+
+			cfam5_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam5_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam5_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam5_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
+
+			cfam5_i2c16: i2c-bus at 10 {
+				reg = <16>;	/* OP6A */
+			};
+
+			cfam5_i2c17: i2c-bus at 11 {
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
+			cfam5_spi0: spi at 0 {
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
+			cfam5_spi1: spi at 20 {
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
+			cfam5_spi2: spi at 40 {
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
+			cfam5_spi3: spi at 60 {
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
+			fsi_occ5: occ {
+				compatible = "ibm,p10-occ";
+			};
+		};
+
+		fsi_hub5: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+
+	cfam at 6,0 { /* DCM3_C0 */
+		reg = <6 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <6>;
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
+			cfam6_i2c0: i2c-bus at 0 {
+				reg = <0>;	/* OM01 */
+			};
+
+			cfam6_i2c1: i2c-bus at 1 {
+				reg = <1>;	/* OM23 */
+			};
+
+			cfam6_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam6_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam6_i2c12: i2c-bus at c {
+				reg = <12>;	/* OP4A */
+			};
+
+			cfam6_i2c13: i2c-bus at d {
+				reg = <13>;	/* OP4B */
+			};
+
+			cfam6_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam6_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
+		};
+
+		fsi2spi at 1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam6_spi0: spi at 0 {
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
+			cfam6_spi1: spi at 20 {
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
+			cfam6_spi2: spi at 40 {
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
+			cfam6_spi3: spi at 60 {
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
+			fsi_occ6: occ {
+				compatible = "ibm,p10-occ";
+			};
+		};
+
+		fsi_hub6: hub at 3400 {
+			compatible = "fsi-master-hub";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			no-scan-on-init;
+		};
+	};
+
+	cfam at 7,0 { /* DCM3_C1 */
+		reg = <7 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <7>;
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
+			cfam7_i2c2: i2c-bus at 2 {
+				reg = <2>;	/* OM45 */
+			};
+
+			cfam7_i2c3: i2c-bus at 3 {
+				reg = <3>;	/* OM67 */
+			};
+
+			cfam7_i2c10: i2c-bus at a {
+				reg = <10>;	/* OP3A */
+			};
+
+			cfam7_i2c11: i2c-bus at b {
+				reg = <11>;	/* OP3B */
+			};
+
+			cfam7_i2c14: i2c-bus at e {
+				reg = <14>;	/* OP5A */
+			};
+
+			cfam7_i2c15: i2c-bus at f {
+				reg = <15>;	/* OP5B */
+			};
+
+			cfam7_i2c16: i2c-bus at 10 {
+				reg = <16>;	/* OP6A */
+			};
+
+			cfam7_i2c17: i2c-bus at 11 {
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
+			cfam7_spi0: spi at 0 {
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
+			cfam7_spi1: spi at 20 {
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
+			cfam7_spi2: spi at 40 {
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
+			cfam7_spi3: spi at 60 {
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
+			fsi_occ7: occ {
+				compatible = "ibm,p10-occ";
+			};
+		};
+
+		fsi_hub7: hub at 3400 {
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
@@ -1198,6 +1822,22 @@ &fsi_occ3 {
 	reg = <4>;
 };
 
+&fsi_occ4 {
+	reg = <5>;
+};
+
+&fsi_occ5 {
+	reg = <6>;
+};
+
+&fsi_occ6 {
+	reg = <7>;
+};
+
+&fsi_occ7 {
+	reg = <8>;
+};
+
 &ibt {
 	status = "okay";
 };
-- 
2.27.0

