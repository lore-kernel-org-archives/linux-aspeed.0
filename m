From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 12 Jul 2019 13:07:24 +0930
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Enable SD controllers
Message-ID: <20190712033726.25237-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

v2 drops the "Swift" patch that accidentally modified witherspoon.dts instead
(thanks Joel), and leaves sdhci1 disabled on the EVB. v1 of the series can be
found here:

https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/001984.html

v2 reflects some of the changes driven by Rob's review of the bindings document
in v1 of the driver series:

https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/001994.html

As ever, please review!

Andrew

Andrew Jeffery (2):
  ARM: dts: aspeed: Describe SD controllers
  ARM: dts: aspeed: Enable first MMC slot on AST2500 EVB

 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 11 ++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi         | 28 ++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi         | 28 ++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

-- 
2.20.1

