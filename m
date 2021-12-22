From: Joel Stanley <joel@jms.id.au>
Date: Wed, 22 Dec 2021 01:55:38 +0000
Subject: [GIT PULL] ARM: aspeed: soc changes for 5.17
Message-ID: <CACPK8Xc6q=N6iFLnHt8RHhxvBhqu73WN9jBvitbwU3L6SJv85Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are the aspeed soc changes for v5.17.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.17-soc

for you to fetch changes up to 79ee56da2e4f49adf174dd7a2e10ce488506c865:

  ARM: aspeed: Add secure boot controller support (2021-12-21 15:56:30 +1030)

----------------------------------------------------------------
ASPEED soc updates for 5.17

 * Fix for deferred probing of LPC clock

 * Display secure boot status when on AST2600

----------------------------------------------------------------
Jae Hyun Yoo (1):
      soc: aspeed: lpc-ctrl: Block error printing on probe defer cases

Joel Stanley (1):
      ARM: aspeed: Add secure boot controller support

 drivers/soc/aspeed/aspeed-lpc-ctrl.c |  7 ++--
 drivers/soc/aspeed/aspeed-socinfo.c  | 73 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 4 deletions(-)
