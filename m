From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Jul 2019 23:43:22 +0930
Subject: [PATCH 0/3] ARM: configs: aspeed-g5: SD Controller support
Message-ID: <20190710141325.20888-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series adds SD controller related bits to the aspeed_g5_defconfig.

Please review!

Andrew

Andrew Jeffery (1):
  ARM: config: aspeed-g5: Refresh on 5.2

Joel Stanley (1):
  ARM: config: aspeed-g5: Enable EXT4, VFAT

Ryan Chen (1):
  ARM: config: aspeed-g5: Enable SD Controller

 arch/arm/configs/aspeed_g5_defconfig | 64 ++++++++++++++--------------
 1 file changed, 32 insertions(+), 32 deletions(-)

-- 
2.20.1

