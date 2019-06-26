From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 26 Jun 2019 16:44:26 +0930
Subject: [PATCH 4/8] MAINTAINERS: Add entry for ASPEED pinctrl drivers
In-Reply-To: <20190626071430.28556-1-andrew@aj.id.au>
References: <20190626071430.28556-1-andrew@aj.id.au>
Message-ID: <20190626071430.28556-5-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add myself as maintainer to avoid burdening others with the madness.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6954776a37e..978383f5c1ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2586,6 +2586,15 @@ S:	Maintained
 F:	Documentation/hwmon/asc7621.rst
 F:	drivers/hwmon/asc7621.c
 
+ASPEED PINCTRL DRIVERS
+M:	Andrew Jeffery <andrew@aj.id.au>
+L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+L:	linux-gpio at vger.kernel.org
+S:	Maintained
+F:	drivers/pinctrl/aspeed/
+F:	Documentation/devicetree/bindings/pinctrl/aspeed,*
+
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
 L:	linux-media at vger.kernel.org
-- 
2.20.1

