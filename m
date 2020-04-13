From: Ernesto Corona <ernesto.corona@intel.com>
Date: Mon, 13 Apr 2020 15:29:16 -0700
Subject: [PATCH v29 2/6]  dt-binding: jtag: Aspeed 2400 and 2500 series
In-Reply-To: <20200413222920.4722-1-ernesto.corona@intel.com>
References: <20200413222920.4722-1-ernesto.corona@intel.com>
Message-ID: <20200413222920.4722-3-ernesto.corona@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Aspeed AST2400 and AST2500 JTAG master controller driver.

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
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
Cc: Rgrs <rgrs@protonmail.com>
---
v28->v29
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
- add reset descriptions in bndings file

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
  bndings file

v2->v3
Comments pointed by Rob Herring <robh@kernel.org>
- split Aspeed jtag driver and binding to sepatrate patches
- delete unnecessary "status" and "reg-shift" descriptions in
  bindings file
---
 .../devicetree/bindings/jtag/aspeed-jtag.yaml | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml

diff --git a/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
new file mode 100644
index 000000000000..cdcd872c38c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/jtag/aspeed-jtag.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/jtag/aspeed-jtag.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed JTAG driver for ast2400 and ast2500 SoC
+
+description:
+  Driver adds support of Aspeed 2500/2400 series SOC JTAG master controller.
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
+maintainers:
+  - Oleksandr Shamray <oleksandrs@mellanox.com>
+  - Jiri Pirko <jiri@mellanox.com>
+  - Ernesto Corona<ernesto.corona@intel.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - aspeed,ast2400-jtag
+              - aspeed,ast2500-jtag
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
+
+...
-- 
2.17.1

