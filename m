From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 16 May 2024 13:19:06 -0500
Subject: [PATCH v3 39/40] ARM: dts: aspeed: P10 and tacoma: Set FSI clock frequency
In-Reply-To: <20240516181907.3468796-1-eajames@linux.ibm.com>
References: <20240516181907.3468796-1-eajames@linux.ibm.com>
Message-ID: <20240516181907.3468796-40-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that the driver doesn't hardcode the clock divider, set it
in the device tree.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts | 1 +
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index 213023bc5aec4..96a8f727bc389 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -193,6 +193,7 @@ &fsim0 {
 	#address-cells = <2>;
 	#size-cells = <0>;
 
+	clock-frequency = <100000000>;
 	fsi-routing-gpios = <&gpio0 ASPEED_GPIO(Q, 7) GPIO_ACTIVE_HIGH>;
 	fsi-mux-gpios = <&gpio0 ASPEED_GPIO(B, 0) GPIO_ACTIVE_HIGH>;
 
diff --git a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
index 07ce3b2bc62a3..44e48e39e6e96 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
@@ -8,6 +8,7 @@ &fsim0 {
 	#size-cells = <0>;
 
 	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
+	clock-frequency = <100000000>;
 
 	cfam at 0,0 {
 		reg = <0 0>;
-- 
2.39.3

