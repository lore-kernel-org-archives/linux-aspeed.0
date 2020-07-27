From: Joel Stanley <joel@jms.id.au>
Date: Mon, 27 Jul 2020 23:45:11 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.9
Message-ID: <CACPK8Xf_Np7LtcDFhywi6Uk1EgUpb0pVVa+Lr9YEwBRjbjOKCQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM maintainers,

Here's the ASPEED pull request for 5.9. Most of the patches have been
sitting in next for a while, with a few late comers merged today.

The following changes since commit 2c887638a5fa1ac5e2491ae911f50d554b604985:

  ARM: dts: Aspeed: tacoma: Enable EHCI controller (2020-07-28 09:02:45 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.9-devicetree

for you to fetch changes up to 2c887638a5fa1ac5e2491ae911f50d554b604985:

  ARM: dts: Aspeed: tacoma: Enable EHCI controller (2020-07-28 09:02:45 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.9

There is one new machine; AMD's EthanolX reference platform with an
AST2600 BMC.

Misc updates for Rainier, Tacoma, Wedge and Mihawk machines.

----------------------------------------------------------------

Andrew Jeffery (2):
      ARM: dts: rainier: Configure ball Y23 as GPIOP7 for MCLR_VPP
      ARM: dts: rainier: Describe GPIO mux on I2C3

Ben Pai (2):
      ARM: dts: aspeed: mihawk: IO expander uses TCA9554 driver
      ARM: dts: aspeed: mihawk: Add 8 tmp401 thermal sensors

Ben Tyner (2):
      ARM: dts: aspeed: tacoma: Remove checkstop gpio-key
      ARM: dts: aspeed: rainier: Add line-name checkstop

Eddie James (9):
      ARM: dts: aspeed: ast2500: Update XDMA engine node
      ARM: dts: aspeed: ast2600: Update XDMA engine node
      ARM: dts: aspeed: witherspoon: Enable XDMA engine
      ARM: dts: aspeed: tacoma: Enable XDMA engine
      ARM: dts: aspeed: rainier: Add second cfam on the hub
      ARM: dts: aspeed: rainier: Add CFAM SPI controllers
      ARM: dts: aspeed: rainier: Switch OCCs to P10
      ARM: dts: aspeed: rainier: Enable EHCI controller
      ARM: dts: Aspeed: tacoma: Enable EHCI controller

Jet Li (1):
      ARM: dts: aspeed: rainier: Add I2C buses for NVMe use

Joel Stanley (5):
      ARM: dts: aspeed: rainier: System has one SPI NOR
      ARM: dts: aspeed: tacoma: Fix gpio-key definitions
      ARM: dts: aspeed: rainier: Add CFAM reset GPIO
      ARM: dts: aspeed: tacoma: Add CFAM reset GPIO
      ARM: dts: aspeed: rainier: Add FSI I2C masters

Supreeth Venkatesh (1):
      ARM: dts: aspeed: Initial device tree for AMD EthanolX

Tao Ren (4):
      ARM: dts: aspeed: cmm: Fixup I2C tree
      ARM: dts: aspeed: wedge40: Disable unused i2c controllers
      ARM: dts: aspeed: wedge40: Enable ADC device
      ARM: dts: aspeed: wedge40: Enable pwm_tacho device
