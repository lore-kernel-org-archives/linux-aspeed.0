From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Sep 2020 06:33:00 +0000
Subject: [GIT PULL] ARM: aspeed: defconfig changes for 5.10
Message-ID: <CACPK8XdFE2K1_cyrg=uaD6CaOm_p0RCRmjAsu6uyFKD4rnDggQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are some ASPEED defconfig changes for 5.10. Please pull them!

The following changes since commit 74976e861309e4bf7f3e7e93f56ca3a6e0e1eca9:

  ARM: config: aspeed_g5: Enable IBM OP Panel driver (2020-09-11 15:25:24 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.10-defconfig

for you to fetch changes up to 74976e861309e4bf7f3e7e93f56ca3a6e0e1eca9:

  ARM: config: aspeed_g5: Enable IBM OP Panel driver (2020-09-11 15:25:24 +0930)

----------------------------------------------------------------
ASPEED defconfig updates for 5.10

 - Fix an issue with unwanted media drivers being enabled

 - New driver: IBM OP Panel, used on ast2600 systems. This requires
   enabling I2C slave mode

 - Enable I2C MUX GPIO driver

----------------------------------------------------------------
Joel Stanley (3):
      ARM: config: aspeed: Fix selection of media drivers
      ARM: config: aspeed-g5: Enable I2C GPIO mux driver
      ARM: config: aspeed_g5: Enable IBM OP Panel driver

 arch/arm/configs/aspeed_g5_defconfig | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)
