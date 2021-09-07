From: Steven Lee <steven_lee@aspeedtech.com>
Date: Tue, 7 Sep 2021 17:55:24 +0800
Subject: [PATCH -next v1 0/1] gpio-aspeed-sgpio: Fix irq handling issue.
Message-ID: <20210907095525.24668-1-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

SGPIO input/output pin order was changed, thus hwirq should be calculated
based on the new GPIO pin order.
This patch series contains a patch for fixing wrong hwirq in irq handler.

Please help to review.

Thanks,
Steven

Steven Lee (1):
  gpio: gpio-aspeed-sgpio: Fix wrong hwirq in irq handler.

 drivers/gpio/gpio-aspeed-sgpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.17.1

