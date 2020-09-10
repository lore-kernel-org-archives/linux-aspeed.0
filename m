From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Sep 2020 20:24:38 +0930
Subject: [PATCH 1/3] dt: bindings: mmc: Add phase control properties for the
 Aspeed SDHCI
In-Reply-To: <20200910105440.3087723-1-andrew@aj.id.au>
References: <20200910105440.3087723-1-andrew@aj.id.au>
Message-ID: <20200910105440.3087723-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add properties to control the phase delay for input and output data
sampling.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 987b287f3bff..75effd411554 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -61,6 +61,14 @@ patternProperties:
       sdhci,auto-cmd12:
         type: boolean
         description: Specifies that controller should use auto CMD12
+      "aspeed,input-phase":
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          The input clock phase delay value.
+      "aspeed,output-phase":
+        $ref: '/schemas/types.yaml#/definitions/uint32'
+        description:
+          The output clock phase delay value.
     required:
       - compatible
       - reg
-- 
2.25.1

