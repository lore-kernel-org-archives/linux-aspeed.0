From: Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Aug 2023 12:27:55 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 6.6
Message-ID: <CACPK8Xc76O5kLEAXRtbFXZcP=ObrKR0Kpez_er+zV2vZffZe7A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Soc team,

Here are the aspeed device tree changes for v6.6.

The tag has a -2 as I had a typo in the first tag. I removed that tag
from the repo.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-6.6-devicetree-2

for you to fetch changes up to 32b7343226e622e36c7b241f3c6513f396a5a185:

  ARM: dts: aspeed: Add AST2600 I3C control pins (2023-08-10 21:39:42 +0930)

----------------------------------------------------------------
ASPEED device tree updates for 6.6

 - New machines

  * Inventec's Starscream AST2600 BMC, for a x86 server platform
  * Meta's Yossemite 4 AST2600 BMC, for a multi-node server platform

 - Big device tree rework for IBM's Power10 BMC platforms

 - Updates for wedge400 and Mt Mitchell

 - AST2600 I3C and VUART descriptions

----------------------------------------------------------------
Chanh Nguyen (3):
      ARM: dts: aspeed: mtmitchell: Enable the BMC UART8 and UART9
      ARM: dts: aspeed: mtmitchell: Update ADC sensors for Mt.Mitchell
DVT systems
      ARM: dts: aspeed: mtmitchell: Add MCTP

Chen PJ (2):
      dt-bindings: arm: aspeed: add Inventec starscream-bmc
      ARM: dts: aspeed: Adding Inventec Starscream BMC

Delphine CC Chiu (2):
      dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
      ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC

Dylan Hung (1):
      ARM: dts: aspeed: Add AST2600 I3C control pins

Eddie James (3):
      ARM: dts: aspeed: bonnell: Add DIMM SPD
      ARM: dts: aspeed: Add P10 FSI descriptions
      ARM: dts: aspeed: everest: Reorganise FSI description

Joel Stanley (4):
      ARM: dts: aspeed: Add AST2600 VUARTs
      ARM: dts: aspeed: bonnell: Reorganise FSI description
      ARM: dts: aspeed: rainier: Reorganise FSI description
      ARM: dts: aspeed: everest: Move common devices up

Lakshmi Yadlapati (1):
      ARM: dts: aspeed: rainier: Remove TPM device

Tao Ren (3):
      ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
      ARM: dts: aspeed: wedge400: Enable more ADC channels
      ARM: dts: aspeed: wedge400: Set eMMC max frequency

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    2 +
 arch/arm/boot/dts/aspeed/Makefile                  |    2 +
 .../dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts    |  129 +-
 .../dts/aspeed/aspeed-bmc-facebook-wedge400.dts    |    4 +-
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   |  624 +++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |  364 +---
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts | 1837 ++++++++++++--------
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts |  683 +-------
 .../dts/aspeed/aspeed-bmc-inventec-starscream.dts  |  389 +++++
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   10 +
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   20 +
 .../dts/aspeed/ast2500-facebook-netbmc-common.dtsi |    4 +
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     |  380 ++++
 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi     | 1305 ++++++++++++++
 14 files changed, 3924 insertions(+), 1829 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi
