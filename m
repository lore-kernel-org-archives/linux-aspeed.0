From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Apr 2021 06:14:27 +0000
Subject: [GIT PULL] ARM: bmc: devicetree changes for 5.13
Message-ID: <CACPK8Xe-KV5BeQwOH6NKC1++FCVqwwNCGBh7hEbBORfrmxfTtQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here's a pull request from me for the ASPEED and Nuvoton changes
targeting the v5.13 merge window. As you can see I've chosen to
arrange the pull request as one single "BMC-related" set of changes.
If we choose to continue with this, in the future I will cover the
ASPEED, NPCM and soon to be merged WPCM (legacy Nuvoton) systems.

The following changes since commit ee33e2fb3d70267de00f7c0b09e7e3b309a686df:

  ARM: dts: nuvoton: Add Quanta GBS BMC Device Tree (2021-04-08 11:21:05 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/bmc-5.13-devicetree

for you to fetch changes up to ee33e2fb3d70267de00f7c0b09e7e3b309a686df:

  ARM: dts: nuvoton: Add Quanta GBS BMC Device Tree (2021-04-08 11:21:05 +0930)

----------------------------------------------------------------
BMC device tree updates for 5.13

The ASPEED and Nuvoton pull request now comes as a combined BMC pull
request.

 - New machines

  * ASRock E3C246D4I, an AST2500 BMC for an Xeon E-2100/E-2200 mini-ITX
    system
  * Quanta GBS, an NPCM730 BMC for an x86 server

 - Power10 BMC updates for Everest and Rainier

 - GPIO line names for Mihawk

----------------------------------------------------------------

Alpana Kumari (2):
      ARM: dts: aspeed: rainier: Add presence GPIOs
      ARM: dts: aspeed: everest: GPIOs support

Brandon Wyman (2):
      ARM: dts: aspeed: rainier: Add gpio-keys-polled for fans
      ARM: dts: aspeed: everest: Add power supply i2c devices

Eddie James (7):
      ARM: dts: aspeed: rainier: Add additional processor CFAMs
      ARM: dts: aspeed: rainier: Enable fan watchdog
      ARM: dts: aspeed: rainier 4U: Fix fan configuration
      ARM: dts: aspeed: everest: Add FSI CFAMs and re-number engines
      ARM: dts: aspeed: everest: Add RTC
      ARM: dts: aspeed: everest: Enable fan watchdog
      ARM: dts: aspeed: Add Rainier 1S4U machine

George Hung (1):
      ARM: dts: nuvoton: Add Quanta GBS BMC Device Tree

Jim Wright (1):
      ARM: dts: aspeed: everest: Add UCD90320 power sequencer

Joel Stanley (2):
      ARM: dts: aspeed: rainier: Add missing fan nodes
      ARM: dts: aspeed: everest: Add size/address cells

Matthew Barth (2):
      ARM: dts: aspeed: everest: Add max31785 fan controller device
      ARM: dts: aspeed: everest: Add pca9552 fan presence

Nichole Wang (1):
      ARM: dts: aspeed: mihawk: Add GPIO line names

Priyanga Ramasamy (1):
      ARM: dts: aspeed: everest: Add I2C components

Vishwanatha Subbanna (1):
      ARM: dts: aspeed: rainier: Add directly controlled LEDs

Zev Weiss (1):
      ARM: dts: aspeed: Add ASRock E3C246D4I BMC
