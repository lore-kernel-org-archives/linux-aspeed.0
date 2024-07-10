From: George Liu <liuxiwei1013@gmail.com>
Date: Wed, 10 Jul 2024 10:22:49 +0800
Subject: [PATCH v4] dt-bindings: vendor-prefixes: Add prefix for ieisystem
Message-ID: <20240710022249.72234-1-liuxiwei@ieisystem.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a vendor prefix entry for ieisystem

Link: https://en.ieisystem.com/

Signed-off-by: George Liu <liuxiwei1013@gmail.com>
---
v2 -> v3
 - match Signed-off-by email
v3 -> v4
 - add link
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..a559ac5789ae 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -609,6 +609,8 @@ patternProperties:
     description: IC Plus Corp.
   "^idt,.*":
     description: Integrated Device Technologies, Inc.
+  "^ieisystem,.*":
+    description: IEIT SYSTEMS Co.,Ltd.
   "^ifi,.*":
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
   "^ilitek,.*":
-- 
2.34.1

