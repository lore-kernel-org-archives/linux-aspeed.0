From: Rashmica Gupta <rashmica.g@gmail.com>
Date: Fri,  6 Sep 2019 16:25:10 +1000
Subject: [PATCH v3 0/5] Add ast2600 gpio support
Message-ID: <20190906062510.13191-1-rashmica.g@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v3: Different ordering of patches, using ngpio property to distinguish between
the two ast2600 gpio controllers, fixed typos of 3.6V.

v2: More verbose commit messages, using DIV_ROUND_UP().

Rashmica Gupta (5):
  dt-bindings: gpio: aspeed: Update documentation with ast2600
    controllers
  gpio/aspeed: Fix incorrect number of banks
  gpio/aspeed: Setup irqchip dynamically
  gpios: Use ngpio property from device tree if available
  gpio: Add in ast2600 details to Aspeed driver

 drivers/gpio/gpio-aspeed.c                    | 52 ++++++++++++-------
 .../devicetree/bindings/gpio/gpio-aspeed.txt  |  7 ++-
 2 files changed, 39 insertions(+), 20 deletions(-)

-- 
2.20.1

