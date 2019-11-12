From: Joel Stanley <joel@jms.id.au>
Date: Tue, 12 Nov 2019 16:58:52 +1030
Subject: [PATCH 0/5] ARM: config: ASPEED updates for 5.5
Message-ID: <20191112062857.32638-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Here are some additions to the defconfigs for ASPEED machines that I
intend on sending for 5.5.

If you have time to ack them that would be appreciated.

Joel Stanley (5):
  ARM: config: aspeed-g5: Enable 8250_DW quirks
  ARM: config: aspeed-g5: Add SGPIO and FSI drivers
  ARM: config: aspeed-g4: Add MMC, and cleanup
  ARM: configs: multi_v7: ASPEED network, gpio, FSI
  ARM: config: multi_v5: ASPEED SDHCI, SGPIO

 arch/arm/configs/aspeed_g4_defconfig | 18 ++++++++++++------
 arch/arm/configs/aspeed_g5_defconfig |  4 ++++
 arch/arm/configs/multi_v5_defconfig  |  4 ++++
 arch/arm/configs/multi_v7_defconfig  |  9 +++++++++
 4 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.24.0

