From: Rashmica Gupta <rashmica.g@gmail.com>
Date: Thu,  5 Sep 2019 11:16:00 +1000
Subject: [PATCH v2 0/4] Add ast2600 gpio support 
Message-ID: <20190905011600.15821-1-rashmica.g@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v2: More verbose commit messages, using DIV_ROUND_UP().

Rashmica Gupta (4):
  gpio/aspeed: Fix incorrect number of banks
  gpio/aspeed: Setup irqchip dynamically
  gpio: Add in ast2600 details to Aspeed driver
  gpio: dt-bindings: Update documentation with ast2600 controllers

 drivers/gpio/gpio-aspeed.c                    | 48 ++++++++++++++-----
 .../devicetree/bindings/gpio/gpio-aspeed.txt  |  3 +-
 2 files changed, 38 insertions(+), 13 deletions(-)

-- 
2.20.1

