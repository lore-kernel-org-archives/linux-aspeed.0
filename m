From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Aug 2022 10:16:34 -0600
Subject: [PATCH 1/2] dt-bindings: pinctrl: aspeed: Add missing properties to examples
In-Reply-To: <20220810161635.73936-1-robh@kernel.org>
References: <20220810161635.73936-1-robh@kernel.org>
Message-ID: <20220810161635.73936-2-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aspeed pinctrl parent node (SCU) in the examples is missing various
properties. Add the properties in preparation for the SCU schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml | 6 ++++++
 .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml | 4 ++++
 .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index d3a8911728d0..f4f1ee6b116e 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -63,6 +63,12 @@ examples:
     syscon: scu at 1e6e2000 {
         compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
         reg = <0x1e6e2000 0x1a8>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6e2000 0x1000>;
 
         pinctrl: pinctrl {
             compatible = "aspeed,ast2400-pinctrl";
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 5d2c1b1fb7fd..8168f0088471 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -82,6 +82,10 @@ examples:
         #clock-cells = <1>;
         #reset-cells = <1>;
 
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6e2000 0x1000>;
+
         pinctrl: pinctrl {
             compatible = "aspeed,ast2500-pinctrl";
             aspeed,external-nodes = <&gfx>, <&lhc>;
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index e92686d2f062..62424c42c981 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -96,6 +96,12 @@ examples:
     syscon: scu at 1e6e2000 {
         compatible = "aspeed,ast2600-scu", "syscon", "simple-mfd";
         reg = <0x1e6e2000 0xf6c>;
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x1e6e2000 0x1000>;
 
         pinctrl: pinctrl {
             compatible = "aspeed,ast2600-pinctrl";
-- 
2.34.1

