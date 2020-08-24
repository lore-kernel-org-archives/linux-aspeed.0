From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 24 Aug 2020 14:19:43 -0700
Subject: [PATCH 0/5] ARM: dts: aspeed: Add Facebook Wedge400 (AST2500) BMC
Message-ID: <20200824211948.12852-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series adds Facebook Wedge400 (AST2500) BMC device tree, and
FMC flash layout is re-structured because flash size and layout varies
across different Facebook AST2500 OpenBMC platforms.

Patch #1 removes flash layout from ast2500-facebook-netbmc-common.dtsi
because now we have 32MB, 64MB an 128MB flashes on different Facebook
AST2500 OpenBMC platforms.

Patch #2, #3 and #4 sets FMC flash layout in CMM, Yamp and Minipack
device tree explicitly because the original layout settings were removed
from ast2500-facebook-netbmc-common.dtsi (in patch #1).

Patch #5 adds Facebook Wedge400 AST2500 BMC device tree.


Tao Ren (5):
  ARM: dts: aspeed: Remove flash layout from Facebook AST2500 Common
    dtsi
  ARM: dts: aspeed: cmm: Set 32MB FMC flash layout
  ARM: dts: aspeed: yamp: Set 32MB FMC flash layout
  ARM: dts: aspeed: minipack: Update 64MB FMC flash layout
  ARM: dts: aspeed: Add Facebook Wedge400 BMC

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts |  17 +
 .../boot/dts/aspeed-bmc-facebook-minipack.dts |  47 +-
 .../boot/dts/aspeed-bmc-facebook-wedge400.dts | 420 ++++++++++++++++++
 .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts |  17 +
 .../dts/ast2500-facebook-netbmc-common.dtsi   |  13 -
 6 files changed, 500 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts

-- 
2.17.1

