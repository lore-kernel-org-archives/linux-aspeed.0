From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 29 May 2022 12:49:23 +0200
Subject: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
In-Reply-To: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20220529104928.79636-2-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document all compatibles used in existing upstreamed Aspeed AST2400,
AST2500 and AST2600 based boards.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
new file mode 100644
index 000000000000..f214b57d5ae1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed SoC based boards
+
+maintainers:
+  - Joel Stanley <joel@jms.id.au>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: AST2400 based boards
+        items:
+          - enum:
+              - facebook,galaxy100-bmc
+              - facebook,wedge100-bmc
+              - facebook,wedge40-bmc
+              - microsoft,olympus-bmc
+              - quanta,q71l-bmc
+              - tyan,palmetto-bmc
+              - yadro,vesnin-bmc
+          - const: aspeed,ast2400
+
+      - description: AST2500 based boards
+        items:
+          - enum:
+              - amd,ethanolx-bmc
+              - ampere,mtjade-bmc
+              - asrock,e3c246d4i-bmc
+              - asrock,romed8hm3-bmc
+              - bytedance,g220a-bmc
+              - facebook,cmm-bmc
+              - facebook,minipack-bmc
+              - facebook,tiogapass-bmc
+              - facebook,yamp-bmc
+              - facebook,yosemitev2-bmc
+              - facebook,wedge400-bmc
+              - hxt,stardragon4800-rep2-bmc
+              - ibm,mihawk-bmc
+              - ibm,mowgli-bmc
+              - ibm,romulus-bmc
+              - ibm,swift-bmc
+              - ibm,witherspoon-bmc
+              - ingrasys,zaius-bmc
+              - inspur,fp5280g2-bmc
+              - inspur,nf5280m6-bmc
+              - inspur,on5263m5-bmc
+              - intel,s2600wf-bmc
+              - inventec,lanyang-bmc
+              - lenovo,hr630-bmc
+              - lenovo,hr855xg2-bmc
+              - portwell,neptune-bmc
+              - qcom,centriq2400-rep-bmc
+              - supermicro,x11spi-bmc
+              - tyan,s7106-bmc
+              - tyan,s8036-bmc
+              - yadro,nicole-bmc
+              - yadro,vegman-n110-bmc
+              - yadro,vegman-rx20-bmc
+              - yadro,vegman-sx20-bmc
+          - const: aspeed,ast2500
+
+      - description: AST2600 based boards
+        items:
+          - enum:
+              - facebook,bletchley-bmc
+              - facebook,cloudripper-bmc
+              - facebook,elbert-bmc
+              - facebook,fuji-bmc
+              - ibm,everest-bmc
+              - ibm,rainier-bmc
+              - ibm,tacoma-bmc
+              - inventec,transformer-bmc
+              - nuvia,dc-scm-bmc
+              - quanta,s6q-bmc
+          - const: aspeed,ast2600
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index c71276d7752e..860017ff41a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1896,6 +1896,7 @@ L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 Q:	https://patchwork.ozlabs.org/project/linux-aspeed/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
+F:	Documentation/devicetree/bindings/arm/aspeed/
 F:	arch/arm/boot/dts/aspeed-*
 F:	arch/arm/mach-aspeed/
 N:	aspeed
-- 
2.34.1

