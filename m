From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 12 Apr 2024 09:43:58 -0500
Subject: [PATCH 3/3] ARM: dts: aspeed: Update Odyssey SBEFIFO compatible strings
In-Reply-To: <20240412144358.204129-1-eajames@linux.ibm.com>
References: <20240412144358.204129-1-eajames@linux.ibm.com>
Message-ID: <20240412144358.204129-4-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set the new compatible string for Odyssey SBEFIFOs so that they
don't collect async FFDC.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-everest.dts     | 64 +++++++++----------
 .../arm/boot/dts/aspeed/ibm-power10-quad.dtsi | 64 +++++++++----------
 2 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
index 214b2e6a4c6d..3a2bfdf035cb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
@@ -2545,7 +2545,7 @@ scom500: scom at 1000 {
 						};
 
 						sbefifo500: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2577,7 +2577,7 @@ scom501: scom at 1000 {
 						};
 
 						sbefifo501: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2609,7 +2609,7 @@ scom510: scom at 1000 {
 						};
 
 						sbefifo510: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2641,7 +2641,7 @@ scom511: scom at 1000 {
 						};
 
 						sbefifo511: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2673,7 +2673,7 @@ scom512: scom at 1000 {
 						};
 
 						sbefifo512: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2705,7 +2705,7 @@ scom513: scom at 1000 {
 						};
 
 						sbefifo513: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2737,7 +2737,7 @@ scom514: scom at 1000 {
 						};
 
 						sbefifo514: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2769,7 +2769,7 @@ scom515: scom at 1000 {
 						};
 
 						sbefifo515: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2918,7 +2918,7 @@ scom602: scom at 1000 {
 						};
 
 						sbefifo602: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2950,7 +2950,7 @@ scom603: scom at 1000 {
 						};
 
 						sbefifo603: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -2982,7 +2982,7 @@ scom610: scom at 1000 {
 						};
 
 						sbefifo610: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3014,7 +3014,7 @@ scom611: scom at 1000 {
 						};
 
 						sbefifo611: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3046,7 +3046,7 @@ scom614: scom at 1000 {
 						};
 
 						sbefifo614: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3078,7 +3078,7 @@ scom615: scom at 1000 {
 						};
 
 						sbefifo615: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3110,7 +3110,7 @@ scom616: scom at 1000 {
 						};
 
 						sbefifo616: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3142,7 +3142,7 @@ scom617: scom at 1000 {
 						};
 
 						sbefifo617: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3291,7 +3291,7 @@ scom700: scom at 1000 {
 						};
 
 						sbefifo700: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3323,7 +3323,7 @@ scom701: scom at 1000 {
 						};
 
 						sbefifo701: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3355,7 +3355,7 @@ scom710: scom at 1000 {
 						};
 
 						sbefifo710: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3387,7 +3387,7 @@ scom711: scom at 1000 {
 						};
 
 						sbefifo711: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3419,7 +3419,7 @@ scom712: scom at 1000 {
 						};
 
 						sbefifo712: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3451,7 +3451,7 @@ scom713: scom at 1000 {
 						};
 
 						sbefifo713: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3483,7 +3483,7 @@ scom714: scom at 1000 {
 						};
 
 						sbefifo714: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3515,7 +3515,7 @@ scom715: scom at 1000 {
 						};
 
 						sbefifo715: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3664,7 +3664,7 @@ scom802: scom at 1000 {
 						};
 
 						sbefifo802: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3696,7 +3696,7 @@ scom803: scom at 1000 {
 						};
 
 						sbefifo803: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3728,7 +3728,7 @@ scom810: scom at 1000 {
 						};
 
 						sbefifo810: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3760,7 +3760,7 @@ scom811: scom at 1000 {
 						};
 
 						sbefifo811: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3792,7 +3792,7 @@ scom814: scom at 1000 {
 						};
 
 						sbefifo814: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3824,7 +3824,7 @@ scom815: scom at 1000 {
 						};
 
 						sbefifo815: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3856,7 +3856,7 @@ scom816: scom at 1000 {
 						};
 
 						sbefifo816: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -3888,7 +3888,7 @@ scom817: scom at 1000 {
 						};
 
 						sbefifo817: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
