From: Joel Stanley <joel@jms.id.au>
Date: Wed, 10 Feb 2021 12:28:23 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.12
Message-ID: <CACPK8XfQgGch5bK3YD0La+CE2L5DxVa1MNw6m1fc40j0w7e9Tw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here's my late pull request. I've deferred some LPC device tree
bindings rework that need a closer review, so the contents of this
pull request should be straightforward.

The following changes since commit a74c6525f12f35a5af529ff057e63cfdc461704c:

  ARM: dts: aspeed: ast2600evb: Add enable ehci and uhci (2021-02-10
21:21:36 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.12-devicetree

for you to fetch changes up to a74c6525f12f35a5af529ff057e63cfdc461704c:

  ARM: dts: aspeed: ast2600evb: Add enable ehci and uhci (2021-02-10
21:21:36 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.12

 - New machines

  * Ampere Mt. Jade, an AST2500 BMC for an x86 server
  * IBM Everest, an AST2600 BMC for a Power10 server
  * Supermicro x11spi, an AST2500 BMC for an ARM server

 - AST2600 eMMC clock phase configuration

 - Proper clock support for LPC snoop

 - Misc updates to ethanolx, mowgli, ast2600evb, g220a, and rainier

----------------------------------------------------------------
Andrew Jeffery (1):
      ARM: dts: aspeed: rainier: Add eMMC clock phase compensation

Ben Pai (1):
      ARM: dts: aspeed: mowgli: Add i2c rtc device

Eddie James (1):
      ARM: dts: aspeed: Add Everest BMC machine

George Liu (2):
      ARM: dts: aspeed: inspur-fp5280g2: Add GPIO line names
      ARM: dts: aspeed: inspur-fp5280g2: Add ipsps1 driver

John Wang (2):
      ARM: dts: aspeed: Add LCLK to lpc-snoop
      ARM: dts: aspeed: g220a: Fix some gpio

Konstantin Aladyshev (1):
      ARM: dts: aspeed: amd-ethanolx: Enable secondary LPC snooping address

Lotus Xu (1):
      ARM: dts: aspeed: g220a: Enable ipmb

Quan Nguyen (1):
      ARM: dts: aspeed: Add device tree for Ampere's Mt. Jade BMC

Ryan Chen (1):
      ARM: dts: aspeed: ast2600evb: Add enable ehci and uhci

Ryan Sie (1):
      ARM: dts: aspeed: Add Supermicro x11spi BMC machine
