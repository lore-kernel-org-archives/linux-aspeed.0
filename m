From: Oskar Senft <osk@google.com>
Date: Tue, 30 Jul 2019 21:34:03 -0400
Subject: [PATCH v2 2/3] dt-bindings: serial: 8250: Add documentation for
 espi-enabled.
In-Reply-To: <20190731013404.243755-1-osk@google.com>
References: <20190731013404.243755-1-osk@google.com>
Message-ID: <20190731013404.243755-2-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add documentation for 8250_aspeed_vuart's espi-enabled property that
enables to auto-configure the VUART's SIRQ polarity.

Signed-off-by: Oskar Senft <osk@google.com>
---
 Documentation/devicetree/bindings/serial/8250.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 20d351f268ef..4b8b9e502179 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -56,6 +56,11 @@ Optional properties:
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
   line respectively. It will use specified GPIO instead of the peripheral
   function pin for the UART feature. If unsure, don't specify this property.
+- espi-enabled: Only applicable to aspeed,ast2500-vuart. Value is a phandle to
+  aspeed,ast2500-scu syscon alongside register offset and bit number to
+  identify whether the system is in eSPI mode. This is used to auto-configure
+  SIRQ polarity on the vuart.
+  Example: espi-enabled = <&syscon 0x70 25>
 
 Note:
 * fsl,ns16550:
-- 
2.22.0.709.g102302147b-goog

