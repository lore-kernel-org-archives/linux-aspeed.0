From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Tue, 29 Mar 2022 01:38:41 +0000
Subject: [PATCH v3 0/2] Enable ast2600-evb KVM
Message-ID: <SG2PR06MB2315A39490DD5282FC6CF2ABE61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Change since v2:
1. Add video engine node back which was removed by commit 645afe7 unintentionally.

Change since v1:
1. Remove video engine node which was added by commit bcee389.
2. Remove reset definition because the reset is handled by clk-ast2600 driver currently.

Howard Chiu (2):
  ARM: dts: aspeed: Add video engine
  ARM: dts: aspeed: ast2600-evb: Support KVM

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 39 +++++++++++++++++++-----
 arch/arm/boot/dts/aspeed-g6.dtsi         | 10 ++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

-- 
2.25.1

