From: Steven Lee <steven_lee@aspeedtech.com>
Date: Tue, 14 Dec 2021 12:02:37 +0800
Subject: [PATCH v1 0/1] gpio: gpio-aspeed-sgpio: Fix wrong hwirq base in irq
Message-ID: <20211214040239.8977-1-steven_lee@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Each aspeed sgpio bank has 64 gpio pins(32 input pins and 32 output pins)
The hwirq base for each sgpio bank should be multiples of 64 rather than
multiples of 32.

This patch series contains a patch for fixing wrong hwirq base in
irq handler.

Please help to review.

Steven Lee (1):
  gpio: gpio-aspeed-sgpio: Fix wrong hwirq base in irq handler

 drivers/gpio/gpio-aspeed-sgpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.17.1

