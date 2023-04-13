From: Joel Stanley <joel@jms.id.au>
Date: Thu, 13 Apr 2023 07:23:41 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.4
Message-ID: <CACPK8XfmK5S=1PQjBQHb6daDR3qTWN-_NLoXP7+ZDCk13wDxcA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here's the aspeed device tree pull request for 6.4. A bit late, I lost
track of time.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.4-devicetree

for you to fetch changes up to 7d4f0b0df7c5ec0cec834f87591423a7bbd1bab2:

  ARM: dts: aspeed-g6: Add UDMA node (2023-04-13 16:43:15 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 6.4

 - Fixes for romed8hm3 GPIO, asrock SPI clocks, bonnell eeprom

 - Misc updates for various BMC systems

 - Add AST2600 UDMA node

----------------------------------------------------------------
Chanh Nguyen (1):
      ARM: dts: aspeed: mtmitchell: Enable NCSI

Chia-Wei Wang (1):
      ARM: dts: aspeed-g6: Add UDMA node

Delphine CC Chiu (2):
      ARM: dts: aspeed: greatlakes: Add gpio names
      ARM: dts: aspeed: greatlakes: add mctp device

Eddie James (3):
      ARM: dts: aspeed: everest: Add reserved memory for TPM event log
      ARM: dts: aspeed: bonnell: Remove MAC3
      ARM: dts: aspeed: bonnell: Update eeprom size

Lakshmi Yadlapati (1):
      ARM: dts: aspeed: p10bmc: Change power supply info

Zev Weiss (3):
      ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
      ARM: dts: aspeed: e3c246d4i: Add PECI device
      ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks

 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 37 ++++++++++++++-
 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts  |  6 ++-
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts  |  4 +-
 .../boot/dts/aspeed-bmc-facebook-greatlakes.dts    | 53 ++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts       | 24 +++-------
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |  6 +++
 arch/arm/boot/dts/aspeed-g6.dtsi                   |  9 ++++
 7 files changed, 118 insertions(+), 21 deletions(-)
