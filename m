From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed,  8 Jun 2022 00:37:03 +0800
Subject: [PATCH v3 2/2] dt-bindings: aspeed-i2c: add properties for setting i2c clock duty cycle
In-Reply-To: <20220607163703.26355-1-potin.lai.pt@gmail.com>
References: <20220607163703.26355-1-potin.lai.pt@gmail.com>
Message-ID: <20220607163703.26355-3-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce a new property for setting a minimum duty cycle for clock high.

* i2c-clk-duty-cycle-min: a minimum percentage of clock high

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
index ea643e6c3ef5..af4c49111cc0 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
@@ -49,6 +49,14 @@ properties:
     description:
       states that there is another master active on this bus
 
+  i2c-clk-duty-cycle-min:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 100
+    default: 50
+    description:
+      a minimum percentage of clock high
+
 required:
   - reg
   - compatible
-- 
2.17.1

