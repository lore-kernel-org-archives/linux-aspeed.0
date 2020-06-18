From: Sasha Levin <sashal@kernel.org>
Date: Wed, 17 Jun 2020 21:04:21 -0400
Subject: [PATCH AUTOSEL 5.7 164/388] ARM: dts: aspeed: ast2600: Set arch timer
 always-on
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
Message-ID: <20200618010805.600873-164-sashal@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Eddie James <eajames@linux.ibm.com>

[ Upstream commit c998f40f2ae6a48e93206e2c1ea0691479989611 ]

According to ASPEED, FTTMR010 is not intended to be used in the AST2600.
The arch timer should be used, but Linux doesn't enable high-res timers
without being assured that the arch timer is always on, so set that
property in the devicetree.

The FTTMR010 device is described by set to disabled.

This fixes highres timer support for AST2600.

Fixes: 2ca5646b5c2f ("ARM: dts: aspeed: Add AST2600 and EVB")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 0a29b3b57a9d..fd0e483737a0 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -65,6 +65,7 @@ timer {
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 		clocks = <&syscon ASPEED_CLK_HPLL>;
 		arm,cpu-registers-not-fw-configured;
+		always-on;
 	};
 
 	ahb {
@@ -368,6 +369,7 @@ timer: timer at 1e782000 {
 						<&gic  GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&syscon ASPEED_CLK_APB1>;
 				clock-names = "PCLK";
+				status = "disabled";
                         };
 
 			uart1: serial at 1e783000 {
-- 
2.25.1

