From: Tao Ren <taoren@fb.com>
Date: Mon, 21 Oct 2019 12:48:16 -0700
Subject: [PATCH 0/4] ARM: dts: aspeed: add dtsi for Facebook AST2500 Network
 BMCs
Message-ID: <20191021194820.293556-1-taoren@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch series adds "facebook-netbmc-ast2500-common.dtsi" which defines
devices that are common cross all Facebook AST2500 Network BMC platforms.
The major purpose is to minimize duplicated device entries among Facebook
Network BMC dts files.

Patch #1 (of 4) adds "facebook-netbmc-ast2500-common.dtsi" file, and the
remaining 3 patches update CMM, Minipack and Yamp device tree to consume
the new dtsi file.

Tao Ren (4):
  ARM: dts: aspeed: add dtsi for Facebook AST2500 Network BMCs
  ARM: dts: aspeed: cmm: include dtsi for common network BMC devices
  ARM: dts: aspeed: minipack: include dtsi for common network BMC
    devices
  ARM: dts: aspeed: yamp: include dtsi for common network BMC devices

 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 66 ++++---------
 .../boot/dts/aspeed-bmc-facebook-minipack.dts | 59 ++++--------
 .../arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 62 +-----------
 .../dts/facebook-netbmc-ast2500-common.dtsi   | 96 +++++++++++++++++++
 4 files changed, 136 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/boot/dts/facebook-netbmc-ast2500-common.dtsi

-- 
2.17.1

