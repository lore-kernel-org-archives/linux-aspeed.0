From: Renze Nicolai <renze@rnplus.nl>
Date: Wed, 29 Nov 2023 00:23:16 +0100
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Asrock X570D4U board
In-Reply-To: <20231128232456.2932350-1-renze@rnplus.nl>
References: <20231128232456.2932350-1-renze@rnplus.nl>
Message-ID: <20231128232456.2932350-2-renze@rnplus.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document Asrock X570D4U compatible.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..81ed678905fa 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -36,6 +36,7 @@ properties:
               - aspeed,ast2500-evb
               - asrock,e3c246d4i-bmc
               - asrock,romed8hm3-bmc
+              - asrock,x570d4u-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc
               - facebook,minipack-bmc
-- 
2.43.0

