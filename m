From: Joel Stanley <joel@jms.id.au>
Date: Mon, 30 Nov 2020 06:30:44 +0000
Subject: [GIT PULL] ARM: aspeed: soc changes for 5.11
Message-ID: <CACPK8Xfd7AmuEaUdFfYLu4ktcrpTnYUgwQSxUbC-McB02hvo_g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are some ASPEED changes for the 5.11 merge window.

The following changes since commit 2ba56f464f0c1a7264160f8675063b3df92e7966:

  ARM: dts: aspeed: ast2600evb: Add MAC0 (2020-11-19 22:31:18 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.11-devicetree

for you to fetch changes up to 2ba56f464f0c1a7264160f8675063b3df92e7966:

  ARM: dts: aspeed: ast2600evb: Add MAC0 (2020-11-19 22:31:18 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.11

 - New machines

   * Bytedance G220A, an AST2500 BMC for an x86 server
   * Facebook Galaxy100, an AST2400 BMC for a network switch
   * IBM Rainier 4U, an AST2600 BMC for a PowerPC server

 - Reworking of Facebook device trees to use common dtsi

 - A 64MB flash layout used by the G220A

 - Misc updates to tiogapass, ethanolx, s2600wf, tacoma and rainier

----------------------------------------------------------------
Andrew Jeffery (4):
      ARM: dts: tacoma: Fix node vs reg mismatch for flash memory
      ARM: dts: rainier: Add reserved memory for ramoops
      ARM: dts: tacoma: Add reserved memory for ramoops
      ARM: dts: aspeed: rainier: Don't shout addresses

Billy Tsai (1):
      ARM: dts: aspeed-g6: Fix the GPIO memory size

Eddie James (2):
      ARM: dts: aspeed: rainier: Add 4U device-tree
      ARM: dts: aspeed: rainier: Mark FSI SPI controllers as restricted

George Liu (1):
      ARM: dts: Fix label address for 64MiB OpenBMC flash layout

Joel Stanley (2):
      ARM: dts: aspeed: s2600wf: Fix VGA memory region location
      ARM: dts: aspeed: ast2600evb: Add MAC0

John Wang (2):
      ARM: dts: Add 64MiB OpenBMC flash layout
      ARM: dts: aspeed: g220a: Add some gpios

Konstantin Aladyshev (4):
      ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to use v2 binding
      ARM: dts: aspeed: amd-ethanolx: Enable KCS channel 3
      ARM: dts: aspeed: amd-ethanolx: Enable devices for the iKVM functionality
      ARM: dts: aspeed: amd-ethanolx: Add GPIO line names

Lotus Xu (1):
      ARM: dts: aspeed: Add Bytedance g220a BMC machine

Paul Fertser (1):
      arm: dts: aspeed: tiogapass: Enable second MAC

Tao Ren (6):
      ARM: dts: aspeed: Common dtsi for Facebook AST2400 Network BMCs
      ARM: dts: aspeed: wedge40: Use common dtsi
      ARM: dts: aspeed: wedge100: Use common dtsi
      ARM: dts: aspeed: Add Facebook Galaxy100 (AST2400) BMC
      ARM: dts: aspeed: wedge400: Fix FMC flash0 layout
      ARM: dts: aspeed: minipack: Fixup I2C tree

Vijay Khemka (1):
      ARM: dts: aspeed: tiogapass: Remove vuart
