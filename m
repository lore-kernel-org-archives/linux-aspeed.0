From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 12 Dec 2023 10:40:00 -0600
Subject: [PATCH v1 4/8] ARM: dts: aspeed: System1: Add i2c and muxes
In-Reply-To: <20231212164004.1683589-1-ninad@linux.ibm.com>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
Message-ID: <20231212164004.1683589-5-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commit adds i2c devices and muxes.

Tested:
    This board is tested using the simics simulator.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 577 ++++++++++++++++++
 1 file changed, 577 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 01291b407f59..0557bff9f36a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -11,6 +11,65 @@ / {
 	model = "System1";
 	compatible = "ibm,system1-bmc", "aspeed,ast2600";
 
+	aliases {
+		i2c16 = &i2c8mux1chn0;
+		i2c17 = &i2c8mux1chn1;
+		i2c18 = &i2c8mux1chn2;
+		i2c19 = &i2c8mux1chn3;
+		i2c20 = &i2c8mux1chn4;
+		i2c21 = &i2c8mux1chn5;
+		i2c22 = &i2c8mux1chn6;
+		i2c23 = &i2c8mux1chn7;
+		i2c24 = &i2c3mux0chn0;
+		i2c25 = &i2c3mux0chn1;
+		i2c26 = &i2c3mux0chn2;
+		i2c27 = &i2c3mux0chn3;
+		i2c28 = &i2c3mux0chn4;
+		i2c29 = &i2c3mux0chn5;
+		i2c30 = &i2c3mux0chn6;
+		i2c31 = &i2c3mux0chn7;
+		i2c32 = &i2c6mux0chn0;
+		i2c33 = &i2c6mux0chn1;
+		i2c34 = &i2c6mux0chn2;
+		i2c35 = &i2c6mux0chn3;
+		i2c36 = &i2c6mux0chn4;
+		i2c37 = &i2c6mux0chn5;
+		i2c38 = &i2c6mux0chn6;
+		i2c39 = &i2c6mux0chn7;
+		i2c40 = &i2c7mux0chn0;
+		i2c41 = &i2c7mux0chn1;
+		i2c42 = &i2c7mux0chn2;
+		i2c43 = &i2c7mux0chn3;
+		i2c44 = &i2c7mux0chn4;
+		i2c45 = &i2c7mux0chn5;
+		i2c46 = &i2c7mux0chn6;
+		i2c47 = &i2c7mux0chn7;
+		i2c48 = &i2c8mux0chn0;
+		i2c49 = &i2c8mux0chn1;
+		i2c50 = &i2c8mux0chn2;
+		i2c51 = &i2c8mux0chn3;
+		i2c52 = &i2c8mux0chn4;
+		i2c53 = &i2c8mux0chn5;
+		i2c54 = &i2c8mux0chn6;
+		i2c55 = &i2c8mux0chn7;
+		i2c56 = &i2c14mux0chn0;
+		i2c57 = &i2c14mux0chn1;
+		i2c58 = &i2c14mux0chn2;
+		i2c59 = &i2c14mux0chn3;
+		i2c60 = &i2c14mux0chn4;
+		i2c61 = &i2c14mux0chn5;
+		i2c62 = &i2c14mux0chn6;
+		i2c63 = &i2c14mux0chn7;
+		i2c64 = &i2c15mux0chn0;
+		i2c65 = &i2c15mux0chn1;
+		i2c66 = &i2c15mux0chn2;
+		i2c67 = &i2c15mux0chn3;
+		i2c68 = &i2c15mux0chn4;
+		i2c69 = &i2c15mux0chn5;
+		i2c70 = &i2c15mux0chn6;
+		i2c71 = &i2c15mux0chn7;
+	};
+
 	chosen {
 		stdout-path = &uart5;
 		bootargs = "console=ttyS4,115200n8 earlycon";
@@ -54,10 +113,12 @@ vga_memory: region at bf000000 {
 			reg = <0xbf000000 0x01000000>;  /* 16M */
 		};
 	};
+
 };
 
 &adc1 {
 	status = "okay";
+
 	aspeed,int-vref-microvolt = <2500000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc8_default
@@ -186,3 +247,519 @@ &kcs3 {
 	aspeed,lpc-io-reg = <0xca2>;
 	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 };
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux at 70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c3mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c3mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c3mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c3mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c3mux0chn4: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c3mux0chn5: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c3mux0chn6: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c3mux0chn7: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+
+	i2c-mux at 70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c6mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c6mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c6mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c6mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c6mux0chn4: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c6mux0chn5: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c6mux0chn6: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c6mux0chn7: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c7 {
+	status = "okay";
+
+	i2c-mux at 70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c7mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c7mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c7mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c7mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c7mux0chn4: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c7mux0chn5: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c7mux0chn6: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c7mux0chn7: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	i2c-mux at 71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c8mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c8mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c8mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c8mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c8mux0chn4: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			i2c-mux at 70 {
+				compatible = "nxp,pca9548";
+				reg = <0x70>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "okay";
+				i2c-mux-idle-disconnect;
+
+				i2c8mux1chn0: i2c at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c8mux1chn1: i2c at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c8mux1chn2: i2c at 2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c8mux1chn3: i2c at 3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				i2c8mux1chn4: i2c at 4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				i2c8mux1chn5: i2c at 5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				i2c8mux1chn6: i2c at 6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				i2c8mux1chn7: i2c at 7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
+		};
+
+		i2c8mux0chn5: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c8mux0chn6: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c8mux0chn7: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c14 {
+	status = "okay";
+
+	i2c-mux at 70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c14mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c14mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c14mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c14mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c14mux0chn4: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		i2c14mux0chn5: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c14mux0chn6: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c14mux0chn7: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c15 {
+	status = "okay";
+
+	i2c-mux at 71 {
+		compatible = "nxp,pca9548";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c15mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		i2c15mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c15mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		i2c15mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		i2c15mux0chn4: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			i2c-mux at 70 {
+				compatible = "nxp,pca9548";
+				reg = <0x70>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "okay";
+				i2c-mux-idle-disconnect;
+
+				i2c15mux1chn0: i2c at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+				};
+
+				i2c15mux1chn1: i2c at 1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+
+				i2c15mux1chn2: i2c at 2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <2>;
+				};
+
+				i2c15mux1chn3: i2c at 3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <3>;
+				};
+
+				i2c15mux1chn4: i2c at 4 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <4>;
+				};
+
+				i2c15mux1chn5: i2c at 5 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <5>;
+				};
+
+				i2c15mux1chn6: i2c at 6 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <6>;
+				};
+
+				i2c15mux1chn7: i2c at 7 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <7>;
+				};
+			};
+		};
+
+		i2c15mux0chn5: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		i2c15mux0chn6: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		i2c15mux0chn7: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
-- 
2.39.2

