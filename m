From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 29 May 2024 14:43:21 +0930
Subject: [PATCH 2/4] dt-bindings: gpio: aspeed,sgpio: Specify
 gpio-line-names
In-Reply-To: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
References: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-0-91c42976833b@codeconstruct.com.au>
Message-ID: <20240529-dt-warnings-gpio-sgpio-interrupt-cells-v1-2-91c42976833b@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some devicetrees specify gpio-line-names in the sgpio node despite it
not being defined by the binding. It's a reasonable thing to do, so
define the property to squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dtb: sgpio at 1e780200: 'gpio-line-names' does not match any of the regexes: 'pinctrl-[0-9]+'
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
index 6b15a3a3fb66..fe27b5d01e80 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
@@ -33,6 +33,11 @@ properties:
 
   gpio-controller: true
 
+  # Each SGPIO is represented as a pair of input and output GPIOs
+  gpio-line-names:
+    minItems: 160
+    maxItems: 256
+
   '#gpio-cells':
     const: 2
 

-- 
2.39.2

