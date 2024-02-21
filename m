From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Wed, 21 Feb 2024 12:45:51 -0000
Subject: [PATCH v6 5/5] dt-bindings: mmc: hisilicon,hi3798cv200-dw-mshc:
 add Hi3798MV200 binding
In-Reply-To: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
References: <20240221-b4-mmc-hi3798mv200-v6-0-bc41bf6a9769@outlook.com>
Message-ID: <20240221-b4-mmc-hi3798mv200-v6-5-bc41bf6a9769@outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Xiwen <forbidden405@outlook.com>

Add binding and an extra property for Hi3798MV200 DWMMC specific extension.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 .../mmc/hisilicon,hi3798cv200-dw-mshc.yaml         | 24 +++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
index f3dc973cb490..41c9b22523e7 100644
--- a/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/hisilicon,hi3798cv200-dw-mshc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/hisilicon,hi3798cv200-dw-mshc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Hisilicon Hi3798CV200 SoC specific extensions to the Synopsys DWMMC controller
+title: Hisilicon HiSTB SoCs specific extensions to the Synopsys DWMMC controller
 
 maintainers:
   - Yang Xiwen <forbidden405@outlook.com>
@@ -13,6 +13,7 @@ properties:
   compatible:
     enum:
       - hisilicon,hi3798cv200-dw-mshc
+      - hisilicon,hi3798mv200-dw-mshc
 
   reg:
     maxItems: 1
@@ -34,6 +35,15 @@ properties:
       - const: ciu-sample
       - const: ciu-drive
 
+  hisilicon,sap-dll-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      DWMMC core on Hi3798MV2x SoCs has a delay-locked-loop(DLL) attached to card data input path.
+      It is integrated into CRG core on the SoC and has to be controlled during tuning.
+    items:
+      - description: A phandle pointed to the CRG syscon node
+      - description: Sample DLL register offset in CRG address space
+
 required:
   - compatible
   - reg
@@ -44,6 +54,18 @@ required:
 allOf:
   - $ref: synopsys-dw-mshc-common.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hisilicon,hi3798mv200-dw-mshc
+    then:
+      required:
+        - hisilicon,sap-dll-reg
+    else:
+      properties:
+        hisilicon,sap-dll-reg: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0

