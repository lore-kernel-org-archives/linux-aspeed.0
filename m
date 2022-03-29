From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Tue, 29 Mar 2022 03:23:35 +0000
Subject: [PATCH v4 0/3] Enable ast2600-evb KVM
Message-ID: <SG2PR06MB23155BD5153975DE8D863DBCE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Change since v3:
1. Revise commit log
2. Split video engine and HID support into two separate patches

Change since v2:
1. Add video engine node back which was removed by commit 645afe73f951 ("ARM: dts: aspeed: ast2600: Update XDMA engine node") unintentionally.

Change since v1:
1. Remove video engine node which was added by commit bcee38919fa0ae47c4a80ffc7ee751039fe159bf ("ARM: dts: aspeed: ast2600: Add Video Engine node").
2. Remove reset definition because the reset is handled by clk-ast2600 driver currently.

Howard Chiu (3):
  ARM: dts: aspeed: Add video engine
  ARM: dts: aspeed: ast2600-evb: Enable video engine
  ARM: dts: aspeed: ast2600-evb: Enable virtual hub

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi         | 10 ++++++++++
 2 files changed, 33 insertions(+)

-- 
2.25.1

