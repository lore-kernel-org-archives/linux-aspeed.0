From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Mon, 30 Sep 2024 15:04:51 +0800
Subject: [PATCH v1 0/8] Add I2C mux devices for yosemite4
Message-ID: <20240930070500.3174431-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- v1
 - Add i2c-mux for ADC monitor on Spider Board.
 - Revise adc128d818 adc mode on Fan Boards.
 - Change the address of Fan IC on fan boards.
 - Correct the compatible string for max31790.
 - Revise address of i2c-mux for two fan boards.
 - Add i2c-mux for CPLD IOE on Spider Board.
 - Add i2c-mux for four NICs.
 - Add i2c-mux for all Server Board slots.

Ricky CX Wu (8):
  ARM: dts: aspeed: yosemite4: add i2c-mux for all Server Board slots
  ARM: dts: aspeed: yosemite4: Add i2c-mux for four NICs
  ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE on Spider Board
  ARM: dts: aspeed: yosemite4: Revise address of i2c-mux for two fan
    boards
  ARM: dts: aspeed: yosemite4: correct the compatible string for
    max31790
  ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan
    boards
  ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Fan Boards
  ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider
    Board

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 483 +++++++++++++++---
 1 file changed, 422 insertions(+), 61 deletions(-)

-- 
2.25.1

