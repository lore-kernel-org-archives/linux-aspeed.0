From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Tue, 12 Apr 2022 14:56:08 +0800
Subject: [PATCH v4 0/3] Add reset deassertion for Aspeed MDIO
Message-ID: <20220412065611.8930-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add missing reset deassertion for Aspeed MDIO bus controller. The reset
is asserted by the hardware when power-on so the driver only needs to
deassert it. To be able to work with the old DT blobs, the reset is
optional since it may be deasserted by the bootloader or the previous
kernel.

V4:
- use ASPEED_RESET_MII instead of hardcoding in dt-binding example

V3:
- remove reset property from the required list of the device tree
  bindings
- remove "Cc: stable at vger.kernel.org" from the commit messages
- add more description in the commit message of the dt-binding

V2:
- add reset property in the device tree bindings
- add reset assertion in the error path and driver remove

Dylan Hung (3):
  dt-bindings: net: add reset property for aspeed, ast2600-mdio binding
  net: mdio: add reset control for Aspeed MDIO
  ARM: dts: aspeed: add reset properties into MDIO nodes

 .../bindings/net/aspeed,ast2600-mdio.yaml         |  5 +++++
 arch/arm/boot/dts/aspeed-g6.dtsi                  |  4 ++++
 drivers/net/mdio/mdio-aspeed.c                    | 15 ++++++++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.25.1

