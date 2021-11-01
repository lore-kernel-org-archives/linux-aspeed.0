From: tommy-huang <tommy_huang@aspeedtech.com>
Date: Mon, 1 Nov 2021 19:01:07 +0800
Subject: [PATCH 4/4] dt-bindings: gpu: Add ASPEED GFX bindings document
In-Reply-To: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
References: <20211101110107.29010-1-tommy_huang@aspeedtech.com>
Message-ID: <20211101110107.29010-5-tommy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add ast2600-gfx description for gfx driver.

Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>
---
 Documentation/devicetree/bindings/gpu/aspeed-gfx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
index 958bdf962339..29ecf119cef2 100644
--- a/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
+++ b/Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
@@ -3,6 +3,7 @@ Device tree configuration for the GFX display device on the ASPEED SoCs
 Required properties:
   - compatible
     * Must be one of the following:
+      + aspeed,ast2600-gfx
       + aspeed,ast2500-gfx
       + aspeed,ast2400-gfx
     * In addition, the ASPEED pinctrl bindings require the 'syscon' property to
-- 
2.17.1

