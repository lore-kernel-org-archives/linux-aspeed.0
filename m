From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Fri, 25 Mar 2022 12:14:49 +0800
Subject: [PATCH v3 1/3] dt-bindings: net: add reset property for aspeed,
 ast2600-mdio binding
In-Reply-To: <20220325041451.894-1-dylan_hung@aspeedtech.com>
References: <20220325041451.894-1-dylan_hung@aspeedtech.com>
Message-ID: <20220325041451.894-2-dylan_hung@aspeedtech.com>
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
---
 .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
index 1c88820cbcdf..7f43b4fe86a3 100644
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
@@ -39,6 +43,7 @@ examples:
             reg = <0x1e650000 0x8>;
             #address-cells = <1>;
             #size-cells = <0>;
+            resets = <&syscon 35>;
 
             ethphy0: ethernet-phy at 0 {
                     compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

