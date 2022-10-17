From: Cédric Le Goater <clg@kaod.org>
Date: Mon, 17 Oct 2022 11:16:22 +0200
Subject: [PATCH linux v2 1/3] spi: dt-bindings: aspeed: Add a ranges property
In-Reply-To: <20221017091624.130227-1-clg@kaod.org>
References: <20221017091624.130227-1-clg@kaod.org>
Message-ID: <20221017091624.130227-2-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"ranges" predefines settings for the decoding ranges of each CS.

Cc: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 .../devicetree/bindings/spi/aspeed,ast2600-fmc.yaml      | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
index fa8f4ac20985..a11cbc4c4c5c 100644
--- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -38,6 +38,14 @@ properties:
   interrupts:
     maxItems: 1
 
+  ranges:
+    minItems: 1
+    maxItems: 5
+    description: |
+      Defines the address mapping for child devices with four integer
+      values for each chip-select line in use:
+      <cs-number> 0 <physical address of mapping> <size>
+
 required:
   - compatible
   - reg
@@ -58,6 +66,7 @@ examples:
         compatible = "aspeed,ast2600-fmc";
         clocks = <&syscon ASPEED_CLK_AHB>;
         interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+        ranges = <0 0 0x20000000 0x2000000>, <1 0 0x22000000 0x2000000>;
 
         flash at 0 {
                 reg = < 0 >;
-- 
2.37.3

