From: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
Date: Wed, 2 Oct 2019 14:11:58 +0800
Subject: [PATCH 0/2] peci: aspeed: Add AST2600 compatible
Message-ID: <20191002061200.29888-1-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update the Aspeed PECI driver with the AST2600 compatible string.
A new comptabile string is needed for the extended HW feature of
AST2600.

Chia-Wei, Wang (2):
  peci: aspeed: Add AST2600 compatible string
  dt-bindings: peci: aspeed: Add AST2600 compatible

 Documentation/devicetree/bindings/peci/peci-aspeed.txt | 1 +
 drivers/peci/peci-aspeed.c                             | 1 +
 2 files changed, 2 insertions(+)

-- 
2.17.1

