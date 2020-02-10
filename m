From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 10 Feb 2020 13:32:25 -0600
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Fix SCU IRQ controller node addresses
Message-ID: <1581363147-19310-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Warnings were introduced due to unit address on nodes that had no reg property.
Add the reg properties for the nodes to fix the warnings.

Eddie James (2):
  ARM: dts: aspeed: ast2500: Fix SCU IRQ controller node
  ARM: dts: aspeed: ast2600: Fix SCU IRQ controller nodes

 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 arch/arm/boot/dts/aspeed-g6.dtsi | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
1.8.3.1

