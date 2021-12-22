From: Joel Stanley <joel@jms.id.au>
Date: Wed, 22 Dec 2021 01:54:19 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.17
Message-ID: <CACPK8Xd1RfMLRbwBWqo8nm=w0V2AubmzraVW3h==XBcs21+mnA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

Here are the aspeed device tree changes for v5.17.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.17-devicetree

for you to fetch changes up to 45cd8bbaaa18ab1c4f4387529db72b33be463197:

  ARM: dts: aspeed: add LCLK setting into LPC KCS nodes (2021-12-21
15:33:10 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.17

 - New machines:

  * TYAN S8036 AST2500 BMC
  * Facebook Bletchley AST2600 BMC
  * Yadro VEGMAN series of AST2500 BMC for x86 servers

 - LPC clock additions, to fix long standing missed irq on boot issue

 - Secure boot controller description for AST2600

 - Alternate chip flash layout, used by Bytedance's G220A

 - Various additions to Rainier, Everest, S7106

----------------------------------------------------------------
Ali El-Haj-Mahmoud (1):
      ARM: dts: aspeed: Add TYAN S8036 BMC machine

Andrei Kartashev (2):
      dt-bindings: vendor-prefixes: add YADRO
      ARM: dts: aspeed: add device tree for YADRO VEGMAN BMC

Eddie James (2):
      ARM: dts: aspeed: p10: Enable USB host ports
      ARM: dts: aspeed: p10: Add TPM device

Howard Chiu (1):
      ARM: dts: aspeed: Adding Facebook Bletchley BMC

Jae Hyun Yoo (3):
      ARM: dts: aspeed: add LCLK setting into LPC IBT node
      dt-bindings: ipmi: bt-bmc: add 'clocks' as a required property
      ARM: dts: aspeed: add LCLK setting into LPC KCS nodes

Joel Stanley (2):
      dt-bindings: aspeed: Add Secure Boot Controller bindings
      ARM: dts: aspeed: Add secure boot controller node

Lei YU (2):
      ARM: dts: Add openbmc-flash-layout-64-alt.dtsi
      ARM: dts: aspeed: g220a: Enable secondary flash

Oskar Senft (2):
      ARM: dts: aspeed: tyan-s7106: Update nct7802 config
      ARM: dts: aspeed: tyan-s7106: Add uart_routing and fix vuart config

Quan Nguyen (2):
      ARM: dts: aspeed: mtjade: Add I2C buses for NVMe devices
      ARM: dts: aspeed: mtjade: Add uefi partition

 .../devicetree/bindings/arm/aspeed/aspeed,sbc.yaml |  37 +
 .../bindings/ipmi/aspeed,ast2400-ibt-bmc.txt       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts     | 267 ++++++++
 arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts   |  12 +
 .../arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 756 +++++++++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts       |  17 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       |  11 +
 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts        |  40 ++
 arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts        | 470 +++++++++++++
 arch/arm/boot/dts/aspeed-bmc-vegman-n110.dts       | 149 ++++
 arch/arm/boot/dts/aspeed-bmc-vegman-rx20.dts       | 255 +++++++
 arch/arm/boot/dts/aspeed-bmc-vegman-sx20.dts       | 154 +++++
 arch/arm/boot/dts/aspeed-bmc-vegman.dtsi           | 311 +++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   1 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   5 +
 arch/arm/boot/dts/aspeed-g6.dtsi                   |  10 +
 arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi |  35 +
 19 files changed, 2539 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-tyan-s8036.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-vegman-n110.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-vegman-rx20.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-vegman-sx20.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-vegman.dtsi
 create mode 100644 arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi
