From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 12 Jul 2018 13:48:46 +1000
Subject: [PATCH v3 4/5] arm: dts: OpenPower Romulus system can use coprocessor
 for FSI
In-Reply-To: <20180712034847.12878-1-benh@kernel.crashing.org>
References: <20180712034847.12878-1-benh@kernel.crashing.org>
Message-ID: <20180712034847.12878-5-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 347938673c83..4f4e42e47e3f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -37,6 +37,11 @@
 			compatible = "shared-dma-pool";
 			reusable;
 		};
+
+		coldfire_memory: codefire_memory at 9ef00000 {
+			reg = <0x9ef00000 0x00100000>;
+			no-map;
+		};
 	};
 
 	leds {
@@ -56,10 +61,13 @@
 	};
 
 	fsi: gpio-fsi {
-		compatible = "fsi-master-gpio", "fsi-master";
+		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
-		no-gpio-delays;
+
+		memory-region = <&coldfire_memory>;
+		aspeed,sram = <&sram>;
+		aspeed,cvic = <&cvic>;
 
 		clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
 		data-gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
-- 
2.17.1

