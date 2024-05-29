From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 29 May 2024 14:43:22 +0930
Subject: [PATCH 3/4] dt-bindings: gpio: aspeed,sgpio: Specify
 #interrupt-cells
In-Reply-To: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
References: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
Message-ID: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-3-91c42976833b@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Squash warnings such as:

```
/home/andrew/src/kernel.org/linux/build.aspeed_g5/arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: sgpio at 1e780200: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
index fe27b5d01e80..02c02ef97565 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
@@ -46,6 +46,9 @@ properties:
 
   interrupt-controller: true
 
+  '#interrupt-cells':
+    const: 2
+
   clocks:
     maxItems: 1
 
@@ -75,6 +78,7 @@ examples:
         clocks = <&syscon ASPEED_CLK_APB>;
         interrupts = <40>;
         interrupt-controller;
+        #interrupt-cells = <2>;
         gpio-controller;
         #gpio-cells = <2>;
         ngpios = <80>;

-- 
2.39.2

