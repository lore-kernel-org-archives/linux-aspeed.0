From: Steven Lee <steven_lee@aspeedtech.com>
Date: Mon, 7 Jun 2021 15:15:07 +0800
Subject: [PATCH v4 2/7] dt-bindings: aspeed-sgpio: Add ast2600 sgpio
 compatibles.
In-Reply-To: <20210607071514.11727-1-steven_lee@aspeedtech.com>
References: <20210607071514.11727-1-steven_lee@aspeedtech.com>
Message-ID: <20210607071514.11727-3-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
with 80 pins. Add ast2600-sgpiom0-80 and ast2600-sgpiom-128 compatibles
and update descriptions to introduce the max number of available gpio
pins that AST2600 supported.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
index b2ae211411ff..0e42eded3c1e 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,sgpio.yaml
@@ -10,9 +10,10 @@ maintainers:
   - Andrew Jeffery <andrew@aj.id.au>
 
 description:
-  This SGPIO controller is for ASPEED AST2500 SoC, it supports up to 80 full
-  featured Serial GPIOs. Each of the Serial GPIO pins can be programmed to
-  support the following options
+  This SGPIO controller is for ASPEED AST2400, AST2500 and AST2600 SoC,
+  AST2600 have two sgpio master one with 128 pins another one with 80 pins,
+  AST2500/AST2400 have one sgpio master with 80 pins. Each of the Serial
+  GPIO pins can be programmed to support the following options
   - Support interrupt option for each input port and various interrupt
     sensitivity option (level-high, level-low, edge-high, edge-low)
   - Support reset tolerance option for each output port
@@ -25,6 +26,8 @@ properties:
     enum:
       - aspeed,ast2400-sgpio
       - aspeed,ast2500-sgpio
+      - aspeed,ast2600-sgpiom-80
+      - aspeed,ast2600-sgpiom-128
 
   reg:
     maxItems: 1
-- 
2.17.1

