From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 11 Sep 2020 17:14:50 +0930
Subject: [PATCH v2 1/3] dt: bindings: mmc: Add phase control properties for
 the Aspeed SDHCI
In-Reply-To: <20200911074452.3148259-1-andrew@aj.id.au>
References: <20200911074452.3148259-1-andrew@aj.id.au>
Message-ID: <20200911074452.3148259-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add properties to control the phase delay for input and output data.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 987b287f3bff..d7b605968c8a 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -61,6 +61,14 @@ patternProperties:
       sdhci,auto-cmd12:
         type: boolean
         description: Specifies that controller should use auto CMD12
+      "aspeed,input-phase":
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          The input phase delay value.
+      "aspeed,output-phase":
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          The output phase delay value.
     required:
       - compatible
       - reg
-- 
2.25.1

