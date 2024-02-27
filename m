From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 27 Feb 2024 15:53:53 +1030
Subject: [PATCH v5] dt-bindings: gpio: aspeed,ast2400-gpio: Convert to DT schema
Message-ID: <20240227052353.1060306-1-andrew@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/apb at 1e600000/gpio at 1e780000: failed to match any schema with compatible: ['aspeed,ast2400-gpio']
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
v5: Resolve macro definition clashes from aspeed clock headers in examples
    identified by Rob's bot:

    https://lore.kernel.org/all/170900020204.2360855.790404478830111761.robh at kernel.org/

    Clearly I missed running `make dt_binding_check` on the final iteration of
    the v4 patch I sent. Hopefully I'm running out of rakes to step on here!

v4: https://lore.kernel.org/all/20240227004414.841391-1-andrew at codeconstruct.com.au/

    Add constraints for gpio-line-names, ngpios as requested by Krzysztof:
    https://lore.kernel.org/all/458becdb-fb1e-4808-87b6-3037ec945647 at linaro.org/

    Add more examples to exercise constraints.

v3: https://lore.kernel.org/all/20240226051645.414935-1-andrew at codeconstruct.com.au/

    Base on v6.8-rc6, fix yamllint warning

    Rob's bot picked the missing `#interrupt-cells` in the example on v2[1]. The
    patch was based on v6.8-rc1, and going back over my shell history I missed
    the following output from `make dt_binding_check`:

    ```
    ...
      LINT    Documentation/devicetree/bindings
      usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR ...]
      yamllint: error: one of the arguments FILE_OR_DIR - is required   
    ...
    ```

    I've rebased on v6.8-rc6 and no-longer see the issue with the invocation
    of `yamllint`.

[1]: https://lore.kernel.org/all/170892197611.2260479.15343562563553959436.robh at kernel.org/

v2: https://lore.kernel.org/all/20240226031951.284847-1-andrew at codeconstruct.com.au/

    Address feedback from Krzysztof:
    https://lore.kernel.org/all/0d1dd262-b6dd-4d71-9239-8b0aec8cceff at linaro.org/

v1: https://lore.kernel.org/all/20240220052918.742793-1-andrew at codeconstruct.com.au/

 .../bindings/gpio/aspeed,ast2400-gpio.yaml    | 143 ++++++++++++++++++
 .../devicetree/bindings/gpio/gpio-aspeed.txt  |  39 -----
 2 files changed, 143 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
new file mode 100644
index 000000000000..1aa28b1817cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed GPIO controller
+
+maintainers:
+  - Andrew Jeffery <andrew@codeconstruct.com.au>
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2400-gpio
+      - aspeed,ast2500-gpio
+      - aspeed,ast2600-gpio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: The clock to use for debounce timings
+
+  gpio-controller: true
+  gpio-line-names: true
+  gpio-ranges: true
+
+  "#gpio-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  ngpios: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+  - gpio-controller
+  - "#gpio-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2400-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 220
+          maxItems: 220
+        ngpios:
+          const: 220
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2500-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 232
+          maxItems: 232
+        ngpios:
+          const: 232
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: aspeed,ast2600-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 36
+          maxItems: 208
+        ngpios:
+          enum: [ 36, 208 ]
+      required:
+        - ngpios
+
+additionalProperties: false
+
+examples:
+  - |
+    gpio at 1e780000 {
+        compatible = "aspeed,ast2400-gpio";
+        reg = <0x1e780000 0x1000>;
+        interrupts = <20>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
+  - |
+    gpio: gpio at 1e780000 {
+        compatible = "aspeed,ast2500-gpio";
+        reg = <0x1e780000 0x200>;
+        interrupts = <20>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&pinctrl 0 0 232>;
+    };
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    gpio0: gpio at 1e780000 {
+        compatible = "aspeed,ast2600-gpio";
+        reg = <0x1e780000 0x400>;
+        clocks = <&syscon ASPEED_CLK_APB2>;
+        interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        #gpio-cells = <2>;
+        gpio-controller;
+        gpio-ranges = <&pinctrl 0 0 208>;
+        ngpios = <208>;
+    };
+    gpio1: gpio at 1e780800 {
+        compatible = "aspeed,ast2600-gpio";
+        reg = <0x1e780800 0x800>;
+        clocks = <&syscon ASPEED_CLK_APB1>;
+        interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&pinctrl 0 208 36>;
+        ngpios = <36>;
+    };
diff --git a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
deleted file mode 100644
index b2033fc3a71a..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-Aspeed GPIO controller Device Tree Bindings
--------------------------------------------
-
-Required properties:
-- compatible		: Either "aspeed,ast2400-gpio", "aspeed,ast2500-gpio",
-					or "aspeed,ast2600-gpio".
-
-- #gpio-cells 		: Should be two
-			  - First cell is the GPIO line number
-			  - Second cell is used to specify optional
-			    parameters (unused)
-
-- reg			: Address and length of the register set for the device
-- gpio-controller	: Marks the device node as a GPIO controller.
-- interrupts		: Interrupt specifier (see interrupt bindings for
-			  details)
-- interrupt-controller	: Mark the GPIO controller as an interrupt-controller
-
-Optional properties:
-
-- clocks		: A phandle to the clock to use for debounce timings
-- ngpios		: Number of GPIOs controlled by this controller. Should	be set
-				  when there are multiple GPIO controllers on a SoC (ast2600).
-
-The gpio and interrupt properties are further described in their respective
-bindings documentation:
-
-- Documentation/devicetree/bindings/gpio/gpio.txt
-- Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-
-  Example:
-	gpio at 1e780000 {
-		#gpio-cells = <2>;
-		compatible = "aspeed,ast2400-gpio";
-		gpio-controller;
-		interrupts = <20>;
-		reg = <0x1e780000 0x1000>;
-		interrupt-controller;
-	};

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.39.2

