From: Jordan Chang <jordan.chang@ufispace.com>
Date: Thu, 19 Jan 2023 18:21:01 +0800
Subject: [PATCH 2/3] dt-bindings: arm: aspeed: document Ufispace NCPLite BMC
In-Reply-To: <20230119102102.73414-1-jordan.chang@ufispace.com>
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
Message-ID: <20230119102102.73414-3-jordan.chang@ufispace.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Document Ufispace NCPLite board compatible.

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 272626937ecd..0f180aad3a09 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -85,6 +85,7 @@ properties:
               - jabil,rbp-bmc
               - nuvia,dc-scm-bmc
               - quanta,s6q-bmc
+              - ufispace,ncplite-bmc
           - const: aspeed,ast2600
 
 additionalProperties: true
-- 
2.39.0


-- 
******************************
This e-mail is confidential. If you are not 
the intended recipient, you must not disclose, distribute or use the 
information in it as this could be a breach of confidentiality.If you have 
received this message in error, please advise us immediately by return 
e-mail and delete the document. The address from which this message has 
been sent is strictly for business mail only and the company reserves the 
right to monitor the contents of communications and take action where and 
when it is deemed necessary.
Thank you for your co-operation.
