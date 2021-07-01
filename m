From: Joel Stanley <joel@jms.id.au>
Date: Thu, 1 Jul 2021 04:31:59 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree fixes for 5.14
Message-ID: <CACPK8XefdPzeOUDnDgk9cHQEs-9wF_ZSPdYQRzuNOpGZTyGUKQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are some minor fixes for the aspeed device trees.

The following changes since commit dd87684c7c9b82ad450cf063c58b4131074ad8f2:

  ARM: dts: aspeed: everest: Add pcie cable card indicator leds
(2021-06-07 13:38:55 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.14-devicetree-2

for you to fetch changes up to ab4a49d36010564c70fe5586a4c2b1985866616f:

  ARM: dts: aspeed: everest: PSU #3 address change (2021-07-01 13:41:33 +0930)

----------------------------------------------------------------
ASPEED device tree fixes for 5.14

 - eMMC phase corrections so Tacoma and Everest can boot

 - VUART irq polarity fix for e3c246d4i, using new bindings

 - I2C address fix for Rainier power supply

 - GPIO line name fixes

----------------------------------------------------------------
Andrew Jeffery (2):
      ARM: dts: tacoma: Add phase corrections for eMMC
      ARM: dts: everest: Add phase corrections for eMMC

B. J. Wyman (1):
      ARM: dts: aspeed: everest: PSU #3 address change

Joel Stanley (1):
      ARM: dts: aspeed: Fix AST2600 machines line names

Zev Weiss (1):
      ARM: dts: aspeed: Update e3c246d4i vuart properties

 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 4 +++-
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts      | 9 +++++----
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts      | 5 +----
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts       | 6 ++----
 4 files changed, 11 insertions(+), 13 deletions(-)
