From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 12 Oct 2020 11:31:47 +0800
Subject: [V2 PATCH 0/3] Fix the memory layout and add sgpio node for aspeed g6
Message-ID: <20201012033150.21056-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series is used to add sgpiom and sgpios nodes and add pinctrl 
setting for sgpiom1

v2:
  - Split the change of dts and pinctrl to two commit.
  - Add the compatible string for aspeed,ast2600-sgpiom. 
    aspeed,ast2600-sgpios will implement in the future.

Billy Tsai (3):
  Arm: dts: aspeed-g6: Fix the register range of gpio
  Arm: dts: aspeed-g6: Add sgpio node
  pinctrl: aspeed-g6: Add sgpiom2 pinctrl setting

 .../devicetree/bindings/gpio/sgpio-aspeed.txt |  8 +--
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi      |  5 ++
 arch/arm/boot/dts/aspeed-g6.dtsi              | 54 ++++++++++++++++++-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    | 30 +++++++++--
 4 files changed, 89 insertions(+), 8 deletions(-)

-- 
2.17.1

