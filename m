From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed,  1 May 2024 17:28:32 -0700
Subject: [PATCH v3 2/3] dt-bindings: arm: aspeed: document ASRock E3C256D4I
In-Reply-To: <20240502002836.17862-5-zev@bewilderbeest.net>
References: <20240502002836.17862-5-zev@bewilderbeest.net>
Message-ID: <20240502002836.17862-7-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document ASRock E3C256D4I board compatible.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..c330eba0e869 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -35,6 +35,7 @@ properties:
               - ampere,mtjade-bmc
               - aspeed,ast2500-evb
               - asrock,e3c246d4i-bmc
+              - asrock,e3c256d4i-bmc
               - asrock,romed8hm3-bmc
               - bytedance,g220a-bmc
               - facebook,cmm-bmc
-- 
2.44.0

