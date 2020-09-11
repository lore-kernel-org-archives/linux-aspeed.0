From: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 11 Sep 2020 11:46:27 +0800
Subject: [PATCH 0/4] Remove LPC register partitioning
Message-ID: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The LPC controller has no concept of the BMC and the Host partitions.
The incorrect partitioning can impose unnecessary range restrictions
on register access through the syscon regmap interface.

For instance, HICRB contains the I/O port address configuration
of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
HICRB as it is located at the other LPC partition.

In addition, to be backward compatible, the newly added HW control
bits could be added at any reserved bits over the LPC addressing space.

Thereby, this patch series aims to remove the LPC partitioning for
better driver development and maintenance.

Chia-Wei, Wang (4):
  ARM: dts: Remove LPC BMC and Host partitions
  soc: aspeed: Fix LPC register offsets
  ipmi: kcs: aspeed: Fix LPC register offsets
  pinctrl: aspeed-g5: Fix LPC register offsets

 arch/arm/boot/dts/aspeed-g4.dtsi           |  74 +++++------
 arch/arm/boot/dts/aspeed-g5.dtsi           | 135 +++++++++------------
 arch/arm/boot/dts/aspeed-g6.dtsi           | 135 +++++++++------------
 drivers/char/ipmi/kcs_bmc_aspeed.c         |  13 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c |   2 +-
 drivers/soc/aspeed/aspeed-lpc-ctrl.c       |   6 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c      |  11 +-
 7 files changed, 162 insertions(+), 214 deletions(-)

-- 
2.17.1

