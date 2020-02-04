From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  4 Feb 2020 16:49:06 -0600
Subject: [PATCH 0/2] ARM: dts: aspeed: Fix SCU IRQ controller node addresses
Message-ID: <20200204224908.19967-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Warnings were introduced due to unit address on nodes that had no reg property.
Drop the unit addresses from the nodes.

Eddie James (2):
  ARM: dts: aspeed: ast2500: Fix SCU IRQ controller node address
  ARM: dts: aspeed: ast2600: Fix SCU IRQ controller node addresses

 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.24.0

