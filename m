From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  3 Dec 2019 22:34:11 +1030
Subject: [PATCH 10/14] ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
Message-ID: <c7b124576dc133cc03119507e472dec18c048438.1575369656.git-series.andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix the following warning:

    arch/arm/boot/dts/aspeed-g5.dtsi:409.27-414.8: Warning (unique_unit_address): /ahb/apb/lpc at 1e789000/lpc-host at 80/lpc-ctrl at 0: duplicate unit-address (also used in node /ahb/apb/lpc at 1e789000/lpc-host at 80/lpc-snoop at 0)

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 +++---
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 46c0891aac5a..e1d4af06c217 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -346,14 +346,14 @@
 
 					lpc_ctrl: lpc-ctrl at 0 {
 						compatible = "aspeed,ast2400-lpc-ctrl";
-						reg = <0x0 0x80>;
+						reg = <0x0 0x10>;
 						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
-					lpc_snoop: lpc-snoop at 0 {
+					lpc_snoop: lpc-snoop at 10 {
 						compatible = "aspeed,ast2400-lpc-snoop";
-						reg = <0x0 0x80>;
+						reg = <0x10 0x8>;
 						interrupts = <8>;
 						status = "disabled";
 					};
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 5757d3f0e947..013d1f98ecf1 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -458,14 +458,14 @@
 
 					lpc_ctrl: lpc-ctrl at 0 {
 						compatible = "aspeed,ast2500-lpc-ctrl";
-						reg = <0x0 0x80>;
+						reg = <0x0 0x10>;
 						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
-					lpc_snoop: lpc-snoop at 0 {
+					lpc_snoop: lpc-snoop at 10 {
 						compatible = "aspeed,ast2500-lpc-snoop";
-						reg = <0x0 0x80>;
+						reg = <0x10 0x8>;
 						interrupts = <8>;
 						status = "disabled";
 					};
-- 
git-series 0.9.1
