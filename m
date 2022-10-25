From: Joel Stanley <joel@jms.id.au>
Date: Tue, 25 Oct 2022 12:38:56 +1030
Subject: [PATCH] MAINTAINERS: Add Ben as a reviewer for ASPEED UCD
Message-ID: <20221025020856.744202-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

He wrote the vhub driver and would like to be cc'd on patches.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bb30c0d1cb4..637beabc70f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3232,12 +3232,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 F:	drivers/media/platform/aspeed/
 
-ASPEED USB UDC DRIVER
+ASPEED USB UDC DRIVERS
 M:	Neal Liu <neal_liu@aspeedtech.com>
+R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/usb/aspeed,ast2600-udc.yaml
 F:	drivers/usb/gadget/udc/aspeed_udc.c
+F:	Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
+F: 	drivers/usb/gadget/udc/aspeed-vhub/
 
 ASPEED CRYPTO DRIVER
 M:	Neal Liu <neal_liu@aspeedtech.com>
-- 
2.35.1

