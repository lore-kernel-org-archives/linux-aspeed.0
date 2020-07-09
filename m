From: Eddie James <eajames@linux.ibm.com>
Date: Thu,  9 Jul 2020 14:57:04 -0500
Subject: [PATCH 0/2] clk: Aspeed: Fix eMMC clock speeds
Message-ID: <20200709195706.12741-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There were two problems affecting clock speeds to the eMMC chip. Firstly, the
AST2600 clock was not muxed correctly to be derived from the MPLL. Secondly,
the SDHCI clock control divider was not calculated correctly. This series
addresses these problems.

Eddie James (2):
  clk: AST2600: Add mux for EMMC clock
  mmc: sdhci-of-aspeed: Fix clock divider calculation

 drivers/clk/clk-ast2600.c          | 49 +++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-of-aspeed.c |  2 +-
 2 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.24.0

