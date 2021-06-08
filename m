From: Steven Lee <steven_lee@aspeedtech.com>
Date: Tue, 8 Jun 2021 18:25:39 +0800
Subject: [PATCH v5 04/10] ARM: dts: aspeed-g5: Remove ngpios from sgpio node.
In-Reply-To: <20210608102547.4880-1-steven_lee@aspeedtech.com>
References: <20210608102547.4880-1-steven_lee@aspeedtech.com>
Message-ID: <20210608102547.4880-5-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove ngpios property from sgpio node as it should be defined in the
platform dts.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d733c1f161c1..2701a58a5ab7 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -351,7 +351,6 @@
 				reg = <0x1e780200 0x0100>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				interrupt-controller;
-				ngpios = <8>;
 				bus-frequency = <12000000>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_sgpm_default>;
-- 
2.17.1

