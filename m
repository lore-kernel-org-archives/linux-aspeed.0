From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 21 Oct 2022 10:15:57 -0500
Subject: [PATCH 0/2] watchdog: aspeed: Add pre-timeout interrupt support
Message-ID: <20221021151559.781983-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable the pre-timeout interrupt if requested by device property, and
document that property.

Eddie James (2):
  watchdog: aspeed: Add pre-timeout interrupt support
  dt-bindings: watchdog: aspeed: Document aspeed,pre-timeout-irq-us

 .../bindings/watchdog/aspeed-wdt.txt          |  7 ++-
 drivers/watchdog/aspeed_wdt.c                 | 53 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 3 deletions(-)

-- 
2.31.1

