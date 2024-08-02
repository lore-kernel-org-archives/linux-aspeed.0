From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:20 +0930
Subject: [PATCH 3/7] ARM: dts: aspeed: Specify required properties for sram
 node
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Message-ID: <20240802-dt-warnings-bmc-dts-cleanups-v1-3-1cb1378e5fcd@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: sram at 1e720000: '#address-cells' is a required property
        from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: sram at 1e720000: '#size-cells' is a required property
        from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: sram at 1e720000: 'ranges' is a required property
        from schema $id: http://devicetree.org/schemas/sram/sram.yaml#
```

Fixes: d44a1138cd82 ("arm/dts: Add Aspeed ast2400 device tree")
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 3 +++
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index ec9563c629df..78c967812492 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -230,6 +230,9 @@ adc: adc at 1e6e9000 {
 			sram: sram at 1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x8000>;	// 32K
+				ranges;
+				#address-cells = <1>;
+				#size-cells = <1>;
 			};
 
 			video: video at 1e700000 {
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index a846df1a65ff..100380417f99 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -314,6 +314,9 @@ video: video at 1e700000 {
 			sram: sram at 1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x9000>;	// 36K
+				ranges;
+				#address-cells = <1>;
+				#size-cells = <1>;
 			};
 
 			sdmmc: sd-controller at 1e740000 {

-- 
2.39.2

