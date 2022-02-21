From: Joel Stanley <joel@jms.id.au>
Date: Mon, 21 Feb 2022 08:57:57 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.18
Message-ID: <CACPK8XcLpAA7b_hGea-Wc8H5eu9=YpPZ9b75nYF7rqMzDcMw9w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Soc maintainers,

A straightforward pull request of aspeed bits for v5.18.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-5.18-devicetree

for you to fetch changes up to 43fd3d4d95cee85e187e5c4ef1d991f77d4d928c:

  MAINTAINERS: ARM/WPCM450: Add 'W:' line with wiki (2022-02-21 13:00:50 +1030)

----------------------------------------------------------------
ASPEED device tree updates for 5.18

 - New machines

  * Quanta S6Q AST2600 BMC
  * Facebook's Bletchley is not new, but has a large update

 - Small clenaups and additions for Everest, Rainier and Tacoma, and the
   flash layout

----------------------------------------------------------------
Jonathan Neusch?fer (8):
      dt-bindings: arm/npcm: Add binding for global control registers (GCR)
      MAINTAINERS: Match all of bindings/arm/npcm/ as part of NPCM architecture
      ARM: dts: wpcm450: Add global control registers (GCR) node
      ARM: dts: wpcm450: Add pinctrl and GPIO nodes
      ARM: dts: wpcm450: Add pin functions
      ARM: dts: wpcm450-supermicro-x9sci-ln4f: Add GPIO LEDs and buttons
      ARM: dts: wpcm450: Add pinmux information to UART0
      MAINTAINERS: ARM/WPCM450: Add 'W:' line with wiki

 .../devicetree/bindings/arm/npcm/nuvoton,gcr.yaml  |  48 +++
 MAINTAINERS                                        |   2 +
 .../dts/nuvoton-wpcm450-supermicro-x9sci-ln4f.dts  |  43 +++
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi             | 384 +++++++++++++++++++++
 4 files changed, 477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
