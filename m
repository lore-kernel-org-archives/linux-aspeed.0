From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Oct 2019 12:37:54 +1030
Subject: [PATCH v2 1/3] dt-bindings: net: ftgmac100: Document AST2600
 compatible
In-Reply-To: <20191010020756.4198-1-andrew@aj.id.au>
References: <20191010020756.4198-1-andrew@aj.id.au>
Message-ID: <20191010020756.4198-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 contains an FTGMAC100-compatible MAC, although the MDIO
controller previously embedded in the MAC has been moved out to a
dedicated MDIO block.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/net/ftgmac100.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/ftgmac100.txt b/Documentation/devicetree/bindings/net/ftgmac100.txt
index 72e7aaf7242e..04cc0191b7dd 100644
--- a/Documentation/devicetree/bindings/net/ftgmac100.txt
+++ b/Documentation/devicetree/bindings/net/ftgmac100.txt
@@ -9,6 +9,7 @@ Required properties:
 
      - "aspeed,ast2400-mac"
      - "aspeed,ast2500-mac"
+     - "aspeed,ast2600-mac"
 
 - reg: Address and length of the register set for the device
 - interrupts: Should contain ethernet controller interrupt
-- 
2.20.1

