From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 30 May 2024 11:09:49 +0930
Subject: [PATCH v2 2/2] dt-bindings: gpio: aspeed,sgpio: Specify
 #interrupt-cells
In-Reply-To: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-0-912cd16e641f@codeconstruct.com.au>
References: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-0-912cd16e641f@codeconstruct.com.au>
Message-ID: <20240530-dt-warnings-gpio-sgpio-interrupt-cells-v2-2-912cd16e641f@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Squash warnings such as:

    arch/arm/boot/dts/aspeed/aspeed-ast2500-evb.dtb: sgpio at 1e780200: '#interrupt-cells' does not match any of the regexes: 'pinctrl-[0-9]+'

Also, mark #interrupt-cells as required. The kernel devicetrees already
specified it where compatible nodes were defined, and u-boot pulls in
the kernel devicetrees, so this should have minimal practical impact.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
index 34cdf1ad9c73..1046f0331c09 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
@@ -46,6 +46,9 @@ properties:
 
   interrupt-controller: true
 
+  '#interrupt-cells':
+    const: 2
+
   clocks:
     maxItems: 1
 
@@ -60,6 +63,7 @@ required:
   - '#gpio-cells'
   - interrupts
   - interrupt-controller
+  - '#interrupt-cells'
   - ngpios
   - clocks
   - bus-frequency
@@ -77,6 +81,7 @@ examples:
         reg = <0x1e780200 0x0100>;
         clocks = <&syscon ASPEED_CLK_APB>;
         interrupt-controller;
+        #interrupt-cells = <2>;
         ngpios = <80>;
         bus-frequency = <12000000>;
     };

-- 
2.39.2

