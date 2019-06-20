From: Joel Stanley <joel@jms.id.au>
Date: Thu, 20 Jun 2019 07:34:16 +0000
Subject: [GIT PULL] ARM: aspeed: dts changes for 5.3
Message-ID: <CACPK8XfMEzqvTGZz7JZxz0XQ0tBHzpJRDxtCEFB-ZzKCyDeuQw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM maintainers,

Here's the ASPEED device tree changes for 5.3. Most of the patches
have been baking for a number of weeks, with a few late changes added
in today.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-5.3-devicetree

for you to fetch changes up to 6084110a0e9c4bff75970f3d68091ceff9e2c2c7:

  ARM: dts: aspeed: Enable video engine on romulus and wtherspoon
(2019-06-20 16:37:26 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.3

We have various device tree updates from the OpenBMC project to enable
bits and pieces in existing systems, notably updates to Google's Zaius.

There are some AST2500 machines under development:

  * Lenovo Hr630
  * IBM Swift
  * Facebook YAMP

And some AST2400 machines that have been around but out of tree and have
now joined the party:

  * YADRO VESNIN
  * Microsoft Olympus

----------------------------------------------------------------
Adriana Kobylak (2):
      ARM: dts: aspeed: Add Swift BMC machine
      ARM: dts: aspeed: swift: Add pca9539 devices

Alexander Filippov (1):
      ARM: dts: aspeed: Add YADRO VESNIN BMC

Andrew Peng (1):
      ARM: dts: aspeed: Adding Lenovo Hr630 BMC

Benjamin Herrenschmidt (1):
      ARM: dts: aspeed: Add Power9 and Power9 CFAM description

Eddie James (1):
      ARM: dts: aspeed: Enable video engine on romulus and wtherspoon

Hongwei Zhang (1):
      ARM: dts: aspeed: Add Microsoft Olympus BMC

Joel Stanley (1):
      ARM: dts: aspeed: Rename flash-controller nodes

John Wang (1):
      ARM: dts: aspeed: Add Inspur fp5280g2 BMC machine

Maxim Sloyko (1):
      ARM: dts: aspeed: zaius: add Infineon and Intersil regulators

Patrick Venture (2):
      ARM: dts: aspeed: Add aspeed-p2a-ctrl node
      ARM: dts: aspeed: quanta-q71: Enable p2a node

Robert Lippert (2):
      ARM: dts: aspeed: zaius: update 12V brick I2C address
      ARM: dts: aspeed: zaius: fixed I2C bus numbers for pcie slots

Tao Ren (2):
      ARM: dts: aspeed: cmm: enable ehci host controllers
      ARM: dts: aspeed: Add Facebook YAMP BMC

 arch/arm/boot/dts/Makefile                         |   6 +
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts      |   8 +
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts     | 160 ++++
 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts   | 846 ++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts      | 566 ++++++++++++
 arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts | 207 +++++
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts       |   2 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts      |  22 +
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts       |  14 +
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts         | 966 +++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts        | 224 +++++
 arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts   |  14 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts         | 123 ++-
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts       |   5 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   8 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |  11 +-
 arch/arm/boot/dts/ibm-power9-dual.dtsi             | 248 ++++++
 17 files changed, 3417 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-lenovo-hr630.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-microsoft-olympus.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
 create mode 100644 arch/arm/boot/dts/ibm-power9-dual.dtsi
