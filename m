From: Joel Stanley <joel@jms.id.au>
Date: Sun, 25 Aug 2019 14:09:57 +0000
Subject: [GIT PULL] ARM: aspeed: arch changes for 5.4
Message-ID: <CACPK8Xc1aSp5fXL3cEzC9SJsCXG2JwsSPpQrW3a09dkvhCyHHA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello ARM Maintainers,

Here's my first mach-aspeed pull request. We finally had to add some
code here to support SMP on the shiny new ASPEED AST2600.

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git \
    tags/aspeed-5.4-arch

for you to fetch changes up to 87dfe49691a3aefd66ebe76a4a0cc9e872d2587b:

  ARM: aspeed: Enable SMP boot (2019-08-25 23:26:52 +0930)

----------------------------------------------------------------
ASPEED architecture updates for 5.4

This adds support for the new ASPEED AST2600 BMC SoC.

----------------------------------------------------------------
Joel Stanley (4):
      dt-bindings: arm: cpus: Add ASPEED SMP
      ARM: aspeed: Select timer in each SoC
      ARM: aspeed: Add ASPEED AST2600 architecture
      ARM: aspeed: Enable SMP boot

 Documentation/devicetree/bindings/arm/cpus.yaml |  1 +
 arch/arm/Makefile                               |  1 +
 arch/arm/mach-aspeed/Kconfig                    | 17 ++++++-
 arch/arm/mach-aspeed/Makefile                   |  5 ++
 arch/arm/mach-aspeed/platsmp.c                  | 61 +++++++++++++++++++++++++
 5 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-aspeed/Makefile
 create mode 100644 arch/arm/mach-aspeed/platsmp.c
