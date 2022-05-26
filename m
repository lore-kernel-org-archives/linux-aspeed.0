From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 26 May 2022 22:41:27 +0200
Subject: [PATCH] ARM: dts: aspeed: adjust whitespace around '='
Message-ID: <20220526204127.831853-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts | 6 +++---
 arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
index 61bc74b423cf..a5e64ccc2b3a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
@@ -24,17 +24,17 @@ memory at 80000000 {
 	leds {
 		compatible = "gpio-leds";
 		postcode0 {
-			label="BMC_UP";
+			label = "BMC_UP";
 			gpios = <&gpio ASPEED_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 		postcode1 {
-			label="BMC_HB";
+			label = "BMC_HB";
 			gpios = <&gpio ASPEED_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 		postcode2 {
-			label="FAULT";
+			label = "FAULT";
 			gpios = <&gpio ASPEED_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
 		};
 		// postcode3-7 are GPIOH3-H7
diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts
index 69e1bd256271..46cbba6305b8 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-s6q.dts
@@ -65,19 +65,19 @@ leds {
 		compatible = "gpio-leds";
 
 		BMC_HEARTBEAT_N {
-			label="BMC_HEARTBEAT_N";
+			label = "BMC_HEARTBEAT_N";
 			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
 		BMC_LED_STATUS_AMBER_N {
-			label="BMC_LED_STATUS_AMBER_N";
+			label = "BMC_LED_STATUS_AMBER_N";
 			gpios = <&gpio0 ASPEED_GPIO(S, 6) GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
 		FM_ID_LED_N {
-			label="FM_ID_LED_N";
+			label = "FM_ID_LED_N";
 			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
-- 
2.34.1

