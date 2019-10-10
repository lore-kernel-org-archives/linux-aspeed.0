From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 10 Oct 2019 12:36:53 +1030
Subject: [PATCH v2 0/2] clk: aspeed: Expose RMII RCLK gate for MACs 1-2 on
 AST2500
Message-ID: <20191010020655.3776-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series is two small changes enable kernel support for controlling the RMII
RCLK gate on AST2500-based systems. Previously the kernel has assumed u-boot
has ungated RCLK for networking to function.

RMII is commonly used for NCSI, which itself is commonly used for BMC-based
designs to reduce cabling requirements for the platform.

v2:
* Rename macros and clock names based on Joel's feedback.

v1 can be found here: https://lore.kernel.org/linux-clk/20191008113523.13601-1-andrew at aj.id.au/

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: clock: Add AST2500 RMII RCLK definitions
  clk: aspeed: Add RMII RCLK gates for both AST2500 MACs

 drivers/clk/clk-aspeed.c                 | 27 +++++++++++++++++++++++-
 include/dt-bindings/clock/aspeed-clock.h |  2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.20.1

