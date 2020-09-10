From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 10 Sep 2020 10:18:36 -0500
Subject: [PATCH 0/4] clk: AST2600 and FSI: Add APLL to control FSI bus
 frequency
Message-ID: <20200910151840.25333-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add functionality to control the APLL clock on the AST2600. The APLL provides
the clock for the FSI master on the AST2600. Then add a devicetree property to
set the AST2600 FSI master bus frequency.

Eddie James (4):
  dt-bindings: clock: Add AST2600 APLLdivN definition
  clk: ast2600: Add functionality to the APLL clock
  dt-bindings: fsi: Aspeed master: Add bus-frequency property
  fsi: Aspeed master: Set bus frequency from devicetree

 .../bindings/fsi/fsi-master-aspeed.txt        |   1 +
 drivers/clk/clk-ast2600.c                     | 177 ++++++++++++++++--
 drivers/fsi/fsi-master-aspeed.c               |   5 +
 include/dt-bindings/clock/ast2600-clock.h     |   1 +
 4 files changed, 172 insertions(+), 12 deletions(-)

-- 
2.26.2

