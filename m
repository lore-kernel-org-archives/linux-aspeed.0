From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Sep 2020 20:24:37 +0930
Subject: [PATCH 0/3] mmc: sdhci-of-aspeed: Expose data sample phase delay
 tuning
Message-ID: <20200910105440.3087723-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series exposes some devicetree properties for tuning sample phase
delay in the Aspeed SD/eMMC controllers. The relevant register was
introduced on the AST2600 and is present for both the SD/MMC controller
and the dedicated eMMC controller.

Please review!

Joel: If Rob's happy with the binding change can you take the dts patch
through the aspeed dt tree?

Cheers,

Andrew

Andrew Jeffery (3):
  dt: bindings: mmc: Add phase control properties for the Aspeed SDHCI
  mmc: sdhci-of-aspeed: Expose data sample phase delay tuning
  ARM: dts: tacoma: Add data sample phase delay for eMMC

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |   8 +
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |   2 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 137 +++++++++++++++++-
 3 files changed, 142 insertions(+), 5 deletions(-)

-- 
2.25.1

