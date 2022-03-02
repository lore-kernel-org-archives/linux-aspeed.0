From: Tommy Haung <tommy_huang@aspeedtech.com>
Date: Wed, 2 Mar 2022 10:49:30 +0800
Subject: [PATCH v6 5/5] ARM: dtsi: aspeed: Modified gfx reset control
In-Reply-To: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
References: <20220302024930.18758-1-tommy_huang@aspeedtech.com>
Message-ID: <20220302024930.18758-6-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove the ast2500-gfx from aspeed-g6.dtsi.
In the AST2600, the ASPEED_RESET_CRT1 is replaced by
ASPEED_RESET_GRAPHICS. This is no differnce between these two reset
behavior but reigster location is changed. The HW controller states
and FW programming resgiter will be reset by CRT reset controller bit
(SCU040[13]). And another part HW controller will be reset by
Graphics controller bit (SCU040[26]). These two reset bit need be
de-assert then the SOC display will be active.

Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index e38c3742761b..7cc99bc68558 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -352,7 +352,7 @@
 			};
 
 			gfx: display at 1e6e6000 {
-				compatible = "aspeed,ast2600-gfx", "aspeed,ast2500-gfx", "syscon";
+				compatible = "aspeed,ast2600-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
 				reg-io-width = <4>;
 				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
-- 
2.17.1

