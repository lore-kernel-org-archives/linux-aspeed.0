From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Oct 2019 12:37:53 +1030
Subject: [PATCH v2 0/3] net: ftgmac100: Ungate RCLK for RMII on ASPEED MACs
Message-ID: <20191010020756.4198-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series slightly extends the devicetree binding and driver for the
FTGMAC100 to describe an optional RMII RCLK gate in the clocks property.
Currently it's necessary for the kernel to ungate RCLK on the AST2600 in NCSI
configurations as u-boot does not yet support NCSI (which uses the
R(educed)MII).

v2:
* Clear up Reduced vs Reversed MII in the cover letter
* Mitigate anxiety in the commit message for 1/3 
* Clarify that AST2500 is also affected in the clocks property description in
  2/3
* Rework the error paths and update some comments in 3/3

v1 can be found here: https://lore.kernel.org/netdev/20191008115143.14149-1-andrew at aj.id.au/

Please review!

Andrew

Andrew Jeffery (3):
  dt-bindings: net: ftgmac100: Document AST2600 compatible
  dt-bindings: net: ftgmac100: Describe clock properties
  net: ftgmac100: Ungate RCLK for RMII on ASPEED MACs

 .../devicetree/bindings/net/ftgmac100.txt     |  8 +++
 drivers/net/ethernet/faraday/ftgmac100.c      | 50 +++++++++++++++----
 2 files changed, 48 insertions(+), 10 deletions(-)

-- 
2.20.1