index 57494c744b5d..ff81d9ea811a 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
@@ -22,7 +22,7 @@ scom100: scom at 1000 {
 			};
 
 			sbefifo100: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -50,7 +50,7 @@ scom101: scom at 1000 {
 			};
 
 			sbefifo101: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -78,7 +78,7 @@ scom110: scom at 1000 {
 			};
 
 			sbefifo110: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -106,7 +106,7 @@ scom111: scom at 1000 {
 			};
 
 			sbefifo111: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -134,7 +134,7 @@ scom112: scom at 1000 {
 			};
 
 			sbefifo112: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -162,7 +162,7 @@ scom113: scom at 1000 {
 			};
 
 			sbefifo113: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -190,7 +190,7 @@ scom114: scom at 1000 {
 			};
 
 			sbefifo114: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -218,7 +218,7 @@ scom115: scom at 1000 {
 			};
 
 			sbefifo115: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -246,7 +246,7 @@ scom202: scom at 1000 {
 			};
 
 			sbefifo202: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -274,7 +274,7 @@ scom203: scom at 1000 {
 			};
 
 			sbefifo203: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -302,7 +302,7 @@ scom210: scom at 1000 {
 			};
 
 			sbefifo210: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -330,7 +330,7 @@ scom211: scom at 1000 {
 			};
 
 			sbefifo211: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -358,7 +358,7 @@ scom214: scom at 1000 {
 			};
 
 			sbefifo214: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -386,7 +386,7 @@ scom215: scom at 1000 {
 			};
 
 			sbefifo215: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -414,7 +414,7 @@ scom216: scom at 1000 {
 			};
 
 			sbefifo216: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -442,7 +442,7 @@ scom217: scom at 1000 {
 			};
 
 			sbefifo217: sbefifo at 2400 {
-				compatible = "ibm,p9-sbefifo";
+				compatible = "ibm,ody-sbefifo";
 				reg = <0x2400 0x400>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -492,7 +492,7 @@ scom300: scom at 1000 {
 						};
 
 						sbefifo300: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -524,7 +524,7 @@ scom301: scom at 1000 {
 						};
 
 						sbefifo301: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -556,7 +556,7 @@ scom310: scom at 1000 {
 						};
 
 						sbefifo310: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -588,7 +588,7 @@ scom311: scom at 1000 {
 						};
 
 						sbefifo311: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -620,7 +620,7 @@ scom312: scom at 1000 {
 						};
 
 						sbefifo312: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -652,7 +652,7 @@ scom313: scom at 1000 {
 						};
 
 						sbefifo313: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -684,7 +684,7 @@ scom314: scom at 1000 {
 						};
 
 						sbefifo314: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -716,7 +716,7 @@ scom315: scom at 1000 {
 						};
 
 						sbefifo315: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -865,7 +865,7 @@ scom402: scom at 1000 {
 						};
 
 						sbefifo402: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -897,7 +897,7 @@ scom403: scom at 1000 {
 						};
 
 						sbefifo403: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -929,7 +929,7 @@ scom410: scom at 1000 {
 						};
 
 						sbefifo410: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -961,7 +961,7 @@ scom411: scom at 1000 {
 						};
 
 						sbefifo411: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -993,7 +993,7 @@ scom414: scom at 1000 {
 						};
 
 						sbefifo414: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -1025,7 +1025,7 @@ scom415: scom at 1000 {
 						};
 
 						sbefifo415: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -1057,7 +1057,7 @@ scom416: scom at 1000 {
 						};
 
 						sbefifo416: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
@@ -1089,7 +1089,7 @@ scom417: scom at 1000 {
 						};
 
 						sbefifo417: sbefifo at 2400 {
-							compatible = "ibm,p9-sbefifo";
+							compatible = "ibm,ody-sbefifo";
 							reg = <0x2400 0x400>;
 							#address-cells = <1>;
 							#size-cells = <0>;
-- 
2.39.3

