From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Jun 2024 17:31:41 +0800
Subject: [PATCH v4 1/2] dt-bindings: pinctrl: aspeed,ast2600-pinctrl: add NCSI groups
In-Reply-To: <20240621093142.698529-1-potin.lai.pt@gmail.com>
References: <20240621093142.698529-1-potin.lai.pt@gmail.com>
Message-ID: <20240621093142.698529-2-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
needed on the management controller side.

Add "NCSI" pin groups that are equivalent to the RMII pin groups, but
without the RMIIXRCLKO pin.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml           | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index 00b6974a5ed3d..80974c46f3ef9 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -19,6 +19,11 @@ description: |+
   Refer to the bindings described in
   Documentation/devicetree/bindings/mfd/syscon.yaml
 
+  Note: According to the NCSI specification, the reference clock output pin
+  (RMIIXRCLKO) is not required on the management controller side. To optimize
+  pin usage, add "NCSI" pin groups that are equivalent to the RMII pin groups,
+  but without the RMIIXRCLKO pin.
+
 properties:
   compatible:
     const: aspeed,ast2600-pinctrl
@@ -337,6 +342,8 @@ additionalProperties:
         - MDIO2
         - MDIO3
         - MDIO4
+        - NCSI3
+        - NCSI4
         - NCTS1
         - NCTS2
         - NCTS3
-- 
2.31.1

