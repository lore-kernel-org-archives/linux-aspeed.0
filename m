From: Joel Stanley <joel@jms.id.au>
Date: Fri, 29 Nov 2019 10:38:25 +1030
Subject: [PATCH v2 0/2] reset: Add ast2600 support
Message-ID: <20191129000827.650566-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series adds ast2600 support to the reset-simple driver, and updates
the device tree documentation for the LPC bindings.

v2 fixes a typo in the bindings that Andrew found.

Brad Bishop (1):
  reset: simple: Add AST2600 compatibility string

Joel Stanley (1):
  dt-bindings: mfd: Add ast2600 to ASPEED LPC

 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 11 +++++++++--
 drivers/reset/reset-simple.c                         |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.24.0

