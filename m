From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Aug 2022 09:29:53 +0300
Subject: [PATCH v3] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc compatible after rename
Message-ID: <20220811062953.5976-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Nuvia DC-SCM BMC board compatible was renamed in commit
7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
so adjust the bindings as well.

Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v2:
1. Fix typo in commit msg.
2. Add Acks.

Changes since v1:
1. Use proper qcom compatible.
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 1895ce9de461..4f0b308e9f0f 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,7 +80,7 @@ properties:
               - ibm,tacoma-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
-              - nuvia,dc-scm-bmc
+              - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
           - const: aspeed,ast2600
 
-- 
2.34.1

