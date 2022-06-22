From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 22 Jun 2022 11:42:31 +0200
Subject: [PATCH v2 0/2] spi: aspeed: Fix division by zero
Message-ID: <20220622094233.3681843-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

Here is a small series adding some debug and fixing a division by zero
on a board using normal speed reads.

Thanks,

C.


C?dric Le Goater (2):
  spi: aspeed: Add pr_debug in aspeed_spi_dirmap_create()
  spi: aspeed: Fix division by zero

 drivers/spi/spi-aspeed-smc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.35.3

