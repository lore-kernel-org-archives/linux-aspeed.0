From: Joel Stanley <joel@jms.id.au>
Date: Mon, 30 Nov 2020 06:41:35 +0000
Subject: [GIT PULL] ARM: aspeed: actually the soc changes for 5.11
Message-ID: <CACPK8Xe=9ezhyWRMqVOEQr7SU1YoYfVBGGdGzjmE4SiBr--vJQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are some ASPEED SoC changes for the v5.11 merge window.

These are mostly the 5.10 changes without the XDMA driver, which I
didn't get a response on my question about where we wanted that to
live[1]

https://lore.kernel.org/linux-arm-kernel/CACPK8XcLOopkx0k14k25puD3YkwHzZS0+3TLcEL43xbxCZBphA at mail.gmail.com/

The following changes since commit 4da595ddc06909d9ba8fcedcce0c4e1e0a4c3244:

  soc: aspeed: Enable drivers with ARCH_ASPEED (2020-11-19 23:01:36 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.11-soc

for you to fetch changes up to 4da595ddc06909d9ba8fcedcce0c4e1e0a4c3244:

  soc: aspeed: Enable drivers with ARCH_ASPEED (2020-11-19 23:01:36 +1030)

----------------------------------------------------------------
ASPEED soc driver updates for 5.11

New drivers:

 - SoC info driver to expose revision information

New features:

 - AST2600 support for the LPC control driver. This includes
   setting the LPC2AHB bridge up in a backwards compatible manner.

Cleanups:

 - LPC control
 - Kconfig
 - Bindings updates for AST2600 strings

----------------------------------------------------------------
Andrew Jeffery (1):
      soc: aspeed-lpc-ctrl: Fail probe of lpc-ctrl if reserved memory
is not aligned

Brad Bishop (2):
      dt-bindings: aspeed-lpc: Add AST2600 compatible strings
      soc: aspeed: lpc: Add AST2600 compatible strings

Dan Carpenter (1):
      soc: aspeed: Fix a reference leak in aspeed_socinfo_init()

Joel Stanley (8):
      soc: aspeed: Improve kconfig
      dt-bindings: aspeed: Add silicon id node to SCU
      soc: aspeed: Add soc info driver
      ARM: dts: aspeed: Add silicon id node
      soc: aspeed-lpc-ctrl: LPC to AHB mapping on ast2600
      soc: aspeed-lpc-ctrl: Fix whitespace
      soc: aspeed-lpc-ctrl: Fix driver name
      soc: aspeed: Enable drivers with ARCH_ASPEED

Tom Rix (1):
      soc: aspeed: remove unneeded semicolon
