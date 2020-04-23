From: Ben Pai <Ben_Pai@wistron.com>
Date: Thu, 23 Apr 2020 17:52:30 +0800
Subject: [PATCH v1] ARM: dts: aspeed: mihawk: add aliases for i2c
Message-ID: <20200423095230.7622-1-Ben_Pai@wistron.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set the bus id for each mux channel to avoid switching channels
multiple times

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 293 +++++++++++++++++++-
 1 file changed, 289 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index f7e935ede919..0f8550f158f5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -8,6 +8,52 @@
 	model = "Mihawk BMC";
 	compatible = "ibm,mihawk-bmc", "aspeed,ast2500";
 
+	aliases {
+		i2c215 = &bus6_mux215;
+		i2c216 = &bus6_mux216;
+		i2c217 = &bus6_mux217;
+		i2c218 = &bus6_mux218;
+		i2c219 = &bus6_mux219;
+		i2c220 = &bus6_mux220;
+		i2c221 = &bus6_mux221;
+		i2c222 = &bus6_mux222;
+		i2c223 = &bus7_mux223;
+		i2c224 = &bus7_mux224;
+		i2c225 = &bus7_mux225;
+		i2c226 = &bus7_mux226;
+		i2c227 = &bus7_mux227;
+		i2c228 = &bus7_mux228;
+		i2c229 = &bus7_mux229;
+		i2c230 = &bus7_mux230;
+		i2c231 = &bus9_mux231;
+		i2c232 = &bus9_mux232;
+		i2c233 = &bus9_mux233;
+		i2c234 = &bus9_mux234;
+		i2c235 = &bus9_mux235;
+		i2c236 = &bus9_mux236;
+		i2c237 = &bus9_mux237;
+		i2c238 = &bus9_mux238;
+		i2c239 = &bus10_mux239;
+		i2c240 = &bus10_mux240;
+		i2c241 = &bus10_mux241;
+		i2c242 = &bus10_mux242;
+		i2c243 = &bus10_mux243;
+		i2c244 = &bus10_mux244;
+		i2c245 = &bus10_mux245;
+		i2c246 = &bus10_mux246;
+		i2c247 = &bus12_mux247;
+		i2c248 = &bus12_mux248;
+		i2c249 = &bus12_mux249;
+		i2c250 = &bus12_mux250;
+		i2c251 = &bus13_mux251;
+		i2c252 = &bus13_mux252;
+		i2c253 = &bus13_mux253;
+		i2c254 = &bus13_mux254;
+		i2c255 = &bus13_mux255;
+		i2c256 = &bus13_mux256;
+		i2c257 = &bus13_mux257;
+		i2c258 = &bus13_mux258;
+	};
 
 	chosen {
 		stdout-path = &uart5;
@@ -630,6 +676,54 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+
+		bus6_mux215: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		bus6_mux216: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		bus6_mux217: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		bus6_mux218: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		bus6_mux219: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		bus6_mux220: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		bus6_mux221: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		bus6_mux222: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
 	};
 
 };
@@ -644,6 +738,54 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+
+		bus7_mux223: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		bus7_mux224: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		bus7_mux225: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		bus7_mux226: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		bus7_mux227: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		bus7_mux228: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		bus7_mux229: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		bus7_mux230: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
 	};
 
 };
@@ -684,6 +826,30 @@
 		i2c-mux-idle-disconnect;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+
+		bus9_mux231: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		bus9_mux232: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		bus9_mux233: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		bus9_mux234: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 
 	pca9545 at 71 {
@@ -695,6 +861,30 @@
 		i2c-mux-idle-disconnect;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+
+		bus9_mux235: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		bus9_mux236: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		bus9_mux237: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		bus9_mux238: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
@@ -725,6 +915,30 @@
 		i2c-mux-idle-disconnect;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+
+		bus10_mux239: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		bus10_mux240: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		bus10_mux241: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		bus10_mux242: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 
 	pca9545 at 71 {
@@ -736,6 +950,30 @@
 		i2c-mux-idle-disconnect;
 		interrupt-controller;
 		#interrupt-cells = <2>;
+
+		bus10_mux243: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		bus10_mux244: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		bus10_mux245: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		bus10_mux246: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
@@ -796,7 +1034,7 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		i2c at 0 {
+		bus12_mux247: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
@@ -807,7 +1045,7 @@
 			};
 		};
 
-		i2c at 1 {
+		bus12_mux248: i2c at 1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
@@ -818,7 +1056,7 @@
 			};
 		};
 
-		i2c at 2 {
+		bus12_mux249: i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
@@ -829,7 +1067,7 @@
 			};
 		};
 
-		i2c at 3 {
+		bus12_mux250: i2c at 3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <3>;
@@ -857,6 +1095,53 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		reg = <0x70>;
+		bus13_mux251: i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		bus13_mux252: i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		bus13_mux253: i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		bus13_mux254: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		bus13_mux255: i2c at 4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		bus13_mux256: i2c at 5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		bus13_mux257: i2c at 6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		bus13_mux258: i2c at 7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
 	};
 };
 
-- 
2.17.1


---------------------------------------------------------------------------------------------------------------------------------------------------------------
This email contains confidential or legally privileged information and is for the sole use of its intended recipient. 
Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
---------------------------------------------------------------------------------------------------------------------------------------------------------------
