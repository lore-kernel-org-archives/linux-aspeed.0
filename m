From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Thu, 14 Apr 2022 18:28:28 +0800
Subject: [PATCH 0/1] spi: aspeed: Update SPI clock frequency configuration
Message-ID: <20220414102829.3892843-1-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series aims to update SPI clock frequency
configuration rule and add SPI clock frequency
calculation method for different ASPEED platforms.

This patch is based on [1] and the patch series [2].
[1]: https://github.com/legoater/linux/commits/openbmc-5.15
[2]: https://patchwork.kernel.org/project/spi-devel-general/list/?series=626283


Chin-Ting Kuo (1):
  spi: aspeed: Update SPI clock frequency configuration

 drivers/spi/spi-aspeed-smc.c | 166 +++++++++++++++++++++++++++++++----
 1 file changed, 149 insertions(+), 17 deletions(-)

-- 
2.25.1

