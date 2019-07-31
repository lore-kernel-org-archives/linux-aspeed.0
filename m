From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 31 Jul 2019 15:09:59 +0930
Subject: [PATCH net-next v2 4/4] net: ftgmac100: Select ASPEED MDIO driver for
 the AST2600
In-Reply-To: <20190731053959.16293-1-andrew@aj.id.au>
References: <20190731053959.16293-1-andrew@aj.id.au>
Message-ID: <20190731053959.16293-5-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Ensures we can talk to a PHY via MDIO on the AST2600, as the MDIO
controller is now separate from the MAC.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/net/ethernet/faraday/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index a9b105803fb7..73e4f2648e49 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -32,6 +32,7 @@ config FTGMAC100
 	depends on ARM || NDS32 || COMPILE_TEST
 	depends on !64BIT || BROKEN
 	select PHYLIB
+	select MDIO_ASPEED if MACH_ASPEED_G6
 	---help---
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller
 	  from Faraday. It is used on Faraday A369, Andes AG102 and some
-- 
2.20.1

