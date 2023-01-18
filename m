From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 18 Jan 2023 18:39:32 +0100
Subject: [PATCH 2/2] spi: dt-bindings: cleanup examples - indentation, lowercase hex
In-Reply-To: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
References: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20230118173932.358153-2-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Cleanup examples:
 - use 4-space indentation (for cases when it is neither 4 not 2 space),
 - drop redundant blank lines,
 - use lowercase hex.

No functional impact except adjusting to preferred coding style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  26 +--
 .../bindings/spi/amlogic,meson6-spifc.yaml    |  22 +--
 .../bindings/spi/aspeed,ast2600-fmc.yaml      |  24 +--
 .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 156 +++++++++---------
 .../bindings/spi/cdns,qspi-nor.yaml           |   4 +-
 .../bindings/spi/nvidia,tegra210-quad.yaml    |  42 ++---
 .../bindings/spi/qcom,spi-qcom-qspi.yaml      |   1 -
 .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--
 .../bindings/spi/spi-sunplus-sp7021.yaml      |   4 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml |   1 -
 10 files changed, 150 insertions(+), 152 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index e5eca3a6f132..4e28e6e9d8e0 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -100,17 +100,17 @@ unevaluatedProperties: false
 examples:
   - |
     spi at c1108d80 {
-          compatible = "amlogic,meson-gx-spicc";
-          reg = <0xc1108d80 0x80>;
-          interrupts = <112>;
-          clocks = <&clk81>;
-          clock-names = "core";
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          display at 0 {
-              compatible = "lg,lg4573";
-              spi-max-frequency = <1000000>;
-              reg = <0>;
-          };
+        compatible = "amlogic,meson-gx-spicc";
+        reg = <0xc1108d80 0x80>;
+        interrupts = <112>;
+        clocks = <&clk81>;
+        clock-names = "core";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display at 0 {
+            compatible = "lg,lg4573";
+            spi-max-frequency = <1000000>;
+            reg = <0>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
index 806043fed4d1..8e769ccda97f 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
@@ -40,15 +40,15 @@ unevaluatedProperties: false
 examples:
   - |
     spi at c1108c80 {
-          compatible = "amlogic,meson6-spifc";
-          reg = <0xc1108c80 0x80>;
-          clocks = <&clk81>;
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          flash: flash at 0 {
-              compatible = "spansion,m25p80", "jedec,spi-nor";
-              reg = <0>;
-              spi-max-frequency = <40000000>;
-          };
+        compatible = "amlogic,meson6-spifc";
+        reg = <0xc1108c80 0x80>;
+        clocks = <&clk81>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash: flash at 0 {
+            compatible = "spansion,m25p80", "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <40000000>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
index aae6fb139b5b..57d932af4506 100644
--- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -60,23 +60,23 @@ examples:
         interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 
         flash at 0 {
-                reg = < 0 >;
-                compatible = "jedec,spi-nor";
-                spi-max-frequency = <50000000>;
-                spi-rx-bus-width = <2>;
+            reg = < 0 >;
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            spi-rx-bus-width = <2>;
         };
 
         flash at 1 {
-                reg = < 1 >;
-                compatible = "jedec,spi-nor";
-                spi-max-frequency = <50000000>;
-                spi-rx-bus-width = <2>;
+            reg = < 1 >;
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            spi-rx-bus-width = <2>;
         };
 
         flash at 2 {
-                reg = < 2 >;
-                compatible = "jedec,spi-nor";
-                spi-max-frequency = <50000000>;
-                spi-rx-bus-width = <2>;
+            reg = < 2 >;
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            spi-rx-bus-width = <2>;
         };
     };
diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
index ec5873919170..28222aae3077 100644
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
@@ -99,98 +99,98 @@ required:
 examples:
   - | # BRCMSTB SoC: SPI Master (MSPI+BSPI) for SPI-NOR access
     spi at f03e3400 {
-            compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi";
-            reg = <0xf03e3400 0x188>, <0xf03e3200 0x50>, <0xf03e0920 0x4>;
-            reg-names = "mspi", "bspi", "cs_reg";
-            interrupts = <0x5>, <0x6>, <0x1>, <0x2>, <0x3>, <0x4>, <0x0>;
-            interrupt-parent = <&gic>;
-            interrupt-names = "mspi_done",
-                              "mspi_halted",
-                              "spi_lr_fullness_reached",
-                              "spi_lr_session_aborted",
-                              "spi_lr_impatient",
-                              "spi_lr_session_done",
-                              "spi_lr_overread";
-            clocks = <&hif_spi>;
-            #address-cells = <0x1>;
-            #size-cells = <0x0>;
-
-            flash at 0 {
-                    #size-cells = <0x2>;
-                    #address-cells = <0x2>;
-                    compatible = "m25p80";
-                    reg = <0x0>;
-                    spi-max-frequency = <0x2625a00>;
-                    spi-cpol;
-                    spi-cpha;
-            };
+        compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi";
+        reg = <0xf03e3400 0x188>, <0xf03e3200 0x50>, <0xf03e0920 0x4>;
+        reg-names = "mspi", "bspi", "cs_reg";
+        interrupts = <0x5>, <0x6>, <0x1>, <0x2>, <0x3>, <0x4>, <0x0>;
+        interrupt-parent = <&gic>;
+        interrupt-names = "mspi_done",
+                          "mspi_halted",
+                          "spi_lr_fullness_reached",
+                          "spi_lr_session_aborted",
+                          "spi_lr_impatient",
+                          "spi_lr_session_done",
+                          "spi_lr_overread";
+        clocks = <&hif_spi>;
+        #address-cells = <0x1>;
+        #size-cells = <0x0>;
+
+        flash at 0 {
+            #size-cells = <0x2>;
+            #address-cells = <0x2>;
+            compatible = "m25p80";
+            reg = <0x0>;
+            spi-max-frequency = <0x2625a00>;
+            spi-cpol;
+            spi-cpha;
+        };
     };
   - | # BRCMSTB SoC: MSPI master for any SPI device
     spi at f0416000 {
-            clocks = <&upg_fixed>;
-            compatible = "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi";
-            reg = <0xf0416000 0x180>;
-            reg-names = "mspi";
-            interrupts = <0x14>;
-            interrupt-parent = <&irq0_aon_intc>;
-            interrupt-names = "mspi_done";
-            #address-cells = <1>;
-            #size-cells = <0>;
+        clocks = <&upg_fixed>;
+        compatible = "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi";
+        reg = <0xf0416000 0x180>;
+        reg-names = "mspi";
+        interrupts = <0x14>;
+        interrupt-parent = <&irq0_aon_intc>;
+        interrupt-names = "mspi_done";
+        #address-cells = <1>;
+        #size-cells = <0>;
     };
   - | # iProc SoC
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     spi at 18027200 {
-            compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
-            reg = <0x18027200 0x184>,
-                  <0x18027000 0x124>,
-                  <0x1811c408 0x004>,
-                  <0x180273a0 0x01c>;
-            reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
-            interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "mspi_done",
-                              "mspi_halted",
-                              "spi_lr_fullness_reached",
-                              "spi_lr_session_aborted",
-                              "spi_lr_impatient",
-                              "spi_lr_session_done";
-            clocks = <&iprocmed>;
-            num-cs = <2>;
-            #address-cells = <1>;
-            #size-cells = <0>;
+        compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
+        reg = <0x18027200 0x184>,
+              <0x18027000 0x124>,
+              <0x1811c408 0x004>,
+              <0x180273a0 0x01c>;
+        reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
+        interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "mspi_done",
+                          "mspi_halted",
+                          "spi_lr_fullness_reached",
+                          "spi_lr_session_aborted",
+                          "spi_lr_impatient",
+                          "spi_lr_session_done";
+        clocks = <&iprocmed>;
+        num-cs = <2>;
+        #address-cells = <1>;
+        #size-cells = <0>;
     };
   - | # NS2 SoC
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     spi at 66470200 {
-            compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
-            reg = <0x66470200 0x184>,
-                  <0x66470000 0x124>,
-                  <0x67017408 0x004>,
-                  <0x664703a0 0x01c>;
-            reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
-            interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "spi_l1_intr";
-            clocks = <&iprocmed>;
-            num-cs = <2>;
+        compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
+        reg = <0x66470200 0x184>,
+              <0x66470000 0x124>,
+              <0x67017408 0x004>,
+              <0x664703a0 0x01c>;
+        reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
+        interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "spi_l1_intr";
+        clocks = <&iprocmed>;
+        num-cs = <2>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash at 0 {
             #address-cells = <1>;
-            #size-cells = <0>;
-
-            flash at 0 {
-                    #address-cells = <1>;
-                    #size-cells = <1>;
-                    compatible = "m25p80";
-                    reg = <0x0>;
-                    spi-max-frequency = <12500000>;
-                    spi-cpol;
-                    spi-cpha;
-            };
+            #size-cells = <1>;
+            compatible = "m25p80";
+            reg = <0x0>;
+            spi-max-frequency = <12500000>;
+            spi-cpol;
+            spi-cpha;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 9be4e2c5d1ee..7606b5a252b6 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -117,7 +117,7 @@ examples:
       reset-names = "qspi", "qspi-ocp";
 
       flash at 0 {
-              compatible = "jedec,spi-nor";
-              reg = <0x0>;
+        compatible = "jedec,spi-nor";
+        reg = <0x0>;
       };
     };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 9f78b2c06494..9ae1611175f2 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -74,25 +74,25 @@ examples:
     #include <dt-bindings/reset/tegra210-car.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     spi at 70410000 {
-            compatible = "nvidia,tegra210-qspi";
-            reg = <0x70410000 0x1000>;
-            interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-            #address-cells = <1>;
-            #size-cells = <0>;
-            clocks = <&tegra_car TEGRA210_CLK_QSPI>,
-                     <&tegra_car TEGRA210_CLK_QSPI_PM>;
-            clock-names = "qspi", "qspi_out";
-            resets = <&tegra_car 211>;
-            dmas = <&apbdma 5>, <&apbdma 5>;
-            dma-names = "rx", "tx";
-
-            flash at 0 {
-                    compatible = "jedec,spi-nor";
-                    reg = <0>;
-                    spi-max-frequency = <104000000>;
-                    spi-tx-bus-width = <2>;
-                    spi-rx-bus-width = <2>;
-                    nvidia,tx-clk-tap-delay = <0>;
-                    nvidia,rx-clk-tap-delay = <0>;
-            };
+        compatible = "nvidia,tegra210-qspi";
+        reg = <0x70410000 0x1000>;
+        interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&tegra_car TEGRA210_CLK_QSPI>,
+                 <&tegra_car TEGRA210_CLK_QSPI_PM>;
+        clock-names = "qspi", "qspi_out";
+        resets = <&tegra_car 211>;
+        dmas = <&apbdma 5>, <&apbdma 5>;
+        dma-names = "rx", "tx";
+
+        flash at 0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <104000000>;
+            spi-tx-bus-width = <2>;
+            spi-rx-bus-width = <2>;
+            nvidia,tx-clk-tap-delay = <0>;
+            nvidia,rx-clk-tap-delay = <0>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index 85e7770703bd..e94d915e28c8 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -87,7 +87,6 @@ examples:
                 spi-tx-bus-width = <2>;
                 spi-rx-bus-width = <2>;
             };
-
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
index f45d3b75d6de..4d8ec69214c9 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -141,15 +141,15 @@ examples:
     #include <dt-bindings/power/r8a7791-sysc.h>
 
     qspi: spi at e6b10000 {
-            compatible = "renesas,qspi-r8a7791", "renesas,qspi";
-            reg = <0xe6b10000 0x2c>;
-            interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&cpg CPG_MOD 917>;
-            dmas = <&dmac0 0x17>, <&dmac0 0x18>, <&dmac1 0x17>, <&dmac1 0x18>;
-            dma-names = "tx", "rx", "tx", "rx";
-            power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
-            resets = <&cpg 917>;
-            num-cs = <1>;
-            #address-cells = <1>;
-            #size-cells = <0>;
+        compatible = "renesas,qspi-r8a7791", "renesas,qspi";
+        reg = <0xe6b10000 0x2c>;
+        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD 917>;
+        dmas = <&dmac0 0x17>, <&dmac0 0x18>, <&dmac1 0x17>, <&dmac1 0x18>;
+        dma-names = "tx", "rx", "tx", "rx";
+        power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+        resets = <&cpg 917>;
+        num-cs = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
     };
diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
index 69a463305274..edb5ba71af3a 100644
--- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -59,9 +59,9 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi at 9C002D80 {
+    spi at 9c002d80 {
         compatible = "sunplus,sp7021-spi";
-        reg = <0x9C002D80 0x80>, <0x9C002E00 0x80>;
+        reg = <0x9c002d80 0x80>, <0x9c002e00 0x80>;
         reg-names = "master", "slave";
         interrupt-parent = <&intc>;
         interrupt-names = "dma_w",
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index d35c6f7e2dd5..18afdaab946d 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -95,7 +95,6 @@ examples:
              <&dmamux1 1 40 0x400 0x05>;
       dma-names = "rx", "tx";
       cs-gpios = <&gpioa 11 0>;
-
     };
 
 ...
-- 
2.34.1

