From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Dec 2020 11:56:14 +1030
Subject: [PATCH v5 5/6] MAINTAINERS: Add entry for the ASPEED SD/MMC driver
In-Reply-To: <20201208012615.2717412-1-andrew@aj.id.au>
References: <20201208012615.2717412-1-andrew@aj.id.au>
Message-ID: <20201208012615.2717412-6-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add myself as the maintainer.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e451dcce054f..eae4322aae67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2826,6 +2826,15 @@ F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.
 F:	drivers/irqchip/irq-aspeed-scu-ic.c
 F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
 
+ASPEED SD/MMC DRIVER
+M:	Andrew Jeffery <andrew@aj.id.au>
+L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-mmc at vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+F:	drivers/mmc/host/sdhci-of-aspeed*
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media at vger.kernel.org
-- 
2.27.0

