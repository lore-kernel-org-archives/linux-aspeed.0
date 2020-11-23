From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 23 Nov 2020 17:00:01 +1030
Subject: [PATCH v3 0/3] mmc: sdhci-of-aspeed: Expose phase delay tuning
Message-ID: <20201123063004.337345-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series implements support for the MMC core clk-phase-* devicetree bindings
in the Aspeed SD/eMMC driver. The relevant register was introduced on the
AST2600 and is present for both the SD/MMC controller and the dedicated eMMC
controller.

Previously, v1 and v2 of the series implemented custom bindings. Thanks to Ulf
for pointing out that this functionality already existed in the core bindings.
For historical reference, v2 can be found here:

https://lore.kernel.org/linux-arm-kernel/20200911074452.3148259-1-andrew at aj.id.au/

The series has had light testing on an AST2600-based platform which requires
180deg of input and output clock phase correction at HS200, as well as some
synthetic testing under qemu.

Please review!

Cheers,

Andrew

Andrew Jeffery (3):
  mmc: sdhci-of-aspeed: Expose phase delay tuning
  mmc: sdhci-of-aspeed: Add AST2600 bus clock support
  ARM: dts: rainier: Add eMMC clock phase compensation

 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c           | 310 ++++++++++++++++++-
 2 files changed, 300 insertions(+), 11 deletions(-)

-- 
2.27.0

