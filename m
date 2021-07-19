From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 19 Jul 2021 16:06:02 +0800
Subject: [v1 2/7] dt-bindings: iio: adc: Binding ast2600 adc.
In-Reply-To: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
References: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
Message-ID: <20210719080607.28712-3-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch add more description about aspeed adc and add vref property
for ast2600 to configure it reference voltage.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/iio/adc/aspeed,adc.yaml          | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
index 7f534a933e92..67ff0b5c7ef2 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
@@ -10,14 +10,26 @@ maintainers:
   - Joel Stanley <joel@jms.id.au>
 
 description:
-  This device is a 10-bit converter for 16 voltage channels.  All inputs are
-  single ended.
+  ? 10-bits resolution for 16 voltage channels.
+  At ast2400/ast2500 the device has only one engine with 16 voltage channels.
+  At ast2600 the device split into two individual engine and each contains 8 voltage channels.
+  ? Channel scanning can be non-continuous.
+  ? Programmable ADC clock frequency.
+  ? Programmable upper and lower bound for each channels.
+  ? Interrupt when larger or less than bounds for each channels.
+  ? Support hysteresis for each channels.
+  ? Buildin a compensating method.
+  Additional feature at ast2600
+  ? Internal or External reference voltage.
+  ? Support 2 Internal reference voltage 1.2v or 2.5v.
+  ? Integrate dividing circuit for battery sensing.
 
 properties:
   compatible:
     enum:
       - aspeed,ast2400-adc
       - aspeed,ast2500-adc
+      - aspeed,ast2600-adc
 
   reg:
     maxItems: 1
@@ -33,6 +45,13 @@ properties:
   "#io-channel-cells":
     const: 1
 
+  vref:
+    minItems: 900
+    maxItems: 2700
+    default: 2500
+    description:
+      ADC Reference voltage in millivolts (only work at ast2600)
+
 required:
   - compatible
   - reg
-- 
2.25.1

