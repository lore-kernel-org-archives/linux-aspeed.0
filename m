From: Rob Herring <robh@kernel.org>
Date: Mon,  6 Dec 2021 11:42:37 -0600
Subject: [PATCH] dt-bindings: i2c: aspeed: Drop stray '#interrupt-cells'
Message-ID: <20211206174237.2298580-1-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

'#interrupt-cells' is not documented which causes a warning when
'unevaluatedProperties' is implemented. Unless the I2C controller is
also an interrupt controller, '#interrupt-cells' is not valid. This
doesn't appear to be the case from the driver, so just remove it from
the example.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>
Cc: Rayn Chen <rayn_chen@aspeedtech.com>
Cc: linux-i2c at vger.kernel.org
Cc: openbmc at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-aspeed at lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
index ea643e6c3ef5..f597f73ccd87 100644
--- a/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml
@@ -63,7 +63,6 @@ examples:
     i2c0: i2c-bus at 40 {
       #address-cells = <1>;
       #size-cells = <0>;
-      #interrupt-cells = <1>;
       compatible = "aspeed,ast2500-i2c-bus";
       reg = <0x40 0x40>;
       clocks = <&syscon ASPEED_CLK_APB>;
-- 
2.32.0

