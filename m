From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Sep 2017 17:21:41 +0930
Subject: [PATCH 0/8] ARM: dts: aspeed: Device tree updates
Message-ID: <20170928075149.8154-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds support for the i2c buses and vuart in the ASPEED device
trees, as well as making a few cleanups.

I will merge these into my Aspeed devicetree tree once they have some acks.

I have a second series ready to go as soon as our clk driver is merged.

Cheers,

Joel

Andrew Jeffery (1):
  ARM: dts: aspeed: Move pinctrl subnodes to improve readability

Joel Stanley (7):
  ARM: dts: aspeed: Reorder ADC node
  ARM: dts: aspeed: Add I2C buses
  ARM: dts: aspeed-romulus: Add I2C devices
  ARM: dts: aspeed-palmetto: Add I2C devices
  ARM: dts: aspeed-ast2500: Add I2C devices
  ARM: dts: aspeed: Add aliases for UARTs
  ARM: dts: aspeed: Clean up UART nodes

 arch/arm/boot/dts/aspeed-ast2500-evb.dts      |   19 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts |   52 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |   54 +
 arch/arm/boot/dts/aspeed-g4.dtsi              | 1773 +++++++++++++-----------
 arch/arm/boot/dts/aspeed-g5.dtsi              | 1810 ++++++++++++++-----------
 5 files changed, 2176 insertions(+), 1532 deletions(-)

-- 
2.14.1

