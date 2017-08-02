From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed,  2 Aug 2017 14:15:27 +0930
Subject: [PATCH 0/2] watchdog: aspeed: External reset signal properties
Message-ID: <20170802044529.30032-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This two-patch series builds on top of Chris Bostic's changes introducing the
aspeed,external-signal devicetree property (currently v5):

    https://lkml.org/lkml/2017/7/17/777

Additional characteristics such as pulse width, push-pull vs open-drain driving
and active high or low polarity can be configured. This short series defines
optional properties to do so, and adds support to the driver.

Cheers,

Andrew

Andrew Jeffery (2):
  dt-bindings: watchdog: aspeed: External reset signal properties
  watchdog: aspeed: Support configuration of external signal properties

 .../devicetree/bindings/watchdog/aspeed-wdt.txt    |  10 +-
 drivers/watchdog/aspeed_wdt.c                      | 105 ++++++++++++++++++++-
 2 files changed, 111 insertions(+), 4 deletions(-)

-- 
2.11.0

