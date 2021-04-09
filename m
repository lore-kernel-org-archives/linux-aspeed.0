From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Apr 2021 06:29:52 +0000
Subject: [GIT PULL] ARM: aspeed: lpc changes for 5.13
Message-ID: <CACPK8Xcb12LsVr7CUaXXjQskKbVjb7x+jgueG1Hik-kBPWtDSg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

This is a pull request containing a slightly messy device tree and
associated driver changes for the ASPEED systems. It corrects some
design decisions made when first mainlining support for the BMC
devices on the LPC bus that have stopped us from being able to write
drivers for eg. KCS.

Andrew has worked with Chai-Wei from ASPEED on this process. These set
of changes have acks from the maintainers, and allow Andrew to go
ahead with fixing the KCS drivers in the future. The branch should
apply with no conflicts no matter which order it is merged.

If you would like to handle this another way then let me know.

The following changes since commit 489774ff5db943642751f4f0fdac9033239208c6:

  soc: aspeed: Adapt to new LPC device tree layout (2021-04-09 13:39:22 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.13-lpc

for you to fetch changes up to 489774ff5db943642751f4f0fdac9033239208c6:

  soc: aspeed: Adapt to new LPC device tree layout (2021-04-09 13:39:22 +0930)

----------------------------------------------------------------
ASPEED LPC updates for 5.13

These patches fix the ASPEED LPC bindings and LPC-related device drivers
so in the future the KCS driver can properly use the hardware.

----------------------------------------------------------------
Chia-Wei, Wang (5):
      dt-bindings: aspeed-lpc: Remove LPC partitioning
      ARM: dts: Remove LPC BMC and Host partitions
      ipmi: kcs: aspeed: Adapt to new LPC DTS layout
      pinctrl: aspeed-g5: Adapt to new LPC device tree layout
      soc: aspeed: Adapt to new LPC device tree layout
