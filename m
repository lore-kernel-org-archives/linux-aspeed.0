From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 5 Sep 2024 19:47:52 +0800
Subject: [PATCH 0/2] net: mdio: Add ASPEED AST2700 MDIO compatible
Message-ID: <20240905114754.519609-1-jacky_chou@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a new compatible to dt-binding and mdio driver for ASPEED
AST2700 MDIO.

Jacky Chou (2):
  dt-bindings: net: aspeed: Add binding for ASPEED AST2700 MDIO
  net: mdio: aspeed: Add AST2700 support

 .../devicetree/bindings/net/aspeed,ast2600-mdio.yaml          | 4 +++-
 drivers/net/mdio/mdio-aspeed.c                                | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.1

