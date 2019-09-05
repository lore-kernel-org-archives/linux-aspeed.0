From: Oskar Senft <osk@google.com>
Date: Thu,  5 Sep 2019 10:41:29 -0400
Subject: [PATCH v3 2/3] dt-bindings: serial: 8250: Add aspeed,
 sirq-polarity-sense.
In-Reply-To: <20190905144130.220713-1-osk@google.com>
References: <20190905144130.220713-1-osk@google.com>
Message-ID: <20190905144130.220713-2-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add documentation for 8250_aspeed_vuart's aspeed,sirq-polarity-sense
property that enables to auto-configure the VUART's SIRQ polarity.

Signed-off-by: Oskar Senft <osk@google.com>
---
 Documentation/devicetree/bindings/serial/8250.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 20d351f268ef..55700f20f6ee 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -56,6 +56,11 @@ Optional properties:
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
   line respectively. It will use specified GPIO instead of the peripheral
   function pin for the UART feature. If unsure, don't specify this property.
+- aspeed,sirq-polarity-sense: Only applicable to aspeed,ast2500-vuart.
+  phandle to aspeed,ast2500-scu compatible syscon alongside register offset
+  and bit number to identify how the SIRQ polarity should be configured.
+  One possible data source is the LPC/eSPI mode bit.
+  Example: aspeed,sirq-polarity-sense = <&syscon 0x70 25>
 
 Note:
 * fsl,ns16550:
-- 
2.23.0.187.g17f5b7556c-goog

