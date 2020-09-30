From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 30 Sep 2020 12:08:20 +0800
Subject: [PATCH 0/3] Enable USB host for AST2600
Message-ID: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patches enable UHCI driver in AST2600 and also enable
USB host in aspeed-ast2600-evb.dts.

Ryan Chen (3):
  configs: aspeed: enable UHCI driver in defconfig
  usb: host: add uhci compatible support for ast2600-uhci
  ARM: dts: add ehci uhci enable in evb dts

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 8 ++++++++
 arch/arm/configs/aspeed_g5_defconfig     | 1 +
 drivers/usb/host/uhci-platform.c         | 3 ++-
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.17.1

