From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 28 Sep 2020 15:01:07 +0800
Subject: [PATCH 0/1] Modify ASPEED SoC some default clks are critical
Message-ID: <20200928070108.14040-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch is modify for ASPEED SoC some default clks can't disable
need keep default clk on.

Ryan Chen (1):
  clk: aspeed: modify some default clks are critical

 drivers/clk/clk-aspeed.c  | 8 ++++----
 drivers/clk/clk-ast2600.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.17.1

