From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 8 Oct 2020 09:51:04 +0800
Subject: [PATCH 0/2] Fix the memory layout and add sgpio node for aspeed g6
Message-ID: <20201008015106.3198-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix the memory layout and add sgpio node for aspeed g6

Billy Tsai (2):
  Arm: dts: aspeed-g6: Fix the register range of gpio
  Arm: dts: aspeed-g6: Add sgpio node and pinctrl setting

 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   |  5 ++
 arch/arm/boot/dts/aspeed-g6.dtsi           | 55 +++++++++++++++++++++-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 30 ++++++++++--
 3 files changed, 85 insertions(+), 5 deletions(-)

-- 
2.17.1

