From: Steven Lee <steven_lee@aspeedtech.com>
Date: Tue, 25 May 2021 13:53:04 +0800
Subject: [PATCH v3 0/3] pinctrl: pinctrl-g6: Add the 2nd sgpio
Message-ID: <20210525055308.31069-1-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

AST2600 has 2 SGPIO master interfaces one with 128 pins and another one
has 80 pins, it also supports 2 SGPIO slave interfaces.
However, there is only the first sgpio master/slave interface defined in
dtsi and pinctrl driver.
The patch series adds the second SGPIO master and slave interfaces
in dt-bindings, dtsi and pinctrl driver.

Changes from v2:
* Fix the typo of the commit message of the 3rd patch.

Changes from v1:
* Correct the function priority of multi-function pin.
* Change the name of arguments of PIN_DECL_4.

Please help to review.

Thanks,
Steven

Steven Lee (3):
  dt-bindings: pinctrl: Update enum for adding SGPM2 and SGPS2
  ARM: dts: aspeed-g6: Add pinctrl settings
  pinctrl: pinctrl-aspeed-g6: Add sgpio pinctrl settings

 .../pinctrl/aspeed,ast2600-pinctrl.yaml       | 10 ++++----
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi      | 10 ++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c    | 24 +++++++++++++++----
 drivers/pinctrl/aspeed/pinmux-aspeed.h        |  9 +++++++
 4 files changed, 44 insertions(+), 9 deletions(-)

-- 
2.17.1

