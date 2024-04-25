From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 25 Apr 2024 16:36:54 -0500
Subject: [PATCH v3 07/14] dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
In-Reply-To: <20240425213701.655540-1-eajames@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
Message-ID: <20240425213701.655540-8-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove the common properties from the I2CR documentation and instead
point to the common FSI controller documentation.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml         | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
index 442cecdc57cb..9f0c72e8c1a6 100644
--- a/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
+++ b/Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
@@ -22,11 +22,14 @@ properties:
   reg:
     maxItems: 1
 
+allOf:
+  - $ref: fsi-controller.yaml#
+
 required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.39.3

