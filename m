From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Aug 2021 06:57:24 +0000
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 5.15
Message-ID: <CACPK8XdzKdnyrpjKukGWieBhLgQnBs+y=LuSr_weot=Ovy3+9A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Soc maintainers,

This is the last of the aspeed pull requests for v5.15.

Apologies for drip feeding them, I was pressed for time so I started
with the most important and worked down the list.

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.15-defconfig

for you to fetch changes up to a4836d5ad127fe31fecb29878d81f2e9b4a5591c:

  ARM: config: aspeed: Regenerate defconfigs (2021-08-19 16:33:43 +0930)

----------------------------------------------------------------
ASPEED defconfig updates for 5.15

 - Enable new KCS SerIO driver

 - Enable SGPIO and EDAC for AST2400 now they are supported there

 - Switch to SLUB and enable SLAB_FREELIST_HARDENED

 - Regenerate defconfigs atop v5.14-rc2

----------------------------------------------------------------
Joel Stanley (4):
      ARM: config: aspeed: Enable hardened allocator feature
      ARM: config: aspeed: Enable KCS adapter for raw SerIO
      ARM: config: aspeed_g4: Enable EDAC and SPGIO
      ARM: config: aspeed: Regenerate defconfigs

 arch/arm/configs/aspeed_g4_defconfig | 16 +++++-----------
 arch/arm/configs/aspeed_g5_defconfig | 25 +++++++++----------------
 2 files changed, 14 insertions(+), 27 deletions(-)
