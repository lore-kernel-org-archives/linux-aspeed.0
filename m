From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Sun, 18 Jul 2021 17:17:20 -0700
Subject: [PATCH 0/4] ARM: dts: aspeed: Enable ADC for wedge100 BMC
Message-ID: <20210719001724.6410-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series enables ADC for Facebook Wedge100 BMC platform.

Patch #1 enables ADC in Facebook AST2400 common dtsi because ADC is used
on all the Facebook AST2400 Network BMC platforms.

Patch #2 removes the redundant ADC entry from Wedge40 dts.

Patch #3 removes the redundant ADC entry from Galaxy100 dts.

Patch #4 enables the ADC voltage sensoring channels in Wedge100 dts.

Tao Ren (4):
  ARM: dts: aspeed: Enable ADC in Facebook AST2400 common dtsi
  ARM: dts: aspeed: wedge40: Remove redundant ADC device
  ARM: dts: aspeed: galaxy100: Remove redundant ADC device
  ARM: dts: aspeed: wedge100: Enable ADC channels

 arch/arm/boot/dts/aspeed-bmc-facebook-galaxy100.dts   | 4 ----
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts    | 5 +++++
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts     | 4 ----
 arch/arm/boot/dts/ast2400-facebook-netbmc-common.dtsi | 4 ++++
 4 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.17.1

