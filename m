From: Tommy Haung <tommy_huang@aspeedtech.com>
Date: Tue, 7 Dec 2021 18:27:49 +0800
Subject: [PATCH v4 6/6] arm:boot:dts:aspeed-g6 Add more gfx reset control
In-Reply-To: <20211207102749.18118-1-tommy_huang@aspeedtech.com>
References: <20211207102749.18118-1-tommy_huang@aspeedtech.com>
Message-ID: <20211207102749.18118-8-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: tommy-huang <tommy_huang@aspeedtech.com>

Add more gfx reset control for ast2600.

Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index e38c3742761b..b92b24609660 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -356,7 +356,9 @@
 				reg = <0x1e6e6000 0x1000>;
 				reg-io-width = <4>;
 				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
-				resets = <&syscon ASPEED_RESET_GRAPHICS>;
+				resets = <&syscon ASPEED_RESET_CRT>,
+					 <&syscon ASPEED_RESET_GRAPHICS>;
+				reset-names = "crt", "engine";
 				syscon = <&syscon>;
 				status = "disabled";
 				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

