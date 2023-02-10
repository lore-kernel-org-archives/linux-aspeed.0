From: Jordan Chang <jordan.chang@ufispace.com>
Date: Fri, 10 Feb 2023 13:54:49 +0800
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix for Ufi Space
In-Reply-To: <20230210055451.72153-1-jordan.chang@ufispace.com>
References: <20230210055451.72153-1-jordan.chang@ufispace.com>
Message-ID: <20230210055451.72153-2-jordan.chang@ufispace.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a vendor prefix for Ufi Space (https://www.ufispace.com).

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2f0151e9f6be..ab0dd1cb5ede 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1344,6 +1344,8 @@ patternProperties:
     description: Ubiquiti Networks
   "^udoo,.*":
     description: Udoo
+  "^ufispace,.*":
+    description: Ufi Space Co., Ltd.
   "^ugoos,.*":
     description: Ugoos Industrial Co., Ltd.
   "^uniwest,.*":
-- 
2.39.0

