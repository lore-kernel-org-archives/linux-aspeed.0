From: Jordan Chang <jordan.chang@ufispace.com>
Date: Thu, 19 Jan 2023 18:21:00 +0800
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for Ufi Space
In-Reply-To: <20230119102102.73414-1-jordan.chang@ufispace.com>
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
Message-ID: <20230119102102.73414-2-jordan.chang@ufispace.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a vendor prefix for Ufi Space (https://www.ufispace.com).

Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
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
