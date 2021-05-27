From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 27 May 2021 08:54:52 +0800
Subject: [PATCH v2 3/4] ARM: dts: aspeed-g5: Modify sgpio node for the
 enhanced sgpio driver.
In-Reply-To: <20210527005455.25758-1-steven_lee@aspeedtech.com>
References: <20210527005455.25758-1-steven_lee@aspeedtech.com>
Message-ID: <20210527005455.25758-4-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The enhanced sgpio driver has changed the compatible name to sgpiom
and reads the max number of sgpio pins that SoC supported from
max-ngpios in dts.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d733c1f161c1..730cbd48eedb 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -345,13 +345,14 @@
 
 			sgpio: sgpio at 1e780200 {
 				#gpio-cells = <2>;
-				compatible = "aspeed,ast2500-sgpio";
+				compatible = "aspeed,ast2500-sgpiom";
 				gpio-controller;
 				interrupts = <40>;
 				reg = <0x1e780200 0x0100>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
 				ngpios = <8>;
+				max-ngpios = <80>;
 				bus-frequency = <12000000>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_sgpm_default>;
-- 
2.17.1

