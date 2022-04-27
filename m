From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Wed, 27 Apr 2022 11:54:59 +0800
Subject: [PATCH net-next v6 1/3] dt-bindings: net: add reset property for
 aspeed, ast2600-mdio binding
In-Reply-To: <20220427035501.17500-1-dylan_hung@aspeedtech.com>
References: <20220427035501.17500-1-dylan_hung@aspeedtech.com>
Message-ID: <20220427035501.17500-2-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 MDIO bus controller has a reset control bit and must be
deasserted before manipulating the MDIO controller. By default, the
hardware asserts the reset so the driver only need to deassert it.

Regarding to the old DT blobs which don't have reset property in them,
the reset deassertion is usually done by the bootloader so the reset
property is optional to work with them.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
index 1c88820cbcdf..f81eda8cb0a5 100644
--- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
@@ -20,10 +20,14 @@ allOf:
 properties:
   compatible:
     const: aspeed,ast2600-mdio
+
   reg:
     maxItems: 1
     description: The register range of the MDIO controller instance
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -34,11 +38,13 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/ast2600-clock.h>
     mdio0: mdio at 1e650000 {
             compatible = "aspeed,ast2600-mdio";
             reg = <0x1e650000 0x8>;
             #address-cells = <1>;
             #size-cells = <0>;
+            resets = <&syscon ASPEED_RESET_MII>;
 
             ethphy0: ethernet-phy at 0 {
                     compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

