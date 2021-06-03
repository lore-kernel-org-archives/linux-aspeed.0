From: Joel Stanley <joel@jms.id.au>
Date: Thu,  3 Jun 2021 16:15:36 +0930
Subject: [PATCH] ARM: dts: aspeed-g5: Add SCU phandle to GFX node
Message-ID: <20210603064536.165297-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In v5.13 the DRM driver gained support for using a phandle to the SCU,
instead of matching on the scu compatible.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index d733c1f161c1..329eaeef66fb 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -264,6 +264,7 @@ gfx: display at 1e6e6000 {
 				reg-io-width = <4>;
 				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
 				resets = <&syscon ASPEED_RESET_CRT1>;
+				syscon = <&syscon>;
 				status = "disabled";
 				interrupts = <0x19>;
 			};
-- 
2.30.2

