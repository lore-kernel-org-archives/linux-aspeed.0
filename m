From: Tao Ren <taoren@fb.com>
Date: Wed, 19 Jun 2019 13:50:18 -0700
Subject: [PATCH 2/2] dt-bindings: i2c: aspeed: add base-clock-divisor property
Message-ID: <20190619205018.4177192-1-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"base-clock-divisor" allows people to customize ASPEED I2C Controller's
Base Clock, which in turn adjusts all other I2C AC timing settings.

Signed-off-by: Tao Ren <taoren@fb.com>
---
 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
index 8fbd8633a387..0c08df847c6f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
@@ -13,9 +13,11 @@ Required Properties:
 - interrupts		: interrupt number
 
 Optional Properties:
-- bus-frequency	: frequency of the bus clock in Hz defaults to 100 kHz when not
-		  specified
-- multi-master	: states that there is another master active on this bus.
+- bus-frequency		: frequency of the bus clock in Hz defaults to 100 kHz
+			  when not specified
+- multi-master		: states that there is another master active on this bus.
+- base-clock-divisor	: the divisor defines the frequency of Base Clock which
+			  is divided from APB bus clock. Valid values are 0-15.
 
 Example:
 
-- 
2.17.1

