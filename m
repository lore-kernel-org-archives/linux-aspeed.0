From: Michael Walle <michael@walle.cc>
Date: Wed, 18 Jan 2023 11:01:35 +0100
Subject: [PATCH net-next v2 0/6] net: phy: Remove probe_capabilities
Message-ID: <20230116-net-next-remove-probe-capabilities-v2-0-15513b05e1f4@walle.cc>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With all the drivers which used .probe_capabilities converted to the
new c45 MDIO access methods, we can now decide based upon these whether
a bus driver supports c45 and we can get rid of the not widely used
probe_capabilites.

Unfortunately, due to a now broader support of c45 scans, this will
trigger a bug on some boards with a (c22-only) Micrel PHY. These PHYs
don't ignore c45 accesses correctly, thinking they are addressed
themselves and distrupt the MDIO access. To avoid this, a blacklist
for c45 scans is introduced.

To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
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
To: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: netdev at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-stm32 at st-md-mailman.stormreply.com
Cc: linux-aspeed at lists.ozlabs.org
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Michael Walle <michael@walle.cc>

---
- Link to v1: https://lore.kernel.org/r/20230116-net-next-remove-probe-capabilities-v1-0-5aa29738a023 at walle.cc

---
Andrew Lunn (6):
      net: mdio: Move mdiobus_scan() within file
      net: mdio: Rework scanning of bus ready for quirks
      net: mdio: Add workaround for Micrel PHYs which are not C45 compatible
      net: mdio: scan bus based on bus capabilities for C22 and C45
      net: phy: Decide on C45 capabilities based on presence of method
      net: phy: Remove probe_capabilities

 drivers/net/ethernet/adi/adin1110.c               |   1 -
 drivers/net/ethernet/freescale/xgmac_mdio.c       |   1 -
 drivers/net/ethernet/marvell/pxa168_eth.c         |   2 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c       |   1 -
 drivers/net/ethernet/microchip/lan743x_main.c     |   2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |   3 -
 drivers/net/mdio/mdio-aspeed.c                    |   1 -
 drivers/net/phy/mdio_bus.c                        | 197 +++++++++++++++-------
 drivers/net/phy/phy_device.c                      |   2 +-
 include/linux/micrel_phy.h                        |   2 +
 include/linux/phy.h                               |  10 +-
 11 files changed, 140 insertions(+), 82 deletions(-)
---
base-commit: c12e2e5b76b2e739ccdf196bee960412b45d5f85
change-id: 20230116-net-next-remove-probe-capabilities-03d401439fc6

Best regards,
-- 
Michael Walle <michael@walle.cc>
