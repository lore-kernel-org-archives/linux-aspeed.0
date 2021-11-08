From: jae.hyun.yoo@intel.com <jae.hyun.yoo@intel.com>
Date: Mon,  8 Nov 2021 11:01:59 -0800
Subject: [PATCH v3 5/6] dt-bindings: ipmi: aspeed,
 kcs-bmc: add 'clocks' as a required property
In-Reply-To: <20211108190200.290957-1-jae.hyun.yoo@intel.com>
References: <20211108190200.290957-1-jae.hyun.yoo@intel.com>
Message-ID: <20211108190200.290957-6-jae.hyun.yoo@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

If LPC KCS driver is registered ahead of lpc-ctrl module, LPC KCS
hardware block will be enabled without heart beating of LCLK until
lpc-ctrl enables the LCLK. This issue causes improper handling on
host interrupts when the host sends interrupts in that time frame.
Then kernel eventually forcibly disables the interrupt with
dumping stack and printing a 'nobody cared this irq' message out.

To prevent this issue, all LPC sub drivers should enable LCLK
individually so this patch adds 'clocks' property as one of
required properties to enable the LCLK by the LPC KCS driver.

Note: dtsi change in this patch series should be applied along with,
and dtbs should be re-compiled after applying this series since
it's adding a new required property otherwise the driver will not
be probed correctly.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
v2 -> v3:
 * Made commit message more descriptive.

v1 -> v2:
Changes sinve v1:
 * Added 'clocks' property into kcs-bmc bindings using
   'aspeed,ast2400-kcs-bmc.yaml' because it's not merged into
   'aspeed-lpc.yaml' yet. The bindings merging could be done using a
   separate patch later.

 .../devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
index 4ff6fabfcb30..92ec0da047f4 100644
--- a/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
+++ b/Documentation/devicetree/bindings/ipmi/aspeed,ast2400-kcs-bmc.yaml
@@ -71,9 +71,14 @@ properties:
     $ref: '/schemas/types.yaml#/definitions/uint32'
     description: The host CPU IO map address
 
+  clocks:
+    maxItems: 1
+    description: Reference clock for the LPC controller
+
 required:
   - compatible
   - interrupts
+  - clocks
 
 additionalProperties: false
 
@@ -96,6 +101,7 @@ allOf:
 
 examples:
   - |
+    #include <dt-bindings/clock/aspeed-clock.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     kcs3: kcs at 24 {
         compatible = "aspeed,ast2600-kcs-bmc";
@@ -103,4 +109,5 @@ examples:
         aspeed,lpc-io-reg = <0xca2>;
         aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
         interrupts = <8>;
+        clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
     };
-- 
2.25.1

