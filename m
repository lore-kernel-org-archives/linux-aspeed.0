From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Fri,  2 Aug 2024 00:01:26 +0800
Subject: [PATCH v3 02/11] ARM: dts: aspeed: Harma: add VR device
In-Reply-To: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
References: <20240801160136.1281291-1-peteryin.openbmc@gmail.com>
Message-ID: <20240801160136.1281291-3-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add isl69260, xdpe152c4 device

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index d99fba321379..8fb30029e46c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -398,6 +398,30 @@ imux28: i2c at 0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			power-monitor at 61 {
+				compatible = "isil,isl69260";
+				reg = <0x61>;
+			};
+			power-monitor at 62 {
+				compatible = "isil,isl69260";
+				reg = <0x62>;
+			};
+			power-monitor at 63 {
+				compatible = "isil,isl69260";
+				reg = <0x63>;
+			};
+			power-monitor at 64 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x64>;
+			};
+			power-monitor at 66 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x66>;
+			};
+			power-monitor at 68 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x68>;
+			};
 		};
 		imux29: i2c at 1 {
 			#address-cells = <1>;
-- 
2.25.1

