From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Oct 2019 22:05:22 +1030
Subject: [PATCH 1/2] dt-bindings: clock: Add AST2500 RMII RCLK definitions
In-Reply-To: <20191008113523.13601-1-andrew@aj.id.au>
References: <20191008113523.13601-1-andrew@aj.id.au>
Message-ID: <20191008113523.13601-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2500 has an explicit gate for the RMII RCLK for each of the two
MACs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 include/dt-bindings/clock/aspeed-clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/aspeed-clock.h b/include/dt-bindings/clock/aspeed-clock.h
index f43738607d77..64e245fb113f 100644
--- a/include/dt-bindings/clock/aspeed-clock.h
+++ b/include/dt-bindings/clock/aspeed-clock.h
@@ -39,6 +39,8 @@
 #define ASPEED_CLK_BCLK			33
 #define ASPEED_CLK_MPLL			34
 #define ASPEED_CLK_24M			35
+#define ASPEED_CLK_GATE_MAC1RCLK	36
+#define ASPEED_CLK_GATE_MAC2RCLK	37
 
 #define ASPEED_RESET_XDMA		0
 #define ASPEED_RESET_MCTP		1
-- 
2.20.1

