From: Joel Stanley <joel@jms.id.au>
Date: Mon, 2 May 2022 06:42:03 +0000
Subject: [GIT PULL] ARM: aspeed: Fixes for v5.18
Message-ID: <CACPK8XdhLfafOfqvR0r7p6V6AhtNXD4uZGaz7Y+Y4P-rc9p0tQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Soc maintainers,

Here are some device tree fixes that I have for v5.18. They have been
ready since the merge window closed but I've not been available to
send the pull earlier. If you'd prefer not to take them now then I
understand.

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
tags/aspeed-v5.18-fixes

for you to fetch changes up to 32e62d1beab70d485980013312e747a25c4e13f7:

  ARM: dts: aspeed: Add video engine to g6 (2022-04-13 11:53:53 +0930)

----------------------------------------------------------------
ASPEED device tree fixes for v5.18

 - Quad SPI device tree corrections

 - Reinstate GFX node that was removed

 - romed8hm3 machine fixes

----------------------------------------------------------------
Howard Chiu (1):
      ARM: dts: aspeed: Add video engine to g6

Jae Hyun Yoo (5):
      ARM: dts: aspeed-g6: remove FWQSPID group in pinctrl dtsi
      pinctrl: pinctrl-aspeed-g6: remove FWQSPID group in pinctrl
      dt-bindings: pinctrl: aspeed-g6: remove FWQSPID group
      dt-bindings: pinctrl: aspeed-g6: add FWQSPI function/group
      ARM: dts: aspeed-g6: fix SPI1/SPI2 quad pin group

Johnny Huang (2):
      pinctrl: pinctrl-aspeed-g6: add FWQSPI function-group
      ARM: dts: aspeed-g6: add FWQSPI group in pinctrl dtsi

Zev Weiss (2):
      ARM: dts: aspeed: romed8hm3: Add lm25066 sense resistor values
      ARM: dts: aspeed: romed8hm3: Fix GPIOB0 name

 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c              | 17 ++++++++---------
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml        |  4 ++--
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts       |  4 +++-
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi                | 10 +++++-----
 arch/arm/boot/dts/aspeed-g6.dtsi                        | 10 ++++++++++
 5 files changed, 28 insertions(+), 17 deletions(-)
