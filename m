From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 11 Sep 2020 17:14:49 +0930
Subject: [PATCH v2 0/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
Message-ID: <20200911074452.3148259-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series exposes some devicetree properties for tuning phase delay in the
Aspeed SD/eMMC controllers. The relevant register was introduced on the AST2600
and is present for both the SD/MMC controller and the dedicated eMMC
controller.

v2 addresses comments from Joel.

v1 can be found here:

https://lore.kernel.org/linux-arm-kernel/20200910105440.3087723-1-andrew at aj.id.au/T/

Please review!

Cheers,

Andrew

Andrew Jeffery (3):
  dt: bindings: mmc: Add phase control properties for the Aspeed SDHCI
  mmc: sdhci-of-aspeed: Expose data sample phase delay tuning
  ARM: dts: tacoma: Add data sample phase delay for eMMC

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |   8 ++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |   2 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 126 +++++++++++++++++-
 3 files changed, 131 insertions(+), 5 deletions(-)

-- 
2.25.1

