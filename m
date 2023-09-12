From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 12 Sep 2023 17:09:23 -0500
Subject: [PATCH v3 2/2] MAINTAINERS: Added maintainer for host bmc DD
In-Reply-To: <20230912220923.3701688-1-ninad@linux.ibm.com>
References: <20230912220923.3701688-1-ninad@linux.ibm.com>
Message-ID: <20230912220923.3701688-3-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Added maintainer for new driver file.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..471382a2fff5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3100,6 +3100,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 F:	drivers/media/platform/aspeed/
 
+ASPEED HOST BMC DEVICE DRIVER
+M:	Ninad Palsule <ninad@linux.ibm.com>
+L:	linux-media at vger.kernel.org
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/soc/aspeed/aspeed-host-bmc-dev.c
+
 ASUS EC HARDWARE MONITOR DRIVER
 M:	Eugene Shalygin <eugene.shalygin@gmail.com>
 L:	linux-hwmon at vger.kernel.org
-- 
2.39.2

