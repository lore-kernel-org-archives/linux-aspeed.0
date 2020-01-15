From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 15 Jan 2020 13:26:37 -0800
Subject: [PATCH 0/2] clk: aspeed/ast2600: Add critical clock setting logic
Message-ID: <20200115212639.4998-1-jae.hyun.yoo@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This commit adds critical clock setting logic that applies
CLK_IS_CRITICAL flag if it detects 'clock-critical' property in
device tree. With this patch, each platform can enable critical clocks
through device tree setting like below:

&syscon {
	clock-critical = <ASPEED_CLK_GATE_BCLK>,
			 <ASPEED_CLK_GATE_MCLK>,
			 <ASPEED_CLK_GATE_REFCLK>;
};

Please review.

Thanks,

Jae

Jae Hyun Yoo (2):
  clk: aspeed: add critical clock setting logic
  clk: ast2600: add critical clock setting logic

 drivers/clk/clk-aspeed.c  | 5 ++++-
 drivers/clk/clk-ast2600.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.17.1

