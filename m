From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue,  8 Oct 2019 22:05:52 +1030
Subject: [PATCH 1/2] dt-bindings: clock: Add AST2600 RMII RCLK gate definitions
In-Reply-To: <20191008113553.13662-1-andrew@aj.id.au>
References: <20191008113553.13662-1-andrew@aj.id.au>
Message-ID: <20191008113553.13662-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 has an explicit gate for the RMII RCLK for each of the four
MACs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 include/dt-bindings/clock/ast2600-clock.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 38074a5f7296..ac567fc84a87 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -84,6 +84,11 @@
 #define ASPEED_CLK_MAC34		65
 #define ASPEED_CLK_USBPHY_40M		66
 
+#define ASPEED_CLK_GATE_MAC1RCLK	67
+#define ASPEED_CLK_GATE_MAC2RCLK	68
+#define ASPEED_CLK_GATE_MAC3RCLK	69
+#define ASPEED_CLK_GATE_MAC4RCLK	70
+
 /* Only list resets here that are not part of a gate */
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
-- 
2.20.1

