From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu,  3 Aug 2023 16:03:21 -0700
Subject: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
Message-ID: <20230803230324.731268-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series fixes a few entries in wedge400 device tree.

Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
by wedge400 dts) to make sure spi bus is consistent with flash labels in
flash layout.

Patch #2 enables more ADC channels in wedge400 dts.

Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.

Tao Ren (3):
  ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
  ARM: dts: aspeed: wedge400: Enable more ADC channels
  ARM: dts: aspeed: wedge400: Set eMMC max frequency

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts    | 4 +++-
 arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.40.1

