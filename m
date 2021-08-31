From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 31 Aug 2021 15:14:45 +0800
Subject: [v5 02/15] dt-bindings: iio: adc: Add ast2600-adc bindings
In-Reply-To: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
Message-ID: <20210831071458.2334-3-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add device tree bindings document for the aspeed ast2600 adc device
driver.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/iio/adc/aspeed,ast2600-adc.yaml  | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
new file mode 100644
index 000000000000..b283c8ca2bbf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADC that forms part of an ASPEED server management processor.
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  ? 10-bits resolution for 16 voltage channels.
+  ? The device split into two individual engine and each contains 8 voltage
+  channels.
+  ? Channel scanning can be non-continuous.
+  ? Programmable ADC clock frequency.
+  ? Programmable upper and lower threshold for each channels.
+  ? Interrupt when larger or less than threshold for each channels.
+  ? Support hysteresis for each channels.
+  ? Built-in a compensating method.
+  ? Built-in a register to trim internal reference voltage.
+  ? Internal or External reference voltage.
+  ? Support 2 Internal reference voltage 1.2v or 2.5v.
+  ? Integrate dividing circuit for battery sensing.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-adc0
+      - aspeed,ast2600-adc1
+    description:
+      Their trimming data, which is used to calibrate internal reference volage,
+      locates in different address of OTP.
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      Input clock used to derive the sample clock. Expected to be the
+      SoC's APB clock.
+
+  resets:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  vref-supply:
+    description:
+      The external regulator supply ADC reference voltage.
+
+  aspeed,int-vref-microvolt:
+    enum: [1200000, 2500000]
+    description:
+      ADC internal reference voltage in microvolts.
+
+  aspeed,battery-sensing:
+    type: boolean
+    description:
+      Inform the driver that last channel will be used to sensor battery.
+
+  aspeed,trim-data-valid:
+    type: boolean
+    description: |
+      The ADC reference voltage can be calibrated to obtain the trimming
+      data which will be stored in otp. This property informs the driver that
+      the data store in the otp is valid.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    adc0: adc at 1e6e9000 {
+        compatible = "aspeed,ast2600-adc0";
+        reg = <0x1e6e9000 0x100>;
+        clocks = <&syscon ASPEED_CLK_APB2>;
+        resets = <&syscon ASPEED_RESET_ADC>;
+        #io-channel-cells = <1>;
+        aspeed,int-vref-microvolt = <2500000>;
+    };
+    adc1: adc at 1e6e9100 {
+        compatible = "aspeed,ast2600-adc1";
+        reg = <0x1e6e9100 0x100>;
+        clocks = <&syscon ASPEED_CLK_APB2>;
+        resets = <&syscon ASPEED_RESET_ADC>;
+        #io-channel-cells = <1>;
+        aspeed,int-vref-microvolt = <2500000>;
+    };
+...
-- 
2.25.1

