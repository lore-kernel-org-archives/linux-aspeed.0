From: Potin Lai <potin.lai@quantatw.com>
Date: Fri, 11 Feb 2022 09:43:37 +0800
Subject: [PATCH 00/10] arch: arm: dts: update Facebook Bletchley BMC
Message-ID: <20220211014347.24841-1-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update Facebook Bletchley BMC devicetree base on EVT HW design and 
rebase sled numbering to 1-based for OpenBMC multi-host

This patch series are modified from
LINK: https://lore.kernel.org/all/20220209100413.23714-1-potin.lai at quantatw.com/

Potin Lai (10):
  arch: arm: dts: bletchley: switch sled numbering to 1-based
  arch: arm: dts: bletchley: separate leds into multiple groups
  arch: arm: dts: bletchley: update gpio-line-names
  arch: arm: dts: bletchley: update fmc configurations
  arch: arm: dts: bletchley: switch to spi-gpio for spi2
  arch: arm: dts: bletchley: add interrupt support for sled io expander
  arch: arm: dts: bletchley: add shunt-resistor for ADM1278
  arch: arm: dts: bletchley: add INA230 sensor on each sled
  arch: arm: dts: bletchley: enable mdio3 bus
  arch: arm: dts: bletchley: cleanup redundant node

 .../dts/aspeed-bmc-facebook-bletchley.dts     | 303 +++++++++++-------
 1 file changed, 194 insertions(+), 109 deletions(-)

-- 
2.17.1

