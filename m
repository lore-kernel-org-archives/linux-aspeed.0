From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Mon,  4 Dec 2023 13:41:30 +0800
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Meta Minerva Harma board
In-Reply-To: <20231204054131.1845775-1-peter.yin@quantatw.com>
References: <20231204054131.1845775-1-peter.yin@quantatw.com>
Message-ID: <20231204054131.1845775-2-peter.yin@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Peter Yin <peteryin.openbmc@gmail.com>

Document the new compatibles used on Meta Minerva Harma.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e17b3d66d6e5..20e3be8d8c78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,minerva-harma
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.25.1

