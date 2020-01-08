From: Joel Stanley <joel@jms.id.au>
Date: Wed, 8 Jan 2020 02:55:04 +0000
Subject: [GIT PULL] aspeed: device tree fixes for 5.5
Message-ID: <CACPK8XcjazgORXNZBU1ECMukXG4HA8D9VeDxiSPifDk_iB7_dw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello arm maintainers,

Here are some fixes for some device tree mistakes that went in during
the 5.5 merge window.

The following changes since commit ffcdc5df08bfc4f418693b22cf2a1182de3375b4:

  ARM: dts: aspeed: rainier: Fix fan fault and presence (2020-01-08
12:51:03 +1030)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-5.5-devicetree-fixes

for you to fetch changes up to ffcdc5df08bfc4f418693b22cf2a1182de3375b4:

  ARM: dts: aspeed: rainier: Fix fan fault and presence (2020-01-08
12:51:03 +1030)

----------------------------------------------------------------
ASPEED device tree fixes for 5.5

Fixes for some badly applied patches that went in to 5.5. There is also
a fix for an incorrect i2c address.

----------------------------------------------------------------

Brandon Wyman (1):
      ARM: dts: aspeed: rainier: Fix fan fault and presence

Joel Stanley (5):
      ARM: dts: aspeed-g6: Fix FSI master location
      ARM: dts: aspeed: tacoma: Fix fsi master node
      ARM: dts: aspeed: tacoma: Remove duplicate i2c busses
      ARM: dts: aspeed: tacoma: Remove duplicate flash nodes
      ARM: dts: aspeed: rainier: Remove duplicate i2c busses
