From: Matt Spinler <spinler@us.ibm.com>
Date: Fri, 19 Jul 2019 15:21:04 -0500
Subject: [PATCH linux dev-5.2] ARM: dts: aspeed: swift: Fix FSI GPIOs
Message-ID: <20190719202104.11488-1-spinler@us.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Change the FSI clock and data GPIOs to match what the hardware turned
out to use.

Signed-off-by: Matt Spinler <spinler@us.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
index caac895c60b4..f14f745b34ca 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
@@ -207,8 +207,8 @@
 		#size-cells = <0>;
 		no-gpio-delays;
 
-		clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
-		data-gpios = <&gpio ASPEED_GPIO(E, 0) GPIO_ACTIVE_HIGH>;
+		clock-gpios = <&gpio ASPEED_GPIO(P, 1) GPIO_ACTIVE_HIGH>;
+		data-gpios = <&gpio ASPEED_GPIO(P, 2) GPIO_ACTIVE_HIGH>;
 		mux-gpios = <&gpio ASPEED_GPIO(P, 4) GPIO_ACTIVE_HIGH>;
 		enable-gpios = <&gpio ASPEED_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
 		trans-gpios = <&gpio ASPEED_GPIO(P, 3) GPIO_ACTIVE_HIGH>;
-- 
2.22.0

