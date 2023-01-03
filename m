From: ryan_chen <ryan_chen@aspeedtech.com>
Date: Tue, 3 Jan 2023 17:37:00 +0800
Subject: [PATCH 0/2] Add ASPEED AST2600 miss pinctrl
Message-ID: <20230103093702.2613574-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series add AST2600 pinctrl miss parts.
And also update AST2600 pinctrl dtsi.

ryan_chen (2):
  pinctrl:aspeed: add miss pin and function
  dtsi:aspeed: add miss pinctrl in pinctrl dtsi

 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   | 216 +++++++++++++
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 341 +++++++++++++++------
 2 files changed, 455 insertions(+), 102 deletions(-)

-- 
2.34.1

