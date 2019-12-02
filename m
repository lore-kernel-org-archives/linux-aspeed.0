From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon,  2 Dec 2019 16:44:26 +1030
Subject: [PATCH 1/7] dt-bindings: pinctrl: aspeed-g6: Add USB functions and
 groups
In-Reply-To: <20191202061432.3996-1-andrew@aj.id.au>
References: <20191202061432.3996-1-andrew@aj.id.au>
Message-ID: <20191202061432.3996-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 provides two USB ports (A and B) that expose various host,
device and HID functions.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml         | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index 064b7dfc4252..3749fa233e87 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -54,8 +54,9 @@ patternProperties:
               TACH10, TACH11, TACH12, TACH13, TACH14, TACH15, TACH2, TACH3,
               TACH4, TACH5, TACH6, TACH7, TACH8, TACH9, THRU0, THRU1, THRU2,
               THRU3, TXD1, TXD2, TXD3, TXD4, UART10, UART11, UART12, UART13,
-              UART6, UART7, UART8, UART9, VB, VGAHS, VGAVS, WDTRST1, WDTRST2,
-              WDTRST3, WDTRST4, ]
+              UART6, UART7, UART8, UART9, USBAD, USBADP, USB2AH, USB2AHP,
+              USB2BD, USB2BH, VB, VGAHS, VGAVS, WDTRST1, WDTRST2, WDTRST3,
+              WDTRST4, ]
         groups:
           allOf:
             - $ref: "/schemas/types.yaml#/definitions/string"
@@ -85,8 +86,8 @@ patternProperties:
               TACH10, TACH11, TACH12, TACH13, TACH14, TACH15, TACH2, TACH3,
               TACH4, TACH5, TACH6, TACH7, TACH8, TACH9, THRU0, THRU1, THRU2,
               THRU3, TXD1, TXD2, TXD3, TXD4, UART10, UART11, UART12G0,
-              UART12G1, UART13G0, UART13G1, UART6, UART7, UART8, UART9, VB,
-              VGAHS, VGAVS, WDTRST1, WDTRST2, WDTRST3, WDTRST4, ]
+              UART12G1, UART13G0, UART13G1, UART6, UART7, UART8, UART9, USBA,
+              USBB, VB, VGAHS, VGAVS, WDTRST1, WDTRST2, WDTRST3, WDTRST4, ]
 
 required:
   - compatible
-- 
2.20.1

