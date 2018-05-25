From: Joel Stanley <joel@jms.id.au>
Date: Fri, 25 May 2018 14:48:15 +0930
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.18
Message-ID: <CACPK8XeAPDem7NnbmbrnxfXvsCPU3K0zTi2r9goqaeBqFgk_Gg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM maintainers,

Here are the ASPEED device tree updates for 4.18.

Cheers!

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.18-devicetree

for you to fetch changes up to 5b1d4fa9885108cb769c5f3a8a2c9fa082fbcbe2:

  ARM: dts: Aspeed: Enable USB ports on eval board. (2018-05-25 13:57:37 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 4.18

New hardware support added:

  USB controllers for AST2400 and AST2500 which have drivers
  merged in 4.18.

  Hardware random number generator which we made enhancements to many
  releases ago, but never added the device tree parts.

  Misc changes to support watchdog and gpio-keys features used by
  OpenBMC systems.

New machines:

 Intel S2600WF, an Intel platform family with an ASPEED AST2500 BMC.

 Inventec Lanyang, a Power 9 platform with AST2500.

 Portwell Neptune, a x86 server development kit with an AST2500.

----------------------------------------------------------------
Amithash Prasad (1):
      ARM: dts: aspeed: Add Portwell Neptune machine

Benjamin Herrenschmidt (2):
      ARM: dts: Add Aspeed SoC USB controllers to device-tree
      ARM: dts: Aspeed: Enable USB ports on eval board.

Brad Bishop (1):
      ARM: dts: aspeed: witherspoon: Enable checkstop and cooling gpio keys

Brian Yang (1):
      ARM: dts: aspeed: Add Inventec Lanyang BMC

Christopher Bostic (1):
      ARM: dts: aspeed: witherspoon: Add gpio keys for power supply presence

Eddie James (1):
      ARM: dts: aspeed: witherspoon: Set alternate boot

James Feist (1):
      ARM: dts: aspeed: Add S2600WF BMC Machine

Joel Stanley (1):
      ARM: dts: aspeed: Describe random number device

Lei YU (2):
      ARM: dts: aspeed: romulus: Add id-button gpio key
      ARM: dts: aspeed: zaius: Add pcie-e2b-present gpio key

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/aspeed-ast2500-evb.dts           |  18 ++
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts     | 129 ++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts       | 325 +++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |   6 +
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |  32 ++
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         |   6 +
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts  | 159 ++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi                   |  35 +++
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  47 +++
 11 files changed, 761 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
