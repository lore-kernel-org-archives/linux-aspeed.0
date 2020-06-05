From: Ben Pai <Ben_Pai@wistron.com>
Date: Fri, 5 Jun 2020 18:06:28 +0800
Subject: [PATCH v1 2/2] ARM: dts: aspeed: mihawk: Add 8 tmp401 thermal sensor
Message-ID: <20200605100628.14807-1-Ben_Pai@wistron.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Ben Pai <Ben_Pai@wistron.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts | 40 +++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index 25ffe65fbdc0..5bf1f13dda3b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -834,6 +834,11 @@
 					line-name = "smbus0";
 				};
 			};
+
+			tmp431 at 4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus9_mux232: i2c at 1 {
@@ -854,6 +859,11 @@
 					line-name = "smbus1";
 				};
 			};
+
+			tmp431 at 4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus9_mux233: i2c at 2 {
@@ -897,6 +907,11 @@
 					line-name = "smbus2";
 				};
 			};
+
+			tmp431 at 4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus9_mux236: i2c at 1 {
@@ -917,6 +932,11 @@
 					line-name = "smbus3";
 				};
 			};
+
+			tmp431 at 4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus9_mux237: i2c at 2 {
@@ -979,6 +999,11 @@
 					line-name = "smbus4";
 				};
 			};
+
+			tmp431 at 4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus10_mux240: i2c at 1 {
@@ -999,6 +1024,11 @@
 					line-name = "smbus5";
 				};
 			};
+
+			tmp431 at 4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus10_mux241: i2c at 2 {
@@ -1042,6 +1072,11 @@
 					line-name = "smbus6";
 				};
 			};
+
+			tmp431 at 4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus10_mux244: i2c at 1 {
@@ -1062,6 +1097,11 @@
 					line-name = "smbus7";
 				};
 			};
+
+			tmp431 at 4c {
+				compatible = "ti,tmp401";
+				reg = <0x4c>;
+			};
 		};
 
 		bus10_mux245: i2c at 2 {
-- 
2.17.1


---------------------------------------------------------------------------------------------------------------------------------------------------------------
This email contains confidential or legally privileged information and is for the sole use of its intended recipient. 
Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
---------------------------------------------------------------------------------------------------------------------------------------------------------------
