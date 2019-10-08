From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Oct 2019 22:05:51 +1030
Subject: [PATCH 0/2] clk: ast2600: Expose RMII RCLK for MACs 1-4
Message-ID: <20191008113553.13662-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series is similar to that for the AST2500 but I've split the patches out
as the AST2600 driver is new for 5.4 and I'm hoping we have a chance of
slipping them in. Maybe we can get both series in, but I thought decoupling
them might make it more manageable if not.

Regardless, the blurb:

This series is two small changes enable kernel support for controlling the RMII
RCLK gate on AST2600-based systems. RMII is commonly used for NCSI, which
itself is commonly used for BMC-based designs to reduce cabling requirements
for the platform. NCSI support for the AST2600 is not yet implemented in
u-boot and so unlike the AST2500 the kernel can't rely on RCLK already being
ungated.

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
  clk: ast2600: Add RMII RCLK gates for all four MACs

 drivers/clk/clk-ast2600.c                 | 47 ++++++++++++++++++++++-
 include/dt-bindings/clock/ast2600-clock.h |  5 +++
 2 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.20.1

