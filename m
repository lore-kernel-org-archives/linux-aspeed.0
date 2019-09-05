From: Rashmica Gupta <rashmica.g@gmail.com>
Date: Thu,  5 Sep 2019 11:18:00 +1000
Subject: [PATCH v2 4/4] gpio: dt-bindings: Update documentation with ast2600
 controllers
Message-ID: <20190905011800.16156-1-rashmica.g@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ast2600 is a new generation of SoC from ASPEED. Similarly to the
ast2400 and ast2500, it has a GPIO controller for it's 3.6V GPIO pins.
Additionally, it has a GPIO controller for 36 1.8V GPIO pins. These
voltages are fixed and cannot be configured via pinconf, so we have two
separate drivers for them.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
index 7e9b586770b0..cd388797e07c 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
@@ -2,7 +2,8 @@ Aspeed GPIO controller Device Tree Bindings
 -------------------------------------------
 
 Required properties:
-- compatible		: Either "aspeed,ast2400-gpio" or "aspeed,ast2500-gpio"
+- compatible		: Either "aspeed,ast2400-gpio", "aspeed,ast2500-gpio",
+					  "aspeed,ast2600-gpio", or "aspeed,ast2600-1-8v-gpio"
 
 - #gpio-cells 		: Should be two
 			  - First cell is the GPIO line number
-- 
2.20.1

