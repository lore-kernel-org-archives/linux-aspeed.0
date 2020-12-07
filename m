From: Troy Lee <troy_lee@aspeedtech.com>
Date: Mon, 7 Dec 2020 17:00:11 +0800
Subject: [PATCH v4 1/3] dt-bindings: edac: aspeed-sdram-edac: Add
 ast2400/ast2600 support
Message-ID: <20201207090013.14145-1-troy_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adding Aspeed AST2400 and AST2600 binding for edac driver.

Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 .../devicetree/bindings/edac/aspeed-sdram-edac.txt       | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
index 6a0f3d90d682..8ca9e0a049d8 100644
--- a/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
+++ b/Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
@@ -1,6 +1,6 @@
-Aspeed AST2500 SoC EDAC node
+Aspeed BMC SoC EDAC node
 
-The Aspeed AST2500 SoC supports DDR3 and DDR4 memory with and without ECC (error
+The Aspeed BMC SoC supports DDR3 and DDR4 memory with and without ECC (error
 correction check).
 
 The memory controller supports SECDED (single bit error correction, double bit
@@ -11,7 +11,10 @@ Note, the bootloader must configure ECC mode in the memory controller.
 
 
 Required properties:
-- compatible: should be "aspeed,ast2500-sdram-edac"
+- compatible: should be one of
+	- "aspeed,ast2400-sdram-edac"
+	- "aspeed,ast2500-sdram-edac"
+	- "aspeed,ast2600-sdram-edac"
 - reg:        sdram controller register set should be <0x1e6e0000 0x174>
 - interrupts: should be AVIC interrupt #0
 
-- 
2.17.1

