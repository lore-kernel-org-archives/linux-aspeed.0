From: Joel Stanley <joel@jms.id.au>
Date: Wed,  4 Oct 2017 19:46:33 +1030
Subject: [PATCH 0/2] ARM: dts: aspeed: Watchdog fixes
Message-ID: <20171004091635.12499-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A cleanup and a change in the default behaviour for the watchdog nodes to match
what is required to boot with commonly shipped u-boots.

Joel Stanley (2):
  ARM: dts: aspeed: Remove undocumented wdt properties
  ARM: dts: aspeed: Enable watchdog two

 arch/arm/boot/dts/aspeed-g4.dtsi | 8 ++------
 arch/arm/boot/dts/aspeed-g5.dtsi | 9 +++------
 2 files changed, 5 insertions(+), 12 deletions(-)

-- 
2.14.1

