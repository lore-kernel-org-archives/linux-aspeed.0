From: Joel Stanley <joel@jms.id.au>
Date: Thu, 5 Sep 2019 00:43:38 +0000
Subject: [GIT PULL] ARM: aspeed: devicetree changes for 5.4, round two
Message-ID: <CACPK8Xdp4gVuetmiu2bRTTH6oHhRrC7FELHWKVB2ZGSbPbH7HQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM maintainers,

Here are some late fixes I collected for the ASPEED boards.

I've thrown the commits on top of the ones in the first pull request, which
you've merged. I've not sent a second pull before so if that's not the done
thing then let me know what you prefer.

The following changes since commit 49b0f3be0b86292eed6f6aedadf4252131d9c111:

  ARM: dts: aspeed: swift: Add eMMC device (2019-08-22 15:34:20 +0930)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
      tags/aspeed-5.4-devicetree-2

for you to fetch changes up to 89b97c429e2e77d695b5133572ca12ec256a4ea4:

  ARM: dts: aspeed-g5: Fixe gpio-ranges upper limit (2019-09-04 17:34:34 -0700)

----------------------------------------------------------------
ASPEED device tree updates for 5.4, second round

 - Alternate flash support for Vesnin
 - Minor cleanups and fixes

----------------------------------------------------------------
Eddie James (1):
      ARM: dts: aspeed: swift: Change power supplies to version 2

Ivan Mikhaylov (2):
      ARM: dts: aspeed: vesnin: Add wdt2 with alt-boot option
      ARM: dts: aspeed: vesnin: Add secondary SPI flash chip

Joel Stanley (2):
      ARM: dts: aspeed-g4: Add all flash chips
      ARM; dts: aspeed: mihawk: File should not be executable

Oscar A Perez (1):
      ARM: dts: aspeed-g5: Fixe gpio-ranges upper limit

 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts |  0
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts  |  4 ++--
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 10 ++++++++++
 arch/arm/boot/dts/aspeed-g4.dtsi            | 20 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi            |  2 +-
 5 files changed, 33 insertions(+), 3 deletions(-)
 mode change 100755 => 100644 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
