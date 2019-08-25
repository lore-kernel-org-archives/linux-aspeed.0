From: Joel Stanley <joel@jms.id.au>
Date: Sun, 25 Aug 2019 14:10:39 +0000
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 5.4
Message-ID: <CACPK8XdyWzghA0QPDzA_MK5FYwhT5afqDJHNdhc8mfD2uk8MfQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM Maintainers,

Some bits and pieces for the defconfigs. The multi_v7 one applies to
linux-next with a bit of fuzz, but let us know if you run in to any
issues. I'll be away for this week, but Andrew will be on hand to help
out.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
   tags/aspeed-5.4-defconfig

for you to fetch changes up to 4cdabee7d6d2e439fea726a101e448c4ca6837f4:

  ARM: configs: aspeed_g5: Enable AST2600 (2019-08-25 23:22:54 +0930)

----------------------------------------------------------------
ASPEED defconfig updates for 5.4

 - Enable the new AST2600 in multi_v7 and the aspeed_g5 configs.

 - Regenerate defconfigs to drop old options

 - Clean up network options

----------------------------------------------------------------
Joel Stanley (3):
      ARM: configs: aspeed: Refresh defconfigs
      ARM: configs: multi_v7: Add ASPEED G6
      ARM: configs: aspeed_g5: Enable AST2600

William A. Kennington III (1):
      ARM: configs: aspeed: Enable commonly used network functionality

 arch/arm/configs/aspeed_g4_defconfig | 50 +++++++++++---------------
 arch/arm/configs/aspeed_g5_defconfig | 68 ++++++++++++++++++++----------------
 arch/arm/configs/multi_v7_defconfig  | 19 ++++++++++
 3 files changed, 78 insertions(+), 59 deletions(-)
