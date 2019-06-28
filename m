From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 28 Jun 2019 12:08:32 +0930
Subject: [PATCH v2 2/8] dt-bindings: pinctrl: aspeed: Convert AST2400 bindings
 to json-schema
In-Reply-To: <20190628023838.15426-1-andrew@aj.id.au>
References: <20190628023838.15426-1-andrew@aj.id.au>
Message-ID: <20190628023838.15426-3-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Convert ASPEED pinctrl bindings to DT schema format using json-schema

Cc: Johnny Huang <johnny_huang@aspeedtech.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
In v2:

* Enforce function/group names in bindings
* Move description above properties
* Simplify specification of compatible
* Cleanup license specification

 .../pinctrl/aspeed,ast2400-pinctrl.txt        | 80 ------------------
 .../pinctrl/aspeed,ast2400-pinctrl.yaml       | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 80 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
deleted file mode 100644
index 67e0325ccf2e..000000000000
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.txt
+++ /dev/null
@@ -1,80 +0,0 @@
-=============================
-Aspeed AST2400 Pin Controller
-=============================
-
-Required properties for the AST2400:
-- compatible : 			Should be one of the following:
-				"aspeed,ast2400-pinctrl"
-				"aspeed,g4-pinctrl"
-
-The pin controller node should be the child of a syscon node with the required
-property:
-
-- compatible : 		Should be one of the following:
-			"aspeed,ast2400-scu", "syscon", "simple-mfd"
-			"aspeed,g4-scu", "syscon", "simple-mfd"
-
-Refer to the the bindings described in
-Documentation/devicetree/bindings/mfd/syscon.txt
-
-Subnode Format
-==============
-
-The required properties of pinmux child nodes are:
-- function: the mux function to select
-- groups  : the list of groups to select with this function
-
-Required properties of pinconf child nodes are:
-- groups: A list of groups to select (either this or "pins" must be
-          specified)
-- pins  : A list of ball names as strings, eg "D14" (either this or "groups"
-          must be specified)
-
-Optional properties of pinconf child nodes are:
-- bias-disable  : disable any pin bias
-- bias-pull-down: pull down the pin
-- drive-strength: sink or source at most X mA
-
-Definitions are as specified in
-Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt, with any
-further limitations as described above.
-
-For pinmux, each mux function has only one associated pin group. Each group is
-named by its function. The following values for the function and groups
-properties are supported:
-
-ACPI ADC0 ADC1 ADC10 ADC11 ADC12 ADC13 ADC14 ADC15 ADC2 ADC3 ADC4 ADC5 ADC6
-ADC7 ADC8 ADC9 BMCINT DDCCLK DDCDAT EXTRST FLACK FLBUSY FLWP GPID GPID0 GPID2
-GPID4 GPID6 GPIE0 GPIE2 GPIE4 GPIE6 I2C10 I2C11 I2C12 I2C13 I2C14 I2C3 I2C4
-I2C5 I2C6 I2C7 I2C8 I2C9 LPCPD LPCPME LPCRST LPCSMI MAC1LINK MAC2LINK MDIO1
-MDIO2 NCTS1 NCTS2 NCTS3 NCTS4 NDCD1 NDCD2 NDCD3 NDCD4 NDSR1 NDSR2 NDSR3 NDSR4
-NDTR1 NDTR2 NDTR3 NDTR4 NDTS4 NRI1 NRI2 NRI3 NRI4 NRTS1 NRTS2 NRTS3 OSCCLK PWM0
-PWM1 PWM2 PWM3 PWM4 PWM5 PWM6 PWM7 RGMII1 RGMII2 RMII1 RMII2 ROM16 ROM8 ROMCS1
-ROMCS2 ROMCS3 ROMCS4 RXD1 RXD2 RXD3 RXD4 SALT1 SALT2 SALT3 SALT4 SD1 SD2 SGPMCK
-SGPMI SGPMLD SGPMO SGPSCK SGPSI0 SGPSI1 SGPSLD SIOONCTRL SIOPBI SIOPBO SIOPWREQ
-SIOPWRGD SIOS3 SIOS5 SIOSCI SPI1 SPI1DEBUG SPI1PASSTHRU SPICS1 TIMER3 TIMER4
-TIMER5 TIMER6 TIMER7 TIMER8 TXD1 TXD2 TXD3 TXD4 UART6 USB11D1 USB11H2 USB2D1
-USB2H1 USBCKI VGABIOS_ROM VGAHS VGAVS VPI18 VPI24 VPI30 VPO12 VPO24 WDTRST1
-WDTRST2
-
-Example
-=======
-
-syscon: scu at 1e6e2000 {
-	compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
-	reg = <0x1e6e2000 0x1a8>;
-
-	pinctrl: pinctrl {
-		compatible = "aspeed,g4-pinctrl";
-
-		pinctrl_i2c3_default: i2c3_default {
-			function = "I2C3";
-			groups = "I2C3";
-		};
-
-		pinctrl_gpioh0_unbiased_default: gpioh0 {
-			pins = "A8";
-			bias-disable;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
new file mode 100644
index 000000000000..61a110a7db8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/aspeed,ast2400-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2400 Pin Controller
+
+maintainers:
+  - Andrew Jeffery <andrew@aj.id.au>
+
+description: |+
+  The pin controller node should be the child of a syscon node with the
+  required property:
+
+  - compatible:     Should be one of the following:
+                    "aspeed,ast2400-scu", "syscon", "simple-mfd"
+                    "aspeed,g4-scu", "syscon", "simple-mfd"
+
+  Refer to the the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.txt
+
+properties:
+  compatible:
+    enum: [ aspeed,ast2400-pinctrl, aspeed,g4-pinctrl ]
+
+patternProperties:
+  '^.*$':
+    if:
+      type: object
+    then:
+      patternProperties:
+        "^function|groups$":
+          allOf:
+            - $ref: "/schemas/types.yaml#/definitions/string"
+            - enum: [ "ACPI", "ADC0", "ADC1", "ADC10", "ADC11", "ADC12", "ADC13",
+              "ADC14", "ADC15", "ADC2", "ADC3", "ADC4", "ADC5", "ADC6", "ADC7",
+              "ADC8", "ADC9", "BMCINT", "DDCCLK", "DDCDAT", "EXTRST", "FLACK",
+              "FLBUSY", "FLWP", "GPID", "GPID0", "GPID2", "GPID4", "GPID6",
+              "GPIE0", "GPIE2", "GPIE4", "GPIE6", "I2C10", "I2C11", "I2C12",
+              "I2C13", "I2C14", "I2C3", "I2C4", "I2C5", "I2C6", "I2C7", "I2C8",
+              "I2C9", "LPCPD", "LPCPME", "LPCRST", "LPCSMI", "MAC1LINK",
+              "MAC2LINK", "MDIO1", "MDIO2", "NCTS1", "NCTS2", "NCTS3", "NCTS4",
+              "NDCD1", "NDCD2", "NDCD3", "NDCD4", "NDSR1", "NDSR2", "NDSR3",
+              "NDSR4", "NDTR1", "NDTR2", "NDTR3", "NDTR4", "NDTS4", "NRI1",
+              "NRI2", "NRI3", "NRI4", "NRTS1", "NRTS2", "NRTS3", "OSCCLK",
+              "PWM0", "PWM1", "PWM2", "PWM3", "PWM4", "PWM5", "PWM6", "PWM7",
+              "RGMII1", "RGMII2", "RMII1", "RMII2", "ROM16", "ROM8", "ROMCS1",
+              "ROMCS2", "ROMCS3", "ROMCS4", "RXD1", "RXD2", "RXD3", "RXD4",
+              "SALT1", "SALT2", "SALT3", "SALT4", "SD1", "SD2", "SGPMCK",
+              "SGPMI", "SGPMLD", "SGPMO", "SGPSCK", "SGPSI0", "SGPSI1", "SGPSLD",
+              "SIOONCTRL", "SIOPBI", "SIOPBO", "SIOPWREQ", "SIOPWRGD", "SIOS3",
+              "SIOS5", "SIOSCI", "SPI1", "SPI1DEBUG", "SPI1PASSTHRU", "SPICS1",
+              "TIMER3", "TIMER4", "TIMER5", "TIMER6", "TIMER7", "TIMER8", "TXD1",
+              "TXD2", "TXD3", "TXD4", "UART6", "USB11D1", "USB11H2", "USB2D1",
+              "USB2H1", "USBCKI", "VGABIOS_ROM", "VGAHS", "VGAVS", "VPI18",
+              "VPI24", "VPI30", "VPO12", "VPO24", "WDTRST1", "WDTRST2" ]
+
+required:
+  - compatible
+
+examples:
+  - |
+    syscon: scu at 1e6e2000 {
+        compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
+        reg = <0x1e6e2000 0x1a8>;
+
+        pinctrl: pinctrl {
+            compatible = "aspeed,g4-pinctrl";
+
+            pinctrl_i2c3_default: i2c3_default {
+                function = "I2C3";
+                groups = "I2C3";
+            };
+
+            pinctrl_gpioh0_unbiased_default: gpioh0 {
+                pins = "A8";
+                bias-disable;
+            };
+        };
+    };
-- 
2.20.1

