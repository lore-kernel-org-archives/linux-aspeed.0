From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Thu, 26 Sep 2024 11:28:16 +0800
Subject: [PATCH v1 0/5] Add I2C mux on BUS 14 for yosemite4
Message-ID: <20240926032821.4171466-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- v1
  - Add i2c-mux for ADC monitor on Spider Board.
  - Revise adc128d818 adc mode on Fan Boards.
  - Change the address of Fan IC on fan boards.
  - Remove led gpio pca9552 on fan boards.
  - Add i2c mux for for two fan boards.

Ricky CX Wu (5):
  ARM: dts: aspeed: yosemite4: Add i2c-mux for two fan boards
  ARM: dts: aspeed: yosemite4: remove led gpio pca9552 on fan boards
  ARM: dts: aspeed: yosemite4: Change the address of Fan IC on fan
    boards
  ARM: dts: aspeed: yosemite4: Revise adc128d818 adc mode on Fan Boards
  ARM: dts: aspeed: yosemite4: Add i2c-mux for ADC monitor on Spider
    Board

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 131 ++++++++----------
 1 file changed, 55 insertions(+), 76 deletions(-)

-- 
2.25.1

