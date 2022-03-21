From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Mon, 21 Mar 2022 15:01:29 +0800
Subject: [PATCH 0/2] Add reset deassertion for Aspeed MDIO
Message-ID: <20220321070131.23363-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add missing reset deassertion for Aspeed MDIO. There are 4 MDIOs
embedded in Aspeed AST2600 and share one reset control bit SCU50[3].

Dylan Hung (2):
  net: mdio: add reset deassertion for Aspeed MDIO
  ARM: dts: aspeed: add reset properties into MDIO nodes

 arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++++
 drivers/net/mdio/mdio-aspeed.c   | 8 ++++++++
 2 files changed, 12 insertions(+)

-- 
2.25.1

