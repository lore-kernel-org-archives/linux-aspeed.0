From: Ninad Palsule <ninad@linux.ibm.com>
Date: Wed,  5 Jun 2024 11:06:03 -0500
Subject: [PATCH v2] ARM: dts: aspeed: System1: Updates to BMC board
Message-ID: <20240605160604.2135840-1-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- Changed temperature sensor monitor chip from tmp423 to tmp432

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index dcbc16308ab50..f3efecc7eb8d0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -1138,7 +1138,7 @@ i2c8mux0chn6: i2c at 6 {
 			reg = <6>;
 
 			temperature-sensor at 4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
@@ -1599,7 +1599,7 @@ i2c15mux0chn6: i2c at 6 {
 			reg = <6>;
 
 			temperature-sensor at 4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
@@ -1615,7 +1615,7 @@ regulator at 40 {
 			};
 
 			temperature-sensor at 4c {
-				compatible = "ti,tmp423";
+				compatible = "ti,tmp432";
 				reg = <0x4c>;
 			};
 		};
-- 
2.40.1

