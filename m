From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Tue, 10 May 2022 11:49:07 +0800
Subject: [PATCH v2 0/1] spi: aspeed: Update SPI clock frequency configuration
Message-ID: <20220510034908.1855049-1-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series aims to update SPI clock frequency
configuration rule and add SPI clock frequency
calculation method for different ASPEED platforms.

This patch is based on [1] and the patch series [2](v7).
[1]: https://github.com/legoater/linux/commits/openbmc-5.15
[2]: https://patchwork.kernel.org/project/spi-devel-general/list/?series=639867

v2: Merge aspeed_spi_hclk_masks[] into aspeed_spi_hclk_divs[].

Chin-Ting Kuo (1):
  spi: aspeed: Update SPI clock frequency config rule

 drivers/spi/spi-aspeed-smc.c | 167 ++++++++++++++++++++++++++++++-----
 1 file changed, 145 insertions(+), 22 deletions(-)

-- 
2.25.1

