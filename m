From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Wed, 26 Jun 2024 21:03:29 +0800
Subject: [PATCH v1 14/17] ARM: dts: aspeed: minerva: Switch the i2c bus number
In-Reply-To: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
References: <20240626130332.929534-1-yangchen.openbmc@gmail.com>
Message-ID: <20240626130332.929534-15-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yang.chen@quantatw.com>

Switch the i2c bus number to map the i2c tag according to the hardware design.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 7a790e347853..8f3f15a5c148 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -384,7 +384,7 @@ temperature-sensor at 4b {
 			};
 		};
 
-		imux20: i2c at 4 {
+		imux20: i2c at 5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
@@ -430,7 +430,7 @@ temperature-sensor at 4b {
 			};
 		};
 
-		imux21: i2c at 5 {
+		imux21: i2c at 4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-- 
2.34.1

