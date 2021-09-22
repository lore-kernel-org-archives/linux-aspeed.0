From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Wed, 22 Sep 2021 18:31:06 +0800
Subject: [PATCH 00/10] ASPEED SD/eMMC controller clock configuration
Message-ID: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series aims to configure SD and eMMC controllers' clock
frequency and clock phase parameters. The main modification is the
clock phase calculation method which has been checked with the HW IP
designer. Also, the clock source detection method is updated for
AST2600-A2/A3. This patch series has been verified on AST2600-A3 EVB.

Chin-Ting Kuo (10):
  clk: aspeed: ast2600: Porting sdhci clock source
  sdhci: aspeed: Add SDR50 support
  dts: aspeed: ast2600: Support SDR50 for SD device
  mmc: Add invert flag for clock phase signedness
  mmc: aspeed: Adjust delay taps calculation method
  arm: dts: aspeed: Change eMMC device compatible
  arm: dts: aspeed: Adjust clock phase parameter
  arm: dts: ibm: Adjust clock phase parameter
  dt-bindings: mmc: aspeed: Add max-tap-delay property
  dt-bindings: mmc: aspeed: Add a new compatible string

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |   4 +
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts   |   8 ++
 arch/arm/boot/dts/aspeed-ast2600-evb.dts      |  11 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  |   3 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  |   3 +-
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts   |   3 +-
 arch/arm/boot/dts/aspeed-g6.dtsi              |   2 +-
 drivers/clk/clk-ast2600.c                     |  69 ++++++++--
 drivers/mmc/core/host.c                       |  10 +-
 drivers/mmc/host/sdhci-of-aspeed.c            | 123 ++++++++++++++----
 include/linux/mmc/host.h                      |   2 +
 11 files changed, 193 insertions(+), 45 deletions(-)

-- 
2.17.1

