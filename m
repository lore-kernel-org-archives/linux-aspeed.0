From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Fri, 16 Oct 2020 14:25:59 +0800
Subject: [PATCH 0/3] Extend peci feature
Message-ID: <20201016062602.20014-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series extend the peci to support 64byte mode and simplify
the setting of peci operation rate. 

Billy Tsai (3):
  peci: aspeed: make the driver support 64byte mode
  peci: aspeed: Auto calculate the adapter divisor
  dt-bindings: Change the meaning of clock-frequency

 .../devicetree/bindings/peci/peci-aspeed.yaml |  56 +++----
 arch/arm/boot/dts/aspeed-g6.dtsi              |   4 +-
 drivers/peci/busses/peci-aspeed.c             | 158 ++++++++++++------
 3 files changed, 136 insertions(+), 82 deletions(-)

-- 
2.17.1

