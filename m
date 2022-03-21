From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Mon, 21 Mar 2022 17:56:45 +0800
Subject: [PATCH v2 0/3]  Add reset deassertion for Aspeed MDIO
Message-ID: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add missing reset deassertion for Aspeed MDIO. There are 4 MDIOs embedded
in Aspeed AST2600 and share one reset control bit SCU50[3].

Dylan Hung (3):
  dt-bindings: net: add reset property for aspeed, ast2600-mdio binding
  net: mdio: add reset control for Aspeed MDIO
  ARM: dts: aspeed: add reset properties into MDIO nodes

 .../bindings/net/aspeed,ast2600-mdio.yaml         |  4 ++++
 arch/arm/boot/dts/aspeed-g6.dtsi                  |  4 ++++
 drivers/net/mdio/mdio-aspeed.c                    | 15 ++++++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

-- 
2.25.1

