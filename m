From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Sep 2020 18:17:01 +0930
Subject: [PATCH 1/3] dt-bindings: aspeed: Add silicon id node to SCU
In-Reply-To: <20200916084703.778386-1-joel@jms.id.au>
References: <20200916084703.778386-1-joel@jms.id.au>
Message-ID: <20200916084703.778386-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Different Aspeed families have various unique hardware silicon
identifiers within the SoC.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/mfd/aspeed-scu.txt    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
index 4d92c0bb6687..fff3151f06ee 100644
--- a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
+++ b/Documentation/devicetree/bindings/mfd/aspeed-scu.txt
@@ -20,3 +20,26 @@ syscon: syscon at 1e6e2000 {
 	#clock-cells = <1>;
 	#reset-cells = <1>;
 };
+
+Silicon ID
+-----------------
+
+Families have unique hardware silicon identifiers within the SoC.
+
+Required properties:
+
+ - compatible:		"aspeed,silicon-id" or:
+			"aspeed,ast2400-silicon-id" or
+			"aspeed,ast2501-silicon-id" or
+			"aspeed,ast2600-silicon-id"
+
+ - reg:			offset and length of the silicon id information
+			optionally, a second offset and length describes the unique chip id
+
+Example:
+
+
+silicon-id at 7c {
+        compatible = "aspeed,ast2500-silicon-id", "aspeed,silicon-id";
+        reg = <0x7c 0x4 0x150 0x8>;
+};
-- 
2.28.0

