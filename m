From: Michael Walle <michael@walle.cc>
Date: Thu, 12 Jan 2023 16:15:07 +0100
Subject: [PATCH net-next 00/10] net: mdio: Continue separating C22 and C45
Message-ID: <20230112-net-next-c45-seperation-part-2-v1-0-5eeaae931526@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I've picked this older series from Andrew up and rebased it onto
the latest net-next.

This is the second patch set in the series which separates the C22
and C45 MDIO bus transactions at the API level to the MDIO bus drivers.

Signed-off-by: Michael Walle <michael@walle.cc>

?

To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Ray Jui <rjui@broadcom.com>
To: Scott Branden <sbranden@broadcom.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@aj.id.au>
To: Felix Fietkau <nbd@nbd.name>
To: John Crispin <john@phrozen.org>
To: Sean Wang <sean.wang@mediatek.com>
To: Mark Lee <Mark-MC.Lee@mediatek.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: Bryan Whitehead <bryan.whitehead@microchip.com>
To: UNGLinuxDriver@microchip.com
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Jose Abreu <joabreu@synopsys.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
To: Li Yang <leoyang.li@nxp.com>
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-aspeed at lists.ozlabs.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-stm32 at st-md-mailman.stormreply.com
Cc: linuxppc-dev at lists.ozlabs.org
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>

---
Andrew Lunn (10):
      net: mdio: cavium: Separate C22 and C45 transactions
      net: mdio: i2c: Separate C22 and C45 transactions
      net: mdio: mux-bcm-iproc: Separate C22 and C45 transactions
      net: mdio: aspeed: Separate C22 and C45 transactions
      net: mdio: ipq4019: Separate C22 and C45 transactions
      net: ethernet: mtk_eth_soc: Separate C22 and C45 transactions
      net: lan743x: Separate C22 and C45 transactions
      net: stmmac: Separate C22 and C45 transactions for xgmac2
      net: stmmac: Separate C22 and C45 transactions for xgmac
      enetc: Separate C22 and C45 transactions

 drivers/net/dsa/ocelot/felix_vsc9959.c             |   6 +-
 drivers/net/ethernet/freescale/enetc/enetc_mdio.c  | 119 ++++++--
 .../net/ethernet/freescale/enetc/enetc_pci_mdio.c  |   6 +-
 drivers/net/ethernet/freescale/enetc/enetc_pf.c    |  12 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 178 +++++++----
 drivers/net/ethernet/microchip/lan743x_main.c      | 106 ++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 331 ++++++++++++++-------
 drivers/net/mdio/mdio-aspeed.c                     |  47 +--
 drivers/net/mdio/mdio-cavium.c                     | 111 +++++--
 drivers/net/mdio/mdio-cavium.h                     |   9 +-
 drivers/net/mdio/mdio-i2c.c                        |  32 +-
 drivers/net/mdio/mdio-ipq4019.c                    | 154 ++++++----
 drivers/net/mdio/mdio-mux-bcm-iproc.c              |  54 +++-
 drivers/net/mdio/mdio-octeon.c                     |   6 +-
 drivers/net/mdio/mdio-thunder.c                    |   6 +-
 include/linux/fsl/enetc_mdio.h                     |  21 +-
 16 files changed, 766 insertions(+), 432 deletions(-)
---
base-commit: 0a093b2893c711d82622a9ab27da4f1172821336
change-id: 20230112-net-next-c45-seperation-part-2-1b8fbb144687

Best regards,
-- 
Michael Walle <michael@walle.cc>
