From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  4 Oct 2019 13:59:14 +0200
Subject: [PATCH 11/16] dt-bindings: mtd: aspeed-smc: Add new comptatible for
 AST2600
In-Reply-To: <20191004115919.20788-1-clg@kaod.org>
References: <20191004115919.20788-1-clg@kaod.org>
Message-ID: <20191004115919.20788-12-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The SMC controllers on the AST2600 SoC are very similar to the the
AST2500. The SoC has one Firmware Memory Controller and two SPI flash
memory controllers.

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 Documentation/devicetree/bindings/mtd/aspeed-smc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/aspeed-smc.txt b/Documentation/devicetree/bindings/mtd/aspeed-smc.txt
index 49f6528ef547..c2373d9cfd90 100644
--- a/Documentation/devicetree/bindings/mtd/aspeed-smc.txt
+++ b/Documentation/devicetree/bindings/mtd/aspeed-smc.txt
@@ -14,6 +14,8 @@ Required properties:
 	"aspeed,ast2400-spi" for the AST2400 SPI Flash memory Controller
 	"aspeed,ast2500-fmc" for the AST2500 Firmware Memory Controller
 	"aspeed,ast2500-spi" for the AST2500 SPI flash memory controllers
+	"aspeed,ast2600-fmc" for the AST2600 Firmware Memory Controller
+	"aspeed,ast2600-spi" for the AST2600 SPI flash memory controllers
 
   - reg : the first contains the control register location and length,
           the second contains the memory window mapping address and length
-- 
2.21.0

