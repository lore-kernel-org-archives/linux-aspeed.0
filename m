From: Chen.PJ 陳柏任 TAO <Chen.PJ@inventec.com>
Date: Tue, 16 May 2023 09:15:43 +0000
Subject: [PATCH] dt-bindings: arm: aspeed: add Inventec starscream-bmc
In-Reply-To: <28f0ce0a82464083ae24f9ef2f598425@inventec.com>
References: <28f0ce0a82464083ae24f9ef2f598425@inventec.com>
Message-ID: <c5dd9b64b4754da8b11efefd97527a4f@inventec.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document the new compatibles used on Inventec starscream-bmc

Signed-off-by: Chen PJ <Chen.pj@inventec.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1b585e554791..fb4ce5df2fa0 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -82,6 +82,7 @@ properties:
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
+              - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
               - nuvia,dc-scm-bmc
-- 
2.25.1

