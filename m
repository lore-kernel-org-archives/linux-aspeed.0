From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed,  7 Apr 2021 20:16:34 -0500
Subject: [PATCH v5 1/4] dt-bindings: serial: 8250: deprecate aspeed,
 sirq-polarity-sense
In-Reply-To: <20210408011637.5361-1-zev@bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
Message-ID: <20210408011637.5361-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This property ties SIRQ polarity to SCU register bits that don't
necessarily have any direct relationship to it; the only use of it was
removed in commit c82bf6e133d3 ("ARM: aspeed: g5: Do not set sirq
polarity").

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index f54cae9ff7b2..491b9297432d 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -188,6 +188,7 @@ properties:
       offset and bit number to identify how the SIRQ polarity should be
       configured. One possible data source is the LPC/eSPI mode bit. Only
       applicable to aspeed,ast2500-vuart.
+    deprecated: true
 
 required:
   - reg
-- 
2.31.1

