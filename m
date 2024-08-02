From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:24 +0930
Subject: [PATCH 7/7] ARM: dts: aspeed-g6: Drop cells properties from
 ethernet nodes
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Message-ID: <20240802-dt-warnings-bmc-dts-cleanups-v1-7-1cb1378e5fcd@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These are not specified in the binding and produce warnings such as
the following:

```
...
arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:254.27-262.5: Warning (avoid_unnecessary_addr_size): /ahb/ethernet at 1e670000: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
...
arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:264.27-272.5: Warning (avoid_unnecessary_addr_size): /ahb/ethernet at 1e690000: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
...
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: ethernet at 1e660000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index ae8aa54508b2..8ed715bd53aa 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -234,8 +234,6 @@ mdio3: mdio at 1e650018 {
 		mac0: ethernet at 1e660000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
 			status = "disabled";
@@ -244,8 +242,6 @@ mac0: ethernet at 1e660000 {
 		mac1: ethernet at 1e680000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
 			status = "disabled";
@@ -254,8 +250,6 @@ mac1: ethernet at 1e680000 {
 		mac2: ethernet at 1e670000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e670000 0x180>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
 			status = "disabled";
@@ -264,8 +258,6 @@ mac2: ethernet at 1e670000 {
 		mac3: ethernet at 1e690000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e690000 0x180>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
 			status = "disabled";

-- 
2.39.2

