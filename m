From: Joel Stanley <joel@jms.id.au>
Date: Mon, 19 Aug 2019 14:47:36 +0930
Subject: [PATCH v2 0/2] watchdog: aspeed: Add support for ast2600
Message-ID: <20190819051738.17370-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

Here's a small patch series to enable the ast2600 watchdog.

v2 addresses Guenter's review.

Joel Stanley (1):
  dt-bindings: watchdog: Add ast2600 compatible

Ryan Chen (1):
  watchdog: aspeed: Add support for AST2600

 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 1 +
 drivers/watchdog/aspeed_wdt.c                             | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.23.0.rc1

