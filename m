From: Joel Stanley <joel@jms.id.au>
Date: Thu, 19 Aug 2021 16:21:59 +0930
Subject: [PATCH 0/4] ARM: config: aspeed: Defconfig updates
Message-ID: <20210819065203.2620911-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Here are some defconfig updates that we've been using in the openbmc
distro kernel tree for a while now.

Joel Stanley (4):
  ARM: config: aspeed: Enable hardened allocator feature
  ARM: config: aspeed: Enable KCS adapter for raw SerIO
  ARM: config: aspeed_g4: Enable EDAC and SPGIO
  ARM: config: aspeed: Regenerate defconfigs

 arch/arm/configs/aspeed_g4_defconfig | 16 +++++-----------
 arch/arm/configs/aspeed_g5_defconfig | 25 +++++++++----------------
 2 files changed, 14 insertions(+), 27 deletions(-)

-- 
2.32.0

