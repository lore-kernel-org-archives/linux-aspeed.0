From: Corona, Ernesto <ernesto.corona@intel.com>
Date: Tue, 30 Jan 2024 23:30:10 +0000
Subject: [PATCH 30 2/7] Add binding for Aspeed SOC
Message-ID: <LV8PR11MB8463D0017B82135324127DB98B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aspeed AST2400, AST2500 and AST2600 JTAG controller driver.

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Luke Chen <luke_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Rgrs <rgrs@protonmail.com>
---
v29->v30
Comments pointed by Steven Filary <steven.a.filary@intel.com>
- Add Suport for 26xx series

v28->v29
Comments pointed by Ernesto Corona <ernesto.corona@intel.com>
- Change documentation to the new dt-bindings yaml format.

v27->v28
v26->v27
v25->v26
v24->v25
v23->v24
v22->v23
v21->v22
v20->v21
v19->v20
v18->v19

v17->v18
v16->v17
v15->v16
Comments pointed by Joel Stanley <joel.stan@gmail.com>
- change clocks = <&clk_apb> to proper clocks = <&syscon ASPEED_CLK_APB>
- add reset descriptions in bindings file

v14->v15
v13->v14
v12->v13
v11->v12
v10->v11
v9->v10
v8->v9
v7->v8
Comments pointed by pointed by Joel Stanley <joel.stan@gmail.com>
- Change compatible string to ast2400 and ast2000

V6->v7
Comments pointed by Tobias Klauser <tklauser@distanz.ch>
 - Fix spell "Doccumentation" -> "Documentation"

v5->v6
Comments pointed by Tobias Klauser <tklauser@distanz.ch>
- Small nit: s/documentation/Documentation/

v4->v5

V3->v4
Comments pointed by Rob Herring <robh@kernel.org>
- delete unnecessary "status" and "reg-shift" descriptions in
  bindings file

v2->v3
Comments pointed by Rob Herring <robh@kernel.org>
- split Aspeed jtag driver and binding to separate patches
- delete unnecessary "status" and "reg-shift" descriptions in
  bindings file
---
 .../devicetree/bindings/jtag/aspeed-jtag.yaml | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml

diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
new file mode 100644
index 000000000000..1a412e83b81b
--- /dev/null
+++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/jtag/aspeed-jtag.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed JTAG driver for ast2400, ast2500 and ast2600 SoC
+
+description:
+  Driver adds support of Aspeed 24/25/2600 series SOC JTAG controller.
+  Driver implements the following jtag ops
+    freq_get
+    freq_set
+    status_get
+    status_set
+    xfer
+    mode_set
+    bitbang
+    enable
+    disable
+
+  It has been tested on Mellanox system with BMC equipped with
+  Aspeed 2520 SoC for programming CPLD devices.
+
+  It has also been tested on Intel system using Aspeed 25xx SoC
+  for JTAG communication.
+
+  Tested on Intel system using Aspeed 26xx SoC for JTAG communication.
+
+maintainers:
+  - Oleksandr Shamray <oleksandrs@mellanox.com>
+  - Jiri Pirko <jiri@nvidia.com>
+  - Ernesto Corona<ernesto.corona@intel.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - aspeed,ast2400-jtag
+              - aspeed,ast2500-jtag
+              - aspeed,ast2600-jtag
+
+
+  reg:
+    items:
+      - description: JTAG Master controller register range
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+      jtag: jtag at 1e6e4000 {
+          compatible = "aspeed,ast2500-jtag";
+          reg = <0x1e6e4000 0x1c>;
+          clocks = <&syscon ASPEED_CLK_APB>;
+          resets = <&syscon ASPEED_RESET_JTAG_MASTER>;
+          interrupts = <43>;
+      };
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+      jtag1: jtag at 1e6e4100 {
+          compatible = "aspeed,ast2600-jtag";
+          reg = <0x1e6e4100 0x40>;
+          clocks = <&syscon ASPEED_CLK_APB1>;
+          resets = <&syscon ASPEED_RESET_JTAG_MASTER2>;
+          interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+      };
+
+...
-- 
2.25.1
