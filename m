From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 14 Aug 2024 08:54:20 +0800
Subject: [PATCH v4 1/2] ARM: dts: aspeed: Add properties of scu and gfx for video
In-Reply-To: <20240814005421.3362441-1-jammy_huang@aspeedtech.com>
References: <20240814005421.3362441-1-jammy_huang@aspeedtech.com>
Message-ID: <20240814005421.3362441-2-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

To have video support capture from SoC display(GFX), these properties
are added to allow video to control related registers.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 7fb421153596..9f122717dfe3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -451,6 +451,8 @@ video: video at 1e700000 {
 					 <&syscon ASPEED_CLK_GATE_ECLK>;
 				clock-names = "vclk", "eclk";
 				interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				aspeed,scu = <&syscon>;
+				aspeed,gfx = <&gfx>;
 				status = "disabled";
 			};
 
-- 
2.25.1

