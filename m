From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Aug 2017 15:37:35 +0930
Subject: [PATCH 1/2] dt-bindings: gpio: aspeed: Remove reference to clock name
In-Reply-To: <20170808060736.1917-1-andrew@aj.id.au>
References: <20170808060736.1917-1-andrew@aj.id.au>
Message-ID: <20170808060736.1917-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

HPLL is in fact not the clock we need. Remove prescription of which clock to
avoid further error. Please refer to your datasheet and double check like I
should have.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/gpio/gpio-aspeed.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
index c756afa88cc6..fc6378c778c5 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-aspeed.txt
@@ -18,7 +18,7 @@ Required properties:
 Optional properties:
 
 - interrupt-parent      : The parent interrupt controller, optional if inherited
-- clocks                : A phandle to the HPLL clock node for debounce timings
+- clocks                : A phandle to the clock to use for debounce timings
 
 The gpio and interrupt properties are further described in their respective
 bindings documentation:
-- 
2.11.0

