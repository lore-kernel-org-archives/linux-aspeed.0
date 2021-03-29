From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:10 -0500
Subject: [PATCH 12/22] ARM: dts: aspeed: Everest: Add I2C components
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-13-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: PriyangaRamasamy <priyanga24@in.ibm.com>

Tested and able to bound the devices with i2c driver.

Signed-off-by: PriyangaRamasamy <priyanga24@in.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 408 +++++++++++++++++++
 1 file changed, 408 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 6bd876657bb8..ab7be4d511a5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -45,6 +45,25 @@ aliases {
 		i2c416 = &cfam3_i2c16;
 		i2c417 = &cfam3_i2c17;
 
+		i2c16 = &i2c4mux0chn0;
+		i2c17 = &i2c4mux0chn1;
+		i2c18 = &i2c4mux0chn2;
+		i2c19 = &i2c5mux0chn0;
+		i2c20 = &i2c5mux0chn1;
+		i2c21 = &i2c5mux0chn2;
+		i2c22 = &i2c5mux0chn3;
+		i2c23 = &i2c6mux0chn0;
+		i2c24 = &i2c6mux0chn1;
+		i2c25 = &i2c6mux0chn2;
+		i2c26 = &i2c6mux0chn3;
+		i2c27 = &i2c14mux0chn0;
+		i2c28 = &i2c14mux0chn1;
+		i2c29 = &i2c14mux0chn2;
+		i2c30 = &i2c14mux1chn0;
+		i2c31 = &i2c14mux1chn1;
+		i2c32 = &i2c14mux1chn2;
+		i2c33 = &i2c14mux1chn3;
+
 		serial4 = &uart5;
 
 		spi10 = &cfam0_spi0;
@@ -105,6 +124,395 @@ vga_memory: region at bf000000 {
 	};
 };
 
+&i2c0 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
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
+	eeprom at 54 {
+		compatible = "atmel,24c128";
+		reg = <0x54>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
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
+	};
+};
+
+&i2c5 {
+	status = "okay";
+
+	i2c-switch at 70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c5mux0chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
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
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+
+		i2c5mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+		};
+
+		i2c5mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	i2c-switch at 70 {
+		compatible = "nxp,pca9546";
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
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c6mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
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
+			eeprom at 53 {
+				compatible = "atmel,24c64";
+				reg = <0x53>;
+			};
+		};
+
+		i2c6mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			eeprom at 51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+			};
+		};
+	};
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+};
+
+&i2c9 {
+	status = "okay";
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	eeprom at 53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+	};
+};
+
+&i2c11 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+	};
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+
+	eeprom at 51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	eeprom at 53 {
+		compatible = "atmel,24c128";
+		reg = <0x53>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c128";
+		reg = <0x52>;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+
+	i2c-switch at 70 {
+		compatible = "nxp,pca9546";
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
+			eeprom at 50 {
+				compatible = "atmel,24c64";
+				reg = <0x50>;
+			};
+		};
+
+		i2c14mux0chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 51 {
+				compatible = "atmel,24c32";
+				reg = <0x51>;
+			};
+		};
+
+		i2c14mux0chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+
+	i2c-switch at 71 {
+		compatible = "nxp,pca9546";
+		reg = <0x71>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+		i2c-mux-idle-disconnect;
+
+		i2c14mux1chn0: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c14mux1chn1: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c14mux1chn2: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c14mux1chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			eeprom at 50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+&i2c15 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.27.0

