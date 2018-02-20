From: Joel Stanley <joel@jms.id.au>
Date: Tue, 20 Feb 2018 12:13:28 +1030
Subject: [PATCH v2 1/3] dt-bindings: aspeed-lpc: Add reset controller
In-Reply-To: <20180220014330.23425-1-joel@jms.id.au>
References: <20180220014330.23425-1-joel@jms.id.au>
Message-ID: <20180220014330.23425-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This describes the reset controller present in the LPC address space.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
V2: Fix spelling mistakes
---
 .../devicetree/bindings/mfd/aspeed-lpc.txt          | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
index 514d82ced95b..9bdd3e8c91ec 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -135,3 +135,24 @@ lhc: lhc at 20 {
 	compatible = "aspeed,ast2500-lhc";
 	reg = <0x20 0x24 0x48 0x8>;
 };
+
+LPC reset control
+-----------------
+
+The UARTs present in the ASPEED SoC can have their resets tied to the reset
+state of the LPC bus. Some systems may chose to modify this configuration.
+
+Required properties:
+
+ - compatible:		"aspeed,ast2500-lpc-reset" or
+ 			"aspeed,ast2400-lpc-reset"
+ - reg:			offset and length of the IP in the LHC memory region
+ - #reset-controller	indicates the number of reset cells expected
+
+Example:
+
+lpc_reset: reset-controller at 18 {
+        compatible = "aspeed,ast2500-lpc-reset";
+        reg = <0x18 0x4>;
+        #reset-cells = <1>;
+};
-- 
2.15.1

