From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 Aug 2021 05:31:53 +0000
Subject: [GIT PULL] ARM: aspeed: soc changes for 5.15
Message-ID: <CACPK8XdyT0rCkoeE7x2EQyvFy1Z7ZwFNdm1SQfCG9yC_Z7UbxA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are some soc changes for 5.15.

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.15-soc

for you to fetch changes up to 2f9b25fa668218f22a85ebe8c55d1d132fc0019d:

  soc: aspeed: Re-enable FWH2AHB on AST2600 (2021-08-19 13:59:28 +0930)

----------------------------------------------------------------
ASPEED soc updates for 5.15

 * Two fixes for drivers that control the mapping of BMC memory over
   PCIe and LPC

 * Re-enable FWH2AHB on systems that have it closed off by default

 * A new id for the AST2625, an AST2600 variant

----------------------------------------------------------------
Iwona Winiarska (2):
      soc: aspeed: lpc-ctrl: Fix boundary check for mmap
      soc: aspeed: p2a-ctrl: Fix boundary check for mmap

Joel Stanley (2):
      soc: aspeed: socinfo: Add AST2625 variant
      soc: aspeed: Re-enable FWH2AHB on AST2600

 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 31 ++++++++++++++++++++++++-------
 drivers/soc/aspeed/aspeed-p2a-ctrl.c |  2 +-
 drivers/soc/aspeed/aspeed-socinfo.c  |  1 +
 3 files changed, 26 insertions(+), 8 deletions(-)
