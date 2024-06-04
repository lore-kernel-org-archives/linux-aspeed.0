From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue,  4 Jun 2024 16:59:39 -0500
Subject: [PATCH v1] ARM: dts: aspeed: System1: Updates to BMC board
Message-ID: <20240604215939.1967329-1-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- Added new power monitor device max5970
- Changed temperature sensor monitor chip from tmp423 to tmp432

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index dcbc16308ab50..e09a6b383ba49 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -753,6 +753,11 @@ &i2c4 {
 &i2c5 {
 	status = "okay";
 
+	power-monitor at 3a {
+		compatible = "maxim,max5970";
+		reg = <0x3a>;
+	};
+
 	regulator at 42 {
 		compatible = "infineon,ir38263";
 		reg = <0x42>;
@@ -1138,7 +1143,7 @@ i2c8mux0chn6: i2c at 6 {
 			reg = <6>;
 
 			temperature-sensor at 4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
@@ -1599,7 +1604,7 @@ i2c15mux0chn6: i2c at 6 {
 			reg = <6>;
 
 			temperature-sensor at 4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
@@ -1615,7 +1620,7 @@ regulator at 40 {
 			};
 
 			temperature-sensor at 4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
-- 
2.40.1

