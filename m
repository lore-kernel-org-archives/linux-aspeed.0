From: Eddie James <eajames@linux.ibm.com>
Date: Tue,  1 Nov 2022 15:53:36 -0500
Subject: [PATCH v2 0/2] watchdog: aspeed: Add pre-timeout interrupt support
Message-ID: <20221101205338.577427-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the core pre-timeout interrupt on AST2500 and AST2600.

Changes since v1:
 - Use watchdog core support for pre-timeout interrupt, rather than new
   dts property

Eddie James (2):
  watchdog: aspeed: Enable pre-timeout interrupt
  ARM: dts: aspeed: Setup watchdog pre-timeout interrupt

 arch/arm/boot/dts/aspeed-g5.dtsi |   3 +
 arch/arm/boot/dts/aspeed-g6.dtsi |   4 ++
 drivers/watchdog/aspeed_wdt.c    | 104 ++++++++++++++++++++++++++-----
 3 files changed, 95 insertions(+), 16 deletions(-)

-- 
2.31.1

