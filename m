From: Joel Stanley <joel@jms.id.au>
Date: Sat, 22 Jun 2019 07:58:46 +0000
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 5.3
Message-ID: <CACPK8XfL-U-BeynGQNBp5rPiv1gzD=7DVzyvrgtoL3njU1Kr_A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi ARM maintainers,

Here are some defconfig updates for the ASPEED machines. I haven't
sent one for a while, so there's a nice collection of drivers to add.

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-5.3-defconfig

for you to fetch changes up to 2d8bf3404bb0e65dffb7326f7fb6e96fa3cee418:

  ARM: configs: multi_v5: Add more ASPEED devices (2019-06-22 17:12:17 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 5.3

Add new drivers to the ASPEED G4 and G5 defconfigs, and to the armv5
multi defconfig.

----------------------------------------------------------------
Joel Stanley (2):
      ARM: configs: aspeed: Add new drivers
      ARM: configs: multi_v5: Add more ASPEED devices

 arch/arm/configs/aspeed_g4_defconfig | 10 ++++++++--
 arch/arm/configs/aspeed_g5_defconfig | 14 ++++++++++++--
 arch/arm/configs/multi_v5_defconfig  |  8 ++++++++
 3 files changed, 28 insertions(+), 4 deletions(-)
