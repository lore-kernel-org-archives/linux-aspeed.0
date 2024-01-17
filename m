From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 17 Jan 2024 08:56:16 +0100
Subject: [PATCH 1/3] dt-bindings: i3c: drop "master" node name suffix
Message-ID: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Drop the requirement of "-master" suffix in node names because:
1. "Master" word is discouraged and MIPI Alliance renamed it to
   "Controller".
2. Some devices can operate in Controller (Master) or Target mode, thus
   the name is not accurate in such cases.
3. Other buses, like I2C controllers, use simple "i2c".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml | 2 +-
 Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml    | 2 +-
 Documentation/devicetree/bindings/i3c/i3c.yaml                | 4 ++--
 Documentation/devicetree/bindings/i3c/mipi-i3c-hci.yaml       | 2 +-
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
 Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
index fcc3dbff9c9a..47be5d9a32d4 100644
--- a/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
@@ -57,7 +57,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-    i3c-master at 2000 {
+    i3c at 2000 {
         compatible = "aspeed,ast2600-i3c";
         reg = <0x2000 0x1000>;
         #address-cells = <3>;
diff --git a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
index cc40d25358ec..cad6d53d0e2e 100644
--- a/Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/cdns,i3c-master.yaml
@@ -41,7 +41,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    i3c-master at d040000 {
+    i3c at d040000 {
         compatible = "cdns,i3c-master";
         clocks = <&coreclock>, <&i3csysclock>;
         clock-names = "pclk", "sysclk";
diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documentation/devicetree/bindings/i3c/i3c.yaml
index c816e295d565..c7900a1da8d9 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.yaml
+++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
@@ -17,7 +17,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^i3c-master@[0-9a-f]+$"
+    pattern: "^i3c@[0-9a-f]+$"
 
   "#address-cells":
     const: 3
@@ -153,7 +153,7 @@ additionalProperties: true
 
 examples:
   - |
-    i3c-master at d040000 {
+    i3c at d040000 {
         compatible = "cdns,i3c-master";
         clocks = <&coreclock>, <&i3csysclock>;
         clock-names = "pclk", "sysclk";
diff --git a/Documentation/devicetree/bindings/i3c/mipi-i3c-hci.yaml b/Documentation/devicetree/bindings/i3c/mipi-i3c-hci.yaml
index 5dda8cb44cdb..39bb1a1784c9 100644
--- a/Documentation/devicetree/bindings/i3c/mipi-i3c-hci.yaml
+++ b/Documentation/devicetree/bindings/i3c/mipi-i3c-hci.yaml
@@ -43,7 +43,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    i3c-master at a0000000 {
+    i3c at a0000000 {
       compatible = "mipi-i3c-hci";
       reg = <0xa0000000 0x2000>;
       interrupts = <89>;
diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 133855f11b4f..c56ff77677f1 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -48,7 +48,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    i3c-master at a0000000 {
+    i3c at a0000000 {
         compatible = "silvaco,i3c-master-v1";
         clocks = <&zynqmp_clk 71>, <&fclk>, <&sclk>;
         clock-names = "pclk", "fast_clk", "slow_clk";
diff --git a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
index 7a76fd32962a..c0e805e531be 100644
--- a/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
@@ -35,7 +35,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    i3c-master at 2000 {
+    i3c at 2000 {
         compatible = "snps,dw-i3c-master-1.00a";
         #address-cells = <3>;
         #size-cells = <0>;
-- 
2.34.1

